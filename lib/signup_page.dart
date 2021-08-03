import 'dart:convert';

import 'package:at_your_doorstep/Constants.dart';
import 'package:at_your_doorstep/signuppage2.dart';
import 'package:flutter/material.dart';
import 'package:at_your_doorstep/textFieldClass.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'api.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignupOperation();
  }
}

class SignupOperation extends StatefulWidget {

  @override
  _SignupOperationState createState() => _SignupOperationState();
}

class _SignupOperationState extends State<SignupOperation> {
  bool _isLoading = false;
  DateTime  selectedData=DateTime.now();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController CNICController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedData,
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedData)
      setState(() {
        selectedData = picked;
      });
    dateOfBirthController.text=selectedData.year.toString()+'-'+selectedData.month.toString()+'-'+selectedData.day.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text("SIGN UP", style:
                      TextStyle(fontSize: 30, color: Colors.red, fontFamily: "PTSans", fontWeight: FontWeight.w700 , letterSpacing: 2.0)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textfieldStyle(textHint: 'First Name', obscureText: false, textLabel1: 'First Name ',controllerText: firstNameController,),
                    textfieldStyle(textHint: 'Last Name', obscureText: false, textLabel1: 'Last Name ',controllerText: lastNameController,),
                    textfieldStyle(textHint: 'CNIC', obscureText: false, textLabel1: 'CNIC ',controllerText: CNICController,),
                    textfieldStyle(textHint: 'Phone Number', obscureText: false, textLabel1: 'Phone Number ',controllerText: contactController,),
                    //textfieldStyle(textHint: 'Home Address', obscureText: false, textLabel1: 'Home Address ',),
                    //textfieldStyle(textHint: 'Date of Birth', obscureText: false, textLabel1: 'Date Of Birth ',),
                     Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //Text("${selectedData.toLocal()}".split(' ')[0]),
                        textfieldStyle(textHint: 'Date', obscureText: false, textLabel1: "${selectedData.toLocal()}".split(' ')[0],controllerText: dateOfBirthController,),
                        SizedBox(height: 2.0,),
                        RaisedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select date'),
                        ),
                      ],
                    ),
                    textfieldStyle(textHint: 'Email Address', obscureText: false, textLabel1: 'Email Address ',controllerText: mailController,),
                    textfieldStyle(textHint: 'Password', obscureText: true, textLabel1: 'Password',controllerText: passwordController,),
                    textfieldStyle(textHint: 'Confirm Password', obscureText: true, textLabel1: 'Confirm Password ',controllerText: confirmPasswordController,),
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
                              _handleLogin();
                            },
                            color: Colors.red,
                            child: Text("Next", style:
                            TextStyle(fontSize: 18, color: Colors.white, fontFamily: "PTSans" )),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  _showMsg(msg) { //
    final snackBar = SnackBar(
      backgroundColor: Color(0xffc76464),
      content: Text(msg),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'fName' : firstNameController.text,
      'lName' : lastNameController.text,
      'email' : mailController.text,
      'password' : passwordController.text,
      'confirm-password' : passwordController.text,
      'contact' : contactController.text,
      'CNIC' : CNICController.text,
      'date_of_birth' : dateOfBirthController.text,
    };
    print ("data: "+data.toString());
    EasyLoading.show(status: 'loading...');
    var res = await CallApi().postData(data, '/mobileRegister');
    EasyLoading.dismiss();
    var body = json.decode(res.body);
    print(body.toString());
    if(body['success']!){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => HomePage()));
    }
    else{
      _showMsg(body['message']);
      //EasyLoading.showToast(body['message']);
    }




    setState(() {
      _isLoading = false;
    });



  }
}
