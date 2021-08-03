import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

//myFuncs

//end myFuncs
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageOperation();
  }
}

class HomePageOperation extends StatefulWidget {
  const HomePageOperation({Key? key}) : super(key: key);

  @override
  _HomePageOperationState createState() => _HomePageOperationState();
}

class _HomePageOperationState extends State<HomePageOperation> {
  late Map<String,dynamic> userData;
  _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);
    setState(() {
      userData = user;
    });
    return user;
  }
  _ucFirst(String str)
  {
    if(str.isEmpty)
      return null;
    if(str.length<=1)
      return str.toUpperCase();
    var x=str.toString();
    return x.substring(0,1).toUpperCase()+x.substring(1);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData={};
    _getUserInfo();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: Icon(Icons.location_on),
          title: Text('Deliver to : Your Location',style:
          TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
        ),
        body: Container(
          child: Center(
            child: Text("Hello ${_ucFirst(userData['fName'].toString())} ${_ucFirst(userData['lName'].toString())} !"),
          ),
        )
        ),
      );
  }
}
