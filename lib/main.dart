import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_emailpass/pages/login.dart';
import 'package:flutter_fb_auth_emailpass/pages/user/user_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            title: 'Smart Recharge',
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            debugShowCheckedModeBanner: false,
            home:FirebaseAuth.instance.currentUser!=null?UserMain(): Login(),
          );
        });
  }
}
