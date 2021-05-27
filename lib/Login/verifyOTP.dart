import 'dart:convert';

import 'package:credai_chandrapur_client/home.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../urls.dart';

class OTPPage extends StatefulWidget{

  final String mobile;

  const OTPPage({Key key, this.mobile}) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();

}

class _OTPPageState extends State<OTPPage>{

  SharedPreferences prefLoginData;
  String otpValue = "";

  @override
  void initState() {
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        appBar: AppBar(
          title: Text("Verify OTP"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/mobile_otp.gif"),
                Text("Mobile Number Verification", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Enter the code sent on ", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 16),),
                        Text("+91-" + "${widget.mobile}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      otpValue = value;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      inactiveColor: Colors.black,
                      activeColor: Colors.green,
                      selectedColor: Colors.green,
                    ),
                    onCompleted: (value){

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Didn't get OTP. ", style: TextStyle(color: Colors.grey[600], fontSize: 16),),
                        Text("Please Resend", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 16),),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () async {

                      prefLoginData = await SharedPreferences.getInstance();

                      if(otpValue == ""){
                        Toast.show("Please enter OTP", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                      }else{
                        showAlert(context);

                        List data;
                        var response = await http.post(Uri.parse(Urls.verifyOTP),
                            body: {
                              "mobile": "${widget.mobile}",
                              "otp": otpValue
                            },
                            headers: {"Accept": "application/json"});

                        print(response.body);
                        setState(() {
                          var convertDataTojson = jsonDecode(response.body.toString());
                          if(convertDataTojson == 0)
                          {
                            print("Invalid OTP");
                            Toast.show("Invalid OTP", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                            Navigator.pop(context, true);
                          }else{
                            data = convertDataTojson['verify'];
                            prefLoginData.setString("id", data[0]["id"]);
                            print(prefLoginData.getString("id"));
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => home()), (_) => false);
                          }

                        });
                      }
                    },
                    child: Text(
                      'Verify OTP',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}