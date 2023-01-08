
import 'dart:convert';
import 'dart:io';

import 'package:chatroom/view/chatroom_page.dart';
import 'package:chatroom/profile/edit_profile.dart';
import 'package:chatroom/main.dart';
import 'package:chatroom/model/user.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
   const ProfileScreen({
    Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user=User.Fromjson(jsonDecode(json!));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(' User Profile',
        style: TextStyle(
          fontSize: 32
        ),),
        backgroundColor: Colors.purpleAccent,

      ),
      body: Center(
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children:[
                    ClipOval(
                      child: Material(
                        child: Ink.image(
                          image:user!.ImagePath.contains('https://')? NetworkImage(user!.ImagePath):FileImage(File(user!.ImagePath)) as ImageProvider,
                          fit:BoxFit.cover ,
                          width: 200,
                          height: 200,
                          child: InkWell(onTap: ()async{
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>EditCreateProfileScreen()));
                          },),),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(7),
                          color: Colors.white,
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              color: Colors.lightBlue,
                              child: const Icon(
                                Icons.edit
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

                  ]
                ),
              ),
               const SizedBox(height: 100,),


              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                     const Text( 'Username :',
                         style: TextStyle(
                         fontSize: 28,
                         fontWeight: FontWeight.w500),),
                      SizedBox(height: 25,),
                      Text(user!.UserName,
                        style: const TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w500),),


                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>Chatroompage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Continue',
                      style: TextStyle(
                        fontSize: 28
                      ),),
                    )),
              )
            ],
          ),
        ),
      ),

    );
  }
}
