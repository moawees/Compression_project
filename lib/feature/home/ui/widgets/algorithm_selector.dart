import 'package:flutter/material.dart';

class AlgorithmSelector extends StatefulWidget {
  final Function(String) onAlgorithmSelected;

  const AlgorithmSelector({required this.onAlgorithmSelected});

  @override
  _AlgorithmSelectorState createState() => _AlgorithmSelectorState();
}

class _AlgorithmSelectorState extends State<AlgorithmSelector> {
  final List<String> algorithms = ['Huffman', 'LZW', 'RLE', 'Arithmetic'];
  String? selectedAlgorithm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:100,
      width: 300,
      child: DropdownButtonFormField<String>(
        value: selectedAlgorithm,
        items: algorithms.map((algorithm) {
          return DropdownMenuItem(
            value: algorithm,
            child: Text(algorithm),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedAlgorithm = value;
          });
          widget.onAlgorithmSelected(value!);
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.circular(10)),
          labelText: 'Select Compression Algorithm',
          border: OutlineInputBorder()
                  ),
      ),
    );
  }
}
