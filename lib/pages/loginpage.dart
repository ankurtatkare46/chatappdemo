import 'package:chatappdemo/components/my_button.dart';
import 'package:chatappdemo/components/my_text_field.dart';
import 'package:chatappdemo/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController =TextEditingController();
  final passwordController = TextEditingController();


  void signIn() async {
//get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await  authService.signWithEmailandPassword(emailController.text, passwordController.text);
    }catch (e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const SizedBox(height: 50,),
               // logo

                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),

                //welcome back message

                const SizedBox(height: 50,),

                const Text("Welcome back you\'ve been missed!",
                style: TextStyle(fontSize: 16
                ),
                ),
                const SizedBox(height: 25,),

                //email textfield
                MyTextField(controller: emailController, hintText: "Email", obscureText: false),
                //password textfield
                const SizedBox(height: 10,),

                MyTextField(controller: passwordController, hintText: "Password", obscureText: true),

    //sign in button

                const SizedBox(height: 25,),

                MyButton(onTap: (){
                  signIn();
                },text:'Sign In' ),
                const SizedBox(height: 50,),
                //not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                     SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Register now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

