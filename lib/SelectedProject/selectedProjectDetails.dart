import 'package:flutter/material.dart';

class SelectedProjectDetailsPage extends StatefulWidget{
  @override
  _SelectedProjectDetailsPageState createState() => _SelectedProjectDetailsPageState();

}

class _SelectedProjectDetailsPageState extends State<SelectedProjectDetailsPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Project Details"),
        ),
        body: SingleChildScrollView(

        )
    );
  }

}