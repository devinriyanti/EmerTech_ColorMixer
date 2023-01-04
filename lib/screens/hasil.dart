// ignore_for_file: unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'dart:ui';
import 'package:color_mixer_160419083/main.dart';
import 'package:color_mixer_160419083/screens/highscore.dart';
import 'package:color_mixer_160419083/screens/permainan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result(
    {Key? key,
    required this.time,
    required this.color_mix,
    required this.avg,
    required this.hints,
    required this.score
    }): super(key: key);

    final int time;
    final int color_mix;
    final int avg;
    final int hints;
    final double score;

  @override
  State<StatefulWidget> createState() {
    return _Result();
  }
}

class _Result extends State<Result> {
  @override
  Widget build(BuildContext context) {
    String waktu = formatTime(widget.time);
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Text(
          "Final Score: ${widget.score}",
          style: TextStyle(fontSize: 30),
        ),
        Text("Total time played: $waktu", style: TextStyle(fontSize: 18)),
        Text("Color Mixed: ${widget.color_mix}", style: TextStyle(fontSize: 18)),
        Text("Average guesses: ${widget.avg}", style: TextStyle(fontSize: 18)),
        Text("Hint used: ${widget.hints}", style: TextStyle(fontSize: 18)),
        Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child:
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayGame()));
                    }, 
                    child: Text("PLAY AGAIN",  style: TextStyle(fontSize: 20))
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HighScore()));
                    }, 
                    child: Text("HIGH SCORE", style: TextStyle(fontSize: 20))
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                }, 
                child: Text("MAIN MENU", style: TextStyle(fontSize: 20))
              ),
            ),
          ],
        )),
      ]),
    );
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}
