import 'dart:io';

import 'package:comp/core/functions/api_handler.dart';
import 'package:comp/feature/home/ui/widgets/algorithm_selector.dart';
import 'package:comp/feature/home/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedFile;
  String? selectedAlgorithm;

  void onAlgorithmSelected(String algorithm) {
    setState(() {
      selectedAlgorithm = algorithm;
    });
  }

  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset("assets/image/comp.webp"),
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            CustomButton(
                textButton: "Upload Your File",
                onPressed: () async {
                  file = await uploadFile();
                  if (file != null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("successfully uploaded")));
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("faild uploading")));
                  }
                },
                iconButton: Icons.attach_file),
            SizedBox(height: 20),
            AlgorithmSelector(onAlgorithmSelected: onAlgorithmSelected),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    textButton: "Compress",
                    onPressed: () async {
                      if (file != null && selectedAlgorithm != null) {
                        await compressFile(file!, selectedAlgorithm!);
                      }
                    },
                    iconButton: null,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    textButton: "Decompress",
                    onPressed: () async {
                      if (file != null && selectedAlgorithm != null) {
                        await decompressFile(file!, selectedAlgorithm!);
                      }
                    },
                    iconButton: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
