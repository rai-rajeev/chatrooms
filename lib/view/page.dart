import 'package:chatroom/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

Widget BuildPage(TextEditingController chatcontroller,String title,Stream<List<Message>> Streamchat,User user,ScrollController lisko){
  String? nulldoc;

  return  Container(
    child:Column(
      children: [
        Container(
          color: Colors.deepPurpleAccent,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Text(title,
            style: const TextStyle(
                fontSize:36,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Flexible(
          child: StreamBuilder<List<Message>>(
              stream:Streamchat,
              builder: ( context, snapshot) {
                if(snapshot.data==null){
                  return Text('Something went wrong !${snapshot.error}');
                }
                else if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.data==null){
                  nulldoc= FirebaseFirestore.instance.collection(title).doc().id;
                  return Center(child: Container(padding: EdgeInsets.all(15),));
                }
                else {
                  final messages = snapshot.data!;

                  return ListView(
                    controller:lisko ,


                    children: messages.map((message)=>
                        Container(

                          child: Row(
                            mainAxisAlignment: (user.UserName==message.SendBy)? MainAxisAlignment.end:MainAxisAlignment.start,
                            crossAxisAlignment: (user.UserName==message.SendBy)? CrossAxisAlignment.end:CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(right: 15,
                                  top: 10,left: 10),
                                child: Container(
                                  width: (message.mes.length<24)?null:205,
                                    padding: const EdgeInsets.only(left: 4,top: 6,bottom: 6),

                                    decoration: BoxDecoration(
                                      color: (user.UserName==message.SendBy)?Colors.lightGreen:Colors.white,
                                      borderRadius:(user.UserName==message.SendBy)? const BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25),bottomRight: Radius.circular(10)):
                                      const BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25),bottomRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Padding(padding: const EdgeInsets.all(5),
                                            child: Text(message.SendBy,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.italic,
                                                  color:(user.UserName==message.SendBy)? Colors.white:Colors.greenAccent,
                                                  decoration: TextDecoration.underline
                                              ),
                                            ),

                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(message.mes,
                                                style: const TextStyle(
                                                  fontSize: 20,

                                                ),

                                              ),
                                              Text('${message.SentTime.hour}:${message.SentTime.minute.toInt()~/10}${message.SentTime.minute.toInt()%10}',
                                                textAlign: TextAlign.end,)
                                            ],
                                          ),
                                        ),

                                      ],
                                    )

                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                  );
                }
              }
              ),),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                width: 200,

                child: TextField(
                  controller: chatcontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                  hintText: 'Message',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                  ),
                ),
              ),
              Flexible(child: Container()),
              Builder(
                  builder: (context) {
                    return IconButton(
                        onPressed: ()async{
                          FirebaseFirestore.instance.collection(title).doc(DateTime.now().toString()).set(Message(SentTime: DateTime.now(), mes: chatcontroller.text,  SendBy: user.UserName).Tojson()).catchError((e){
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(SnackBar(content: Text('${e}'))) ;
                          });
                          chatcontroller.clear();
                          if(nulldoc!=null){
                            FirebaseFirestore.instance.collection(title).doc(nulldoc!).delete().catchError((e){
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(content: Text('${e}'))) ;
                            });
                          }
                          },
                        icon: const Icon(Icons.send));
                  }
                  )
            ],
          ),
        )
      ],
    ),
  );
}