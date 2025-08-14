// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_basics/controller/provider.dart';
import 'package:supabase_basics/model/student_model.dart';
import 'package:supabase_basics/pages/sign_in_page.dart';
import 'package:supabase_basics/pages/user_details.dart';
import 'package:supabase_basics/pages/widgets/student_tile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<StudentProvider>(context, listen: false).fetchStudentData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Supabase.instance.client.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(children: [SizedBox(height: 40), StudentTile()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetails(
                student: Student(name: '', age: '', address: ''),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
