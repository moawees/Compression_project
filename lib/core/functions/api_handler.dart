import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
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
      // Process the response and save it as a file
      final String responseBody = response.data;
      // Adjust based on API response

      await _saveResponseToFile(responseBody, isCompress: isCompress);
    } else {
      print(
          'Failed to ${isCompress ? 'compress' : 'decompress'} file. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> _saveResponseToFile(String binaryData,
    {required bool isCompress}) async {
  final directory = await getApplicationDocumentsDirectory();
  final String fileName = isCompress ? 'compressed.txt' : 'decompressed.txt';
  final File outputFile = File('${directory.path}/$fileName');
  await outputFile.writeAsString(json.encode(binaryData));
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
