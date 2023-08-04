import 'package:chatappdemo/pages/loginpage.dart';
import 'package:chatappdemo/pages/registerpage.dart';
import 'package:chatappdemo/services/auth/auth_gate.dart';
import 'package:chatappdemo/services/auth/auth_service.dart';
import 'package:chatappdemo/services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  runApp(
      // const MyApp()
    ChangeNotifierProvider(create: (context) => AuthService(),
      child:  const MyApp(),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home:  LoginPage(),
      // home:  RegisterPage(),
      // home:  LoginOrRegister(),
      home:  AuthGate(),
    );
  }
}


