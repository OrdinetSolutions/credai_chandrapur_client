import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget{
  @override
  _FilterPageState createState() => _FilterPageState();

}

class _FilterPageState extends State<FilterPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Assign Filters"),
        ),
        body: SingleChildScrollView(

        )
    );
  }

}