import 'dart:io';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SeclectImage extends StatefulWidget {
  const SeclectImage({super.key});

  @override
  State<SeclectImage> createState() => _SeclectImageState();
}

class _SeclectImageState extends State<SeclectImage> {
  File? image;
  String? url;

  final ImagePicker picker = ImagePicker();
  uploadImage() async {
    final XFile? imageSelect =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageSelect != null) {
      setState(() {
        image = File(imageSelect.path);
      });
      String nameimage = basename(image!.path);
      Reference ref = FirebaseStorage.instance.ref().child(nameimage);
      print("=============================================================");
      print(ref);
      print("=============================================================");
      await ref.putFile(image!);
      print(await ref.getDownloadURL());
      print("=============================================================");
      String urlimage = await ref.getDownloadURL();

      print("=============================================================");
      setState(() {
        url = urlimage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MaterialButton(
              onPressed: () {
                uploadImage();
              },
              child: const Text("Image"),
            ),
            const SizedBox(
              height: 10,
            ),
            if (image != null)
              SizedBox(
                height: 100,
                width: 100,
                child: url == null
                    ? CircularProgressIndicator()
                    : Image.network(url!),
              )

            // : Image.file(image!)
          ],
        ),
      ),
    );
  }
}
