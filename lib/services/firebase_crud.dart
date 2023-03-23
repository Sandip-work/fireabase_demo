
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


final db = FirebaseFirestore.instance;
DocumentReference? documentReference;

 Future<void> addStudent({
  required String name,
  required String enrollNo,
  required String age,
  required String email,
}) async {
   await db.collection("students").add({
     'enrollmentNumber': enrollNo,
     'StudentName': name,
     'age': age,
     'Email': email,
   }).then((documentReference) {
     if (kDebugMode) {
       print(documentReference.id);
     }
   });

   Future<void> updateStudent({
     required String name,
     required String enrollNo,
     required String age,
     required String email,
   }) async {
     await db.collection("students").doc().update({
       'enrollmentNumber': enrollNo,
       'StudentName': name,
       'age': age,
       'Email': email,
     }).then((documentReference) {
       print(name);
     });
   }
 }

 Future<void> deleteStudent(String name) async{
   db.collection("students").doc(name).delete();

  // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text("You have successfully deleted a  student")));
 }

