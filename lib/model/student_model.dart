class Student {
  int? id;
  String name;
  String age;
  String address;

  Student({
    required this.name,
    required this.age,
    required this.address,
    this.id,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json["name"],
      age: json["age"],
      address: json["address"],
      id: json["id"],
    );
  }
}
