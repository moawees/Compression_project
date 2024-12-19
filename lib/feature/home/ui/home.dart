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
                onPressed: () {},
                iconButton: Icons.attach_file),
            SizedBox(height: 20),
            AlgorithmSelector(onAlgorithmSelected: onAlgorithmSelected),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    textButton: "Compress",
                    onPressed: () {},
                    iconButton: null,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: CustomButton(
                    textButton: "Download",
                    onPressed: () {},
                    iconButton: null,
                  ),
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
                    onPressed: () {},
                    iconButton: null,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: CustomButton(
                    textButton: "Download",
                    onPressed: () {},
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
