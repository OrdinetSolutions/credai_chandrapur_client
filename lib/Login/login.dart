import 'dart:convert';
import 'package:credai_chandrapur_client/Login/verifyOTP.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../urls.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  showAlert(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
            ("assets/loader.gif"),
            width: 50,
            height: 50,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Client Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/credai_logo.jpg')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter valid name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: mobileController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile No.',
                    hintText: 'Enter valid Mobile No.'),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid Email'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {

                  final String name = nameController.text;
                  final String mobile = mobileController.text;
                  final String email = emailController.text;

                  if(name == ""){
                    Toast.show("Please enter Name", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  }else if(mobile == ""){
                    Toast.show("Please enter Mobile No.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                  } else{
                    showAlert(context);

                    var response = await http.post(Uri.parse(Urls.loginRegister),
                        body: {
                          "name": name,
                          "mobile": mobile,
                          "email": email
                        },
                        headers: {"Accept": "application/json"});

                    print(response.body);
                    setState(() {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OTPPage(
                          mobile: mobile
                      )), (_) => false);
                    });
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
