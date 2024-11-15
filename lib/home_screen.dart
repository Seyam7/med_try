import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medai_try/contact_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? sharedPreferences;
  Map<String, dynamic>? medaiMap;

  getDoctorsData() async {
    var docList = await http.get(Uri.parse(
        'https://demo-app.medaicloud.live/api/v1/all_user/get_doctor_list'));
    print('doc list :-${docList.body}');
    setState(() {
      medaiMap = Map<String, dynamic>.from(jsonDecode(docList.body));
    });
  }

  @override
  void initState() {
    getDoctorsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: medaiMap!=null? Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: medaiMap?["doctor_list"].length,
            itemBuilder: (context, index) {
              return Card(
                //margin: EdgeInsets.only(bottom: 5),
                //width: double.infinity,
                //height: 20,
                child: Text(
                  '${medaiMap!["doctor_list"][index]["name"]}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Contact',style: TextStyle(fontSize: 20),),
          backgroundColor: Colors.blue,
          elevation: 10,
          icon: Icon(Icons.contact_page),
          tooltip: 'See all contact',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactPage()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ):Center(child: CircularProgressIndicator(color: Colors.blue,backgroundColor: Colors.white,)),
    );
  }
}
