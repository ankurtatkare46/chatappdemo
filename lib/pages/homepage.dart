import 'package:chatappdemo/pages/chatpage.dart';
import 'package:chatappdemo/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;



  void signOut() async{
    //get auth service
    final authService = Provider.of<AuthService>(context,listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),
      actions: [
        IconButton(onPressed: (){
          signOut();
        }, icon: const Icon(Icons.logout))
      ],),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged in user

Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream : FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return const Text('error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('loading');
        }
        return ListView(
          children:
            snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
  );
}





//build individual user list items

Widget _buildUserListItem(DocumentSnapshot document){
    Map<String , dynamic> data = document.data()! as Map<String,dynamic>;

    //display all users except current user

  if(_auth.currentUser!.email != data ['email']){
    return ListTile(
      title: Text(data['email']),
      onTap: (){
        //pass the clicked users UID to the chat page

        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
            receiverUserID: data['uid'],
            receiverUserEmail: data['email'],
        ),
        ),
        );
      },
    );
  }else{
    // return empty container
    return Container();
  }
}

}
