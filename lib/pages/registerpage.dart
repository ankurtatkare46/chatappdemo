import 'package:chatappdemo/components/my_button.dart';
import 'package:chatappdemo/components/my_text_field.dart';
import 'package:chatappdemo/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController =TextEditingController();
  final passwordController = TextEditingController();
  final cnfpasswordController = TextEditingController();

  void signUp() async{
    if(passwordController.text != cnfpasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password do not match!'),),
      );
      // return;
    }else {
      //get the auth service
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signUpWithEmailandPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())));
      }
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

                const Text("Let's create an account for you!",
                  style: TextStyle(fontSize: 16
                  ),
                ),
                const SizedBox(height: 25,),

                //email textfield
                MyTextField(controller: emailController, hintText: "Email", obscureText: false),
                //password textfield
                const SizedBox(height: 10,),

                MyTextField(controller: passwordController, hintText: "Password", obscureText: true),
                const SizedBox(height: 10,),

                //confirm password
                MyTextField(controller: cnfpasswordController, hintText: "Confirm Password", obscureText: true),


                //sign in button

                const SizedBox(height: 25,),

                MyButton(onTap: (){
                  signUp();
                },text:'Sign Up' ),
                const SizedBox(height: 50,),
                //not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member?'),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Login now',
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


