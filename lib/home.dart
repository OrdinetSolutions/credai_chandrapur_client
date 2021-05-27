import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:credai_chandrapur_client/About/about.dart';
import 'package:credai_chandrapur_client/Contact/contact.dart';
import 'package:credai_chandrapur_client/Events/events.dart';
import 'package:credai_chandrapur_client/Feedback/feedback.dart';
import 'package:credai_chandrapur_client/Filter/filters.dart';
import 'package:credai_chandrapur_client/Login/login.dart';
import 'package:credai_chandrapur_client/Project/projects.dart';
import 'package:credai_chandrapur_client/SelectedProject/selectedProject.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_share/flutter_share.dart';

import 'urls.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  SharedPreferences prefLoginData;
  String clientId;
  var data;

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<String> getJsonData() async {

    prefLoginData= await SharedPreferences.getInstance();
    clientId = prefLoginData.getString('id');
    print(clientId);

    var res = await http.post(Uri.parse(Urls.getClientDetails),
        body: {"id": clientId},
        headers: {"Accept": "application/json"});

    print(res.body);
    var convertDataTojson = jsonDecode(res.body.toString());
    data = convertDataTojson['users'];

    setState(() {});
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'CREDAI Chandrapur',
        text: 'Play Store Link',
        linkUrl: 'https://ordinet.in/',
        chooserTitle: 'Download App');
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text("Are You Sure?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () async {
                prefLoginData = await SharedPreferences.getInstance();
                prefLoginData.clear();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login()), (_) => false);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            data != null? UserAccountsDrawerHeader(
              accountName: Text(data[0]['name']),
              accountEmail: Text(data[0]['mobile']),
                currentAccountPicture: Image.asset('assets/credai_icon.png')
            ):UserAccountsDrawerHeader(
              accountName: Text("Hello User"),
              accountEmail: Text(""),
                currentAccountPicture: Image.asset('assets/credai_icon.png')
            ),
            ListTile(
              leading: Icon(
                  Icons.home,
                  color: Colors.green
              ),
              title: Text(
                'Projects',
                style: TextStyle(
                    color: Colors.green
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('CREDAI Events'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Selected Projects'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectedProjectPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {
                share();
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_ind),
              title: Text('Contact Details'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: () {
                showAlert(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Projects"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FilterPage()));
            },
          )
        ],
      ),
      body: Center(
        child: ProjectPage(),
      ),
    );
  }
}
