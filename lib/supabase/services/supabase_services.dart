import 'package:flutter/material.dart';
import 'package:supabase_basics/pages/home_page.dart';
import 'package:supabase_basics/pages/sign_in_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  //signing up

  final supabase = Supabase.instance.client;

  Future signUpSupa(String email, String password, context) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
      await Supabase.instance.client.from("users").insert({
        "body": email.replaceAll("@gmail.com", ""),
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //sign in method
  Future signIn(String email, String password, context) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //users adding to supabase database
  Future addDataToSupa(String user) async {
    await Supabase.instance.client.from("users").insert({"body": user});
  }

  Future deleteUser(int id) async {
    await Supabase.instance.client.from("users").delete().eq("id", id);
  }

  Future addStudent(String name, String age, String address, context) async {
    try {
      final response = await supabase.from("users").insert({
        "name": name,
        "age": age,
        "address": address,
      });
      return response;
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //delete student from supabase

  Future deleteStudent(int index) async {
    await supabase.from("users").delete().eq("id", index);
  }

  Future updateStudent(String name, String age, String address, int id) async {
    await supabase
        .from("users")
        .update({"name": name, "age": age, "address": address})
        .eq("id", id);
  }

  Future getStudentsData() async {
    try {
      final response = await supabase.from("users").select();
      return response;
    } on Exception catch (e) {
      print("error $e");
    }
  }
}
