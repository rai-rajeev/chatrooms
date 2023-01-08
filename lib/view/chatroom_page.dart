import 'dart:convert';

import 'package:chatroom/model/message.dart';
import 'package:chatroom/view/page.dart';
import 'package:chatroom/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatroom/main.dart';

class Chatroompage extends StatefulWidget {
  const Chatroompage({Key? key}) : super(key: key);

  @override
  State<Chatroompage> createState() => _ChatroompageState();
}

class _ChatroompageState extends State<Chatroompage> {


  bool IsCollapsed=true;
  int SelectedIndex=0;
  PageController _pageController=PageController();
  User _user=User.Fromjson(jsonDecode(json!));
  final TextEditingController _ChatControllerMusic=TextEditingController();
  final TextEditingController _ChatControllerTravel=TextEditingController();
  final TextEditingController _ChatControllerPhotography=TextEditingController();
  final TextEditingController _ChatControllerStudy=TextEditingController();
  final TextEditingController _ChatControllerMovie=TextEditingController();
  final TextEditingController _ChatControllerLanguage=TextEditingController();
  final List<String> _images=[
    'https://th.bing.com/th/id/OIP.SN6y8iIeHpXzeuFcXwTOHAHaE6?w=203&h=135&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://th.bing.com/th?q=Mexico+Travel&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=strict&t=1&mw=247',
    'https://th.bing.com/th/id/OIP.5Wx8UygzpQxVrCooQUNsRQHaE7?pid=ImgDet&w=201&h=133&c=7&dpr=1.3',
    'https://th.bing.com/th/id/OIP.ZHS1e5s0aB3aQFxTv_2oCwHaE7?w=272&h=181&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://th.bing.com/th/id/OIP.5VugAs7ftlrDl7wgUvoEYQHaE8?w=236&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://th.bing.com/th/id/OIP.hcAZT-YUqclZD3dInp4dGQHaDn?w=324&h=170&c=7&r=0&o=5&dpr=1.3&pid=1.7'

  ];
  final List<String> _chatrooms=[
    'Music',
    'Travel',
    'Photography',
    'Study',
    'Movie',
    'Language'
  ];
  Stream<List<Message>> ReadMessage(String collection)=>FirebaseFirestore.instance
      .collection(collection).snapshots()
      .map((snapshot) => snapshot
      .docs.map((doc) => Message.Fromjson(doc.data())).toList());
 final ScrollController listconto=ScrollController();
 void _scrollDown(){
   listconto.jumpTo(listconto.position.maxScrollExtent);
 }
 // @override
 // void initState(){
 //   super.initState();
 //   _scrollDown();
 // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(

        body: SafeArea(
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    width: 75,
                  ),
                  Flexible(
                    child: Container(



                      color: Colors.amber[200],

                      child: PageView(
                        controller: _pageController,
                        onPageChanged:(value){
                          setState(() {
                          SelectedIndex=value;
                        });
                          },
                        children: [
                          BuildPage( _ChatControllerMusic, _chatrooms[0], ReadMessage(_chatrooms[0]), _user,listconto),
                          BuildPage( _ChatControllerTravel, _chatrooms[1], ReadMessage(_chatrooms[1]), _user,listconto),
                          BuildPage( _ChatControllerPhotography, _chatrooms[2], ReadMessage(_chatrooms[2]), _user,listconto),
                          BuildPage( _ChatControllerStudy, _chatrooms[3], ReadMessage(_chatrooms[3]), _user,listconto),
                          BuildPage( _ChatControllerMovie, _chatrooms[4], ReadMessage(_chatrooms[4]), _user,listconto),
                          BuildPage( _ChatControllerLanguage, _chatrooms[5], ReadMessage(_chatrooms[5]), _user,listconto),


      //



                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.lightBlue[100],
                width: IsCollapsed?75:250,
                child: Column(
                  children: [
                    Container(

                      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 5),
                      width: double.infinity,
                      color: Colors.blueAccent,
                      child: Image(image: const NetworkImage('https://www.bing.com/th?id=OIP.I6no_uWjMZLlWTZxyu63GAHaFj&w=288&h=216&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'),
                      width:IsCollapsed? 75:180,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Flexible(
                      child: Container(


                        child: ListView.separated(
                            itemCount:_images.length,

                            itemBuilder: (context,index)=>Container(

                                            child: Row(
                                              children: [
                                                AnimatedContainer(
                                                    duration: const Duration(milliseconds: 500),
                                                  height: (SelectedIndex==index)? 40:0,
                                                  width: 5,
                                                  color: Colors.blueAccent,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child:IsCollapsed?ListTile(
                                                          leading: ClipOval(
                                                            child: Material(
                                                              child: Image(
                                                              image: NetworkImage(_images[index]),
                                                              width: 35,
                                                              height: 35,
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: (){
                                                            setState(() {

                                                              SelectedIndex=index;
                                                              _pageController.jumpToPage(index);

                                                            });
                                                          },
                                                                      ):
                                                      ListTile(
                                                        leading: ClipOval(
                                                          child: Image(
                                                            image: NetworkImage(_images[index]),
                                                            width: 40,
                                                            height: 40,
                                                          ),
                                                        ),
                                                        onTap: (){
                                                          setState(() {
                                                            listconto.jumpTo(listconto.position.maxScrollExtent);

                                                            SelectedIndex=index;
                                                            _pageController.jumpToPage(index);
                                                          });
                                                        },
                                                        title:Text(_chatrooms[index],
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontStyle: FontStyle.italic,
                                                                    fontSize: 20
                                                                              ),)  ,

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                            separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                           ),
                      ),
                    ),

                    Container(
                        alignment:IsCollapsed? Alignment.center:Alignment.centerRight,
                        margin:IsCollapsed?null: const EdgeInsets.only(right: 16),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Icon(IsCollapsed?Icons.arrow_forward_ios:Icons.arrow_back_ios,
                    color: Colors.orangeAccent,
                              size: 36,)

                              ),
                    onTap: (){
                              setState(() {
                                IsCollapsed=!IsCollapsed;
                              });
                    },
                            ),
                          ),
                      ),

                  ],

                ),
              ),


            ],
          ),
        ),


      ),
    );
  }
}
