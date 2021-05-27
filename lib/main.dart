import 'package:credai_chandrapur_client/Login/login.dart';
import 'package:credai_chandrapur_client/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: "CREDAI Chandrapur",
    home: SplashScreenPage(),
    theme: ThemeData(
        primarySwatch: Colors.green
    ),
  ));
}

class SplashScreenPage extends StatefulWidget{
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();

}

class _SplashScreenPageState extends State<SplashScreenPage>{

  SharedPreferences prefLoginData;
  String clientId;

  @override
  void initState() {
    // TODO: implement initState
    getValidation().whenComplete(() async{
      if(clientId == null){
        Timer(Duration(seconds: 5),() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login()), (_) => false));
      }else{
        Timer(Duration(seconds: 5),() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => home()), (_) => false));
      }
    });
    super.initState();
  }

  Future getValidation() async{
    prefLoginData= await SharedPreferences.getInstance();
    var id = prefLoginData.getString('id');
    setState(() {
      clientId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                          child: Image.asset("assets/credai_logo.jpg",)
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
