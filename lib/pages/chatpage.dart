import 'package:chatappdemo/components/chat_bubble.dart';
import 'package:chatappdemo/components/my_text_field.dart';
import 'package:chatappdemo/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({Key? key,  required this.receiverUserEmail,required this.receiverUserID,}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    // only send a message if there is something to send
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      //clear the controller after sending the message
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: _buildMessageList(),
            ),
            _buildMessageInput(),
            const SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }

  //build message list


  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),

        builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading.....');
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
        }
        );
  }






// build message item


  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String,dynamic>;

    //align the message to the right if the sender is the current user ,otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
    ?Alignment.centerRight
        :Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:(data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            :CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? MainAxisAlignment.end
            :MainAxisAlignment.start,
        children: [
          Text(data['senderEmail']),
          const SizedBox(height: 5,),
          ChatBubble(message: data['message'],sender: (data['senderId'] == _firebaseAuth.currentUser!.uid)?true:false),
        ],
      ),
    );
  }





//build message input

Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(child: MyTextField(
            controller: _messageController,
            hintText: 'Enter Message',
            obscureText: false,

          ),
          ),
          IconButton(onPressed: () {sendMessage();}, icon: Icon(Icons.arrow_upward,size: 40,),)
        ],
      ),
    );
}


}
