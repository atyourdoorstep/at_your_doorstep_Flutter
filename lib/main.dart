import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/HomePage.dart';
import 'package:at_your_doorstep/api.dart';
import 'package:at_your_doorstep/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';


void main() {
  //runApp(HomePage());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'At Your Doorstep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red,

      ),
      home: MyHomePage(title: 'At Your Doorstep'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 getTkn(Future x)
 {
  return  x.toString();
}
class _MyHomePageState extends State<MyHomePage> {

  bool showSpinner = false;
  late Future csrf;
  var callApi= CallApi() ;
  bool _isLoading = false;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailF = "mussabayubawan2@gmail.com";
  String passwordF = "mussabzgr8123";
// @override
//   void initState() {
//     super.initState();
//     csrf=CallApi().getCSRF() ;
//     String str=getTkn(csrf.toString());
//     print( csrf);
//   }

//   Future<void> getCSRF()
//   async {
//     var cs=CallApi().getCSRF();
//     print(await cs);
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children:[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Image.asset("assets/atyourdoorstep.png", height: 180,width: 180,)),
                            )),
                        Center(
                          child: Text("LOG IN", style:
                          TextStyle(fontSize: 25, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        textfieldStyle(textHint: 'Email Address', obscureText: false, textLabel1: 'Email Address',controllerText: mailController,),
                        textfieldStyle(textHint: 'password', obscureText: true, textLabel1: 'Password ',controllerText: passwordController,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 55,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                onPressed: () {
                                  //print(await csrf);
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  if(mailController.text != "" && passwordController.text != "") {
                                    if (emailF == mailController.text &&
                                        passwordF == passwordController.text) {
                                      CircularProgressIndicator();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    }
                                    else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Warning! "),
                                              content: Text(
                                                  "Your Email or password is incorrect!! "),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  }
                                },
                                color: Colors.red,
                                child: Text("Login", style:
                                TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 55,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0),
                                  ),
                                  side: BorderSide(color: Colors.red),
                                ),
                                onPressed: () {
                                  //print(mailController);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signup()),
                                  );
                                },
                                color: Colors.white,
                                child: Text("Signup", style:
                                TextStyle(fontSize: 18, color: Colors.red, fontFamily: "PTSans" )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );


  }



 /* void _login() async{

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email' : mailController.text,
      'password' : passwordController.text
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => HomePage()));
    }else{
      //_showMsg(body['message']);
    }


    setState(() {
      _isLoading = false;
    });




  }*/
}

