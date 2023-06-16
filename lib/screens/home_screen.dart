import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_storage_firebase/services/select_image.dart';
import 'package:flutter_storage_firebase/services/upload_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageUpload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Storage'),
      ),
      body: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            imageUpload != null
                ? Image.file(imageUpload!)
                : Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                  ),
            ElevatedButton(
              onPressed: () async {
                final imagen = await getImage();
                setState(() {
                  imageUpload = File(imagen!.path);
                });
              },
              child: Text('Select image'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (imageUpload == null) {
                  return;
                }
                final uploaded = await uploadImage(imageUpload!);

                if (uploaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Complete Image, OK!')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error upload Image')));
                }
              },
              child: Text('Upload image'),
            ),
          ]),
        ),
      ),
    );
  }
}
