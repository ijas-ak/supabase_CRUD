import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:supabase_basics/supabase/services/supabase_services.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();

    //supabase instance

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Sign In"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            //email field
            TextField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Email",
              ),
            ),
            SizedBox(height: 25),

            //password field
            TextField(
              controller: password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Password",
              ),
            ),
            SizedBox(height: 25),
            //sign in button
            GestureDetector(
              onTap: () {
                SupabaseServices().signUpSupa(
                  email.text,
                  password.text,
                  context,
                );
              },
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text("Sign Up")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
