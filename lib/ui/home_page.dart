import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/student.dart';
import 'package:untitled/services/firebase_crud.dart';
 import 'package:untitled/ui/add_user.dart';
// import 'package:firestoredatabase/productItem.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/student_list.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class HomePage extends StatefulWidget {
  //static const routeName = 'homePage';

  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String id;
  Connectivity connectivity = Connectivity();
  bool hasConnection = false;
  ConnectivityResult? connectionMedium;
  StreamController<bool> connectionChangeController = StreamController.broadcast();
  Stream<bool> get connectionChange => connectionChangeController.stream;
  connectivityService(){
    checkInternetConnection();
  }
  Future<bool> checkInternetConnection()async{
    bool previousConnection = hasConnection;
    try{
      final result = await InternetAddress.lookup('google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        hasConnection = true;
      }else{
        hasConnection= false;
      }
    } on SocketException catch (_){
      hasConnection = false;
    }
    if(previousConnection != hasConnection){
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: Icon(
                      Icons.list,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 30),
                    child: Text(
                      "Drawer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.orangeAccent,
              ),
              title: const Text(
                "Home Page",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()
                    )
                );
              },
            ),
            const Divider(
              height: 10,
              color: Colors.black,
              indent: 65,
            ),
            ListTile(
              leading: const Icon(
                Icons.add_box,
                color: Colors.orangeAccent,
              ),
              title: const Text(
                "Add Students ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  AddUser()
                    )
                );
              },
            ),
            const Divider(
              height: 10,
              indent: 65,
              color: Colors.black,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("STUDENTS LIST"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("students").get(),
        builder: (context, snapshot) {
          if(snapshot.data != null) {
            log("snapshot: ${snapshot.data!.docs.toString()}");
          }else{
            log("snapshot: is empty");
          }
          //List<Students> newList = List<Students>.from(snapshot.data!.docs.toList());
          return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];

              log("data:$data" );
               var id = data.reference.id;
               log('id $id');

               return StudentList(
                 name: data['StudentName'],
                 enrollNo: data['enrollmentNumber'],
                 age: data['age'],
                 email: data['Email'],);
            },
          );
        },
      ),
    );
  }
}