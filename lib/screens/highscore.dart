// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_import

import 'dart:async';

import 'package:color_mixer_160419083/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScore extends StatefulWidget {
  const HighScore({Key? key}) : super(key: key);

  @override
  State<HighScore> createState() => _HighScore();
}

class _HighScore extends State<HighScore> {
  int top1 = 0;
  int top2 = 0;
  int top3 = 0;
  String top1User = "";
  String top2User = "";
  String top3User = "";

  @override
  void initState() {
    super.initState();
    checkHighScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("High Scores"),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("HIGH SCORES",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Row(
                  children: [
                    Image.asset(
                      "../../assets/images/TropyOne.png",
                      height: 100,
                    ),
                    Text(
                      "1. $top1User\n" + top1.toString() + " pts",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Row(
                  children: [
                    Image.asset(
                      "../../assets/images/TropyTwo.png",
                      height: 100,
                    ),
                    Text(
                      "2. $top2User\n" + top2.toString() + " pts",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Row(
                  children: [
                    Image.asset(
                      "../../assets/images/TropyThree.png",
                      height: 100,
                    ),
                    Text(
                      "3. $top3User\n" + top3.toString() + " pts",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void checkHighScore() async {
    final prefs = await SharedPreferences.getInstance();

    //GET SCORE
    var firstScore = prefs.getInt("firstScore") ?? 0;
    var secondScore = prefs.getInt("secondScore") ?? 0;
    var thirdScore = prefs.getInt("thirdScore") ?? 0;

    //GET USER
    var firstWinner = prefs.getString("firstWinner") ?? "";
    var secondWinner = prefs.getString("secondWinner") ?? "";
    var thirdWinner = prefs.getString("thirdWinner") ?? "";

    setState(() {
      //SET SCORE
      top1 = firstScore.floor();
      top2 = secondScore.floor();
      top3 = thirdScore.floor();

      //SET USER
      top1User = firstWinner.toString().toUpperCase();
      top2User = secondWinner.toString().toUpperCase();
      top3User = thirdWinner.toString().toUpperCase();
    });
  }
}
