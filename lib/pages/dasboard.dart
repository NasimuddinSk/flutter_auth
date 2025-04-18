import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_auth/pages/services/api_services.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatelessWidget {
  final String? message;
  const Dashboard({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(message == null ? "Wellcome to Dashboard" : message!),
                  ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text("Pick Image"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Upload Image"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List bytes = await image.readAsBytes();
      print(bytes);
    }
  }
}
