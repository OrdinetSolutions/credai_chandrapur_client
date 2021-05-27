import 'package:flutter/material.dart';

class SelectedProjectPage extends StatefulWidget{
  @override
  _SelectedProjectPageState createState() => _SelectedProjectPageState();

}

class _SelectedProjectPageState extends State<SelectedProjectPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Selected Projects"),
        ),
        body: SingleChildScrollView(

        )
    );
  }

}