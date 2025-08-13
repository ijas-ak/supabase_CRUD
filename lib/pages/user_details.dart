import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDetails extends StatefulWidget {
  final String username;
  const UserDetails({super.key, required this.username});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String userImage = '';

  Future uploadFile() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final file = File(image!.path);
    final imagePath = '${DateTime.now().millisecondsSinceEpoch}.png';
    final response = await Supabase.instance.client.storage
        .from("users")
        .upload(imagePath, file);

    if (response.isNotEmpty) {
      final publicUrl = Supabase.instance.client.storage
          .from("users")
          .getPublicUrl(imagePath);
      setState(() {
        userImage = publicUrl;
      });
      print(userImage);
    } else {
      print("error uploading $response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //User image
            userImage.isNotEmpty
                ? Image.network(userImage, height: 300)
                : Center(child: Text("No Image selecteed")),

            //Upload button
            ElevatedButton(
              onPressed: () {
                uploadFile();
              },
              child: Text("upload image"),
            ),
          ],
        ),
      ),
    );
  }
}
