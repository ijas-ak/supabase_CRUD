import 'package:flutter/material.dart';
import 'package:supabase_basics/model/student_model.dart';
import 'package:supabase_basics/supabase/services/supabase_services.dart';

class StudentProvider extends ChangeNotifier {
  List<Student> students = [];

  Future fetchStudentData() async {
    List<Map<String, dynamic>> datas = await SupabaseServices()
        .getStudentsData();
    students = datas.map((e) => Student.fromJson(e)).toList();

    notifyListeners();
  }

  void addStudent(Student student) {
    students.add(student);
    notifyListeners();
  }

  void deleteStudentFromUi(int id) async {
    await SupabaseServices().deleteStudent(id);
    students.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future updateStudentFromUi(
    String name,
    String age,
    String addess,
    int id,
  ) async {
    await SupabaseServices().updateStudent(name, age, addess, id);
    await fetchStudentData();
    notifyListeners();
  }
}
