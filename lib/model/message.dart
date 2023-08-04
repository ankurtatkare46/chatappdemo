class Message {

  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final String timeStamp;

  Message({
    required  this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required  this.timeStamp
});


  //convert to a map
Map<String, dynamic> toMap(){
  return {
    'senderId' : senderId,
    'senderEmail': senderEmail,
    'receicerId': receiverId,
    'message': message,
    'timestamp':timeStamp
  };
}
}