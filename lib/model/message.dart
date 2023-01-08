import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  DateTime SentTime;
  String SendBy;
  String mes;
  //String ProfileImage;
  Message({
    required this.SentTime,
    required this.mes,
   // required this.ProfileImage,
    required this.SendBy
});
  static Message Fromjson(Map<String,dynamic> json)=>
      Message(
          SentTime: (json['SentTime'] as Timestamp).toDate(),
          mes: json['mes'],
       //   ProfileImage: json['ProfileImage'],
          SendBy: json['SendBy']
      );
  Map<String,dynamic> Tojson()=>{
    'SentTime':SentTime,
    'SendBy':SendBy,
    //'profileImage':ProfileImage,
    'mes':mes
  };


}