import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_emailpass/pages/login.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot
                  .hasError
                  .toString()),
            );
          if(snapshot.connectionState==ConnectionState.waiting)
            return Center(child:CircularProgressIndicator());
          return Column(
            children: [
              SizedBox(height: 10,),
              Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  padding: EdgeInsets.only(top: 12,bottom: 8),
                //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey.shade300),
                  child:
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                           Text('Welcome back '+snapshot.data!['name']+' !',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text('Account balance: \u{20B9} '+snapshot.data!['balance'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text('Email id: '+snapshot.data!['email'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text('Phone #: '+snapshot.data!['phone'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                        SizedBox(height: 30,),
                      ])
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      FirebaseAuth.instance.signOut().whenComplete(() => {
                      Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                      builder: (context) => Login()
                      ),
                      ModalRoute.withName("/Home")
                      )
                      });
                    },
                    child: Text('Log out')) ,
              )
            ],
          );
        },
      ),
    );
  }
}
