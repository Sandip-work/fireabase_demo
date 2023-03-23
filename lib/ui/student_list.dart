import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/services/firebase_crud.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/student.dart';

class StudentList extends StatefulWidget {

   final String enrollNo;
   final String name;
   final String age;
   final String email;

   const StudentList({super.key,
     required this.enrollNo,
     required this.name,
     required this.age,
     required this.email,
   });

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 100,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                //child: Image.network(
                 // widget.imageUrl,
                 // fit: BoxFit.cover,
                //),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(" ${widget.enrollNo}",
                            style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                        //  editProduct();
                        },
                        icon:
                             const Icon(
                          Icons.favorite,
                          color: Colors.greenAccent,
                        )
                      ),
                      IconButton(
                        onPressed: () {
                          //deleteStudent(widget.documentSnapshot);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}