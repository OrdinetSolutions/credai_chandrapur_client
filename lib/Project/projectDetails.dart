import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatefulWidget{
  @override
  _ProjectDetailsPageState createState() => _ProjectDetailsPageState();

}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>{

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