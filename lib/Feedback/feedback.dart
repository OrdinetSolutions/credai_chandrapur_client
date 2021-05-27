import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../urls.dart';
import 'package:http/http.dart' as http;

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  SharedPreferences prefLoginData;

  final TextEditingController feedbackController = TextEditingController();

  String userRating = "3";

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Feedback"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 60, bottom: 5),
              child: TextFormField(
                controller: feedbackController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Feedback',
                    hintText: 'Enter feedback'),
              ),
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.green,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                userRating = rating.toString();
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: FlatButton(
                onPressed: () async {
                  String feedback = feedbackController.text;

                  prefLoginData = await SharedPreferences.getInstance();
                  String client_id = prefLoginData.getString("id");

                  if (feedback == "") {
                    Toast.show("Please enter feedback", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  } else {
                    showAlert(context);

                    var response = await http.post(Uri.parse(Urls.addFeedbacks),
                        body: {
                          "user_id": client_id,
                          "message": feedback,
                          "ratings": userRating
                        },
                        headers: {
                          "Accept": "application/json"
                        });

                    setState(() {
                      var convertDataTojson =
                          jsonDecode(response.body.toString());
                      if (convertDataTojson == 0) {
                        Toast.show("Error", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                      } else {
                        Toast.show("Thankyou", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER);
                        Navigator.pop(context, true);
                      }
                      print(convertDataTojson);
                    });
                  }
                },
                child: Text(
                  'Add Feedback',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
