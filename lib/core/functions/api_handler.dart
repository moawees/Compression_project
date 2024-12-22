import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';

Future<void> compressFile(File file, String algorithm) async {
  await _handleFile(file, algorithm, isCompress: true);
}

Future<void> decompressFile(File file, String algorithm) async {
  await _handleFile(file, algorithm, isCompress: false);
}

Future<void> _handleFile(File file, String algorithm,
    {required bool isCompress}) async {
  try {
    final String url =
        'http://10.0.2.2:5000/${isCompress ? 'compress' : 'decompress'}';
    final Dio dio = Dio();

    // Create form data with the file and algorithm
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
      'algorithm': algorithm,
    });

    // Send the POST request
    final Response response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = response.data;
      if (isCompress) {
        final String binaryData =
            responseBody['binary']; // Adjust based on API response
        final Map<String, String> encodingMap =
            Map<String, String>.from(responseBody['encoding']);

        await _saveResponseToFile(binaryData, encodingMap,
            isCompress: isCompress);
      } else {
        final fileContent = responseBody["decompressed"];
        await _saveResponseToFile(fileContent, {}, isCompress: isCompress);
      }
    } else {
      print(
          'Failed to ${isCompress ? 'compress' : 'decompress'} file. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _saveResponseToFile(
    String binaryData, Map<String, String> encodingMap,
    {required bool isCompress}) async {
  final downloadsDirectory =
      await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
  dynamic content;
  if (isCompress) {
    content = {
      'binary': binaryData,
      'encoding': encodingMap,
    };
  } else {
    content = binaryData;
  }

  final String fileName = isCompress ? 'compressed.txt' : 'decompressed.txt';
  final File outputFile = File('$downloadsDirectory/$fileName');
  await outputFile.writeAsString(json.encode(content));
  print('File saved at: ${outputFile.path}');
}

Future<File?> uploadFile() async {
  try {
    // Open file picker to let the user select a file
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      // Get the selected file
      File file = File(result.files.single.path!);
      print('File processed successfully.');

      return file;
    } else {
      print('File selection canceled.');
      return null;
    }
  } catch (e) {
    print('Error during file upload: $e');
    return null;
  }
}
