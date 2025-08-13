import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_basics/pages/sign_in_page.dart';
import 'package:supabase_basics/pages/user_details.dart';
import 'package:supabase_basics/supabase/services/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = TextEditingController();

  final userList = Supabase.instance.client
      .from("users")
      .stream(primaryKey: ["id"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
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
      body: StreamBuilder(
        stream: userList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error in the data"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];

                return ListTile(
                  title: Text(data["body"]),
                  trailing: IconButton(
                    onPressed: () {
                      SupabaseServices().deleteUser(data["id"]);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetails(username: data["body"]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: TextField(controller: userController),
              actions: [
                TextButton(
                  onPressed: () {
                    SupabaseServices().addDataToSupa(userController.text);
                    Navigator.pop(context);
                  },
                  child: Text("save"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
