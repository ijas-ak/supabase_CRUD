import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_basics/controller/provider.dart';
import 'package:supabase_basics/model/student_model.dart';
import 'package:supabase_basics/supabase/services/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  final Student student;
  const UserDetails({super.key, required this.student});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late final nameController = TextEditingController(text: widget.student.name);
  late final ageController = TextEditingController(text: widget.student.age);
  late final addressController = TextEditingController(
    text: widget.student.address,
  );
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
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ADD DETAILS")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              //student name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "name",
                ),
              ),
              SizedBox(height: 35),

              //student age
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "age",
                ),
              ),
              SizedBox(height: 35),

              //student address
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "address",
                ),
              ),
              SizedBox(height: 35),

              //User image
              userImage.isNotEmpty
                  ? Image.network(userImage, height: 150)
                  : Center(child: Text("No Image selecteed")),
              SizedBox(height: 35),

              //Upload button
              ElevatedButton(
                onPressed: () {
                  uploadFile();
                },
                child: Text("upload image"),
              ),

              SizedBox(height: 20),
              widget.student.name.isEmpty
                  ? Text('')
                  : TextButton(
                      onPressed: () async {
                        context.read<StudentProvider>().updateStudentFromUi(
                          nameController.text,
                          ageController.text,
                          addressController.text,
                          widget.student.id ?? 0,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Updated Successfully!")),
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Update"),
                    ),

              GestureDetector(
                onTap: () {
                  final name = nameController.text;
                  final age = ageController.text;
                  final address = addressController.text;
                  SupabaseServices().addStudent(name, age, address, context);
                  context.read<StudentProvider>().addStudent(
                    Student(name: name, age: age, address: address),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
