import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Students{

  Students({
      required  this.enrollNo,
      required this.name,
      required this.age,
      required  this.email
  });

  final String? enrollNo;
  final String? name;
  final String? age;
  final String? email;

  factory Students.fromJson(Map<String,dynamic> json) => Students(
    enrollNo: json["Enrollment No"],
    name: json["Name"],
    age: json["Age"],
    email: json["Email"],
  );

  Map<String,dynamic> toJson() => {
    "Enrollment No": enrollNo,
    "Name": name,
    "Age": age,
    "Email": email,
  };

  Students.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : name = doc.data()!["name"],
        age = doc.data()!["age"],
        enrollNo = doc.data()!["Enrollment No"],
         email = doc.data()!["Email"];
}