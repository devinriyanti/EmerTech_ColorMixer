// ignore_for_file: prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors, unused_import, avoid_web_libraries_in_flutter, non_constant_identifier_names, prefer_final_fields, unused_field, unused_element, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:color_mixer_160419083/screens/hasil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _username = "";
Color warnaRandom = getRandomColor();

class PlayGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlayGame();
  }
}

Color getRandomColor() {
  int _randomRed = Random().nextInt(256);
  int _randomGreen = Random().nextInt(256);
  int _randomBlue = Random().nextInt(256);

  print("atas :" + _randomRed.toString() +" "+ _randomGreen.toString() + " "+_randomBlue.toString());
  return Color.fromRGBO(_randomRed, _randomGreen, _randomBlue, 1);
}

class _PlayGame extends State<PlayGame> {
  double _hitung = 255;
  double _init_value = 255;
  double _bobotHint = 1;
  late Timer _timer;
  int _randomRed = Random().nextInt(256);
  int _randomGreen = Random().nextInt(256);
  int _randomBlue = Random().nextInt(256);
  int jumlahTebakan = 0;
  int benar = 0;
  int score = 0;
  int time = 0;
  int color_mix = 0;
  int hint = 0;
  int total_waktu = 0;
  int avg = 0;
  double total_score = 0;
  double _score = 0;
  final TextEditingController redCon = TextEditingController();
  final TextEditingController greenCon = TextEditingController();
  final TextEditingController blueCon = TextEditingController();
  static int pemainRed = 255;
  static int pemainGreen = 255;
  static int pemainBlue = 255;
  bool _isButtonDisabled = false;
  String hasilTebakan = "";
  String hintRandom = "";
  String hintPemain = "";
  Color _warna = Color.fromARGB(255, pemainRed, pemainGreen, pemainBlue);

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
    checkUser().then((String input) {
      if (input == "") {
        _username = "Kosong";
      } else {
        _username = input;
      }
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _hitung = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Mixer"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            LinearPercentIndicator(
              center: Text(formatTime(_hitung.ceil())),
              width: MediaQuery.of(context).size.width,
              lineHeight: 20.0,
              percent: (_hitung / _init_value),
              backgroundColor: Colors.grey,
              progressColor: warnaRandom,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("Score : " + total_score.ceil().toString(),
                  textAlign: TextAlign.right),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text("Guess this color!"), Text("Your color")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: warnaRandom,
                      border: Border.all(color: Colors.black, width: 1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: _warna,
                      border: Border.all(color: Colors.black, width: 1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [Text(hintRandom), Text(hintPemain)],
            ),
            Text(hasilTebakan),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                  controller: redCon,
                  decoration: InputDecoration(
                    hintText: "Red (0-255)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    if (redCon != "") {
                      _euclidean();
                      pemainRed = int.parse(redCon.text);
                    } //else {
                    //   pemainRed = 255;
                    // }
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                  controller: greenCon,
                  decoration: InputDecoration(
                      hintText: "Green (0-255)", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    if (greenCon != "") {
                      _euclidean();
                      pemainGreen = int.parse(greenCon.text);
                    } // else {
                    //   pemainGreen = 255;
                    // }
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                  controller: blueCon,
                  decoration: InputDecoration(
                      hintText: "Blue (0-255)", border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    if (blueCon != "") {
                      _euclidean();
                      pemainBlue = int.parse(blueCon.text);
                    } //else {
                    //   pemainBlue = 255;
                    // }
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _euclidean();
                        hasilTebakanPemain();
                        _warna = Color.fromRGBO(
                            pemainRed, pemainGreen, pemainBlue, 1);
                        if (hasilTebakanPemain() == "#Close enough...") {
                          jumlahTebakan++;
                          total_waktu += _init_value.ceil() - _hitung.ceil();
                          _hitung = _init_value;
                        } else if (hasilTebakanPemain() == "#Almost!") {
                          jumlahTebakan++;
                          warnaRandom = getRandomColor();
                          _warna = Color.fromRGBO(255, 255, 255, 1);
                          benar++;
                          avg = (jumlahTebakan / benar).floor();

                          redCon.text = "";
                          greenCon.text = "";
                          blueCon.text = "";

                          hintPemain = "";
                          hintRandom = "";

                          _isButtonDisabled = false;

                          total_waktu += _init_value.ceil() - _hitung.ceil();
                          _hitung = _init_value;

                          total_score;
                        } else {
                          jumlahTebakan++;
                          total_waktu += _init_value.ceil() - _hitung.ceil();
                          _hitung = _init_value;
                        }
                        hitungScore();

                        redCon.text = "";
                        greenCon.text = "";
                        blueCon.text = "";

                        
                        print("bawah :"+_randomRed.toString() +" "+ _randomGreen.toString() + " "+_randomBlue.toString());
                      },
                      child:
                          Text("GUESS COLOR", style: TextStyle(fontSize: 20))),
                  ElevatedButton(
                      onPressed: () {
                        if (_isButtonDisabled == false) {
                          hintRandom =
                              "#" + warnaRandom.value.toRadixString(16);
                          hintPemain =
                              "#${Color.fromRGBO(pemainRed, pemainGreen, pemainBlue, 1).value.toRadixString(16)}";
                          _hitung = _hitung / 2;
                          _bobotHint = 0.5;
                          hint++;
                          _isButtonDisabled = true;
                        }
                      },
                      child: Text("SHOW HINT", style: TextStyle(fontSize: 20))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double hitungScore() {
    if (jumlahTebakan >= 5) {
      _score = _bobotHint * 1 * _hitung;
    } else {
      _score = _bobotHint * (5 - jumlahTebakan) * _hitung;
    }
    total_score = total_score + _score;
    return total_score;
  }

  double _euclidean() {
    double euc = sqrt(((_randomRed - pemainRed) * (_randomRed - pemainRed)) +
        ((_randomGreen - pemainGreen) * (_randomGreen - pemainGreen)) +
        ((_randomBlue - pemainBlue) * (_randomBlue - pemainBlue)));
    return euc;
  }

  String hasilTebakanPemain() {
    if (_euclidean() > 128) {
      hasilTebakan = "#Try Again!";
    } else if (_euclidean() > 64 && _euclidean() <= 128) {
      hasilTebakan = "#Too far!";
    } else if (_euclidean() > 32 && _euclidean() <= 64) {
      hasilTebakan = "#You got this!";
    } else if (_euclidean() > 16 && _euclidean() <= 32) {
      hasilTebakan = "#Close enough...";
    } else if (_euclidean() < 16) {
      hasilTebakan = "#Almost!";
    }
    return hasilTebakan;
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _hitung--;
        if (_hitung <= 0) {
          gameOver();
        }
      });
    });
  }

  void gameOver() {
    checkHighScore();
    _timer.cancel();
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('GAME OVER'),
              content: Text("Good Game, Great Eyes!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'SHOW RESULT');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Result(
                                  time: total_waktu,
                                  color_mix: jumlahTebakan,
                                  avg: avg,
                                  hints: hint,
                                  score: total_score,
                                )));
                  },
                  child: const Text('SHOW RESULT'),
                ),
              ],
            ));
  }

  void checkHighScore() async {
    final prefs = await SharedPreferences.getInstance();

    var firstScore = prefs.getInt("firstScore") ?? 0;
    var secondScore = prefs.getInt("secondScore") ?? 0;
    var thirdScore = prefs.getInt("thirdScore") ?? 0;

    var username = prefs.getString("username") ?? "";

    var firstWinner = prefs.getString("firstWinner") ?? "";
    var secondWinner = prefs.getString("secondWinner") ?? "";
    var thirdWinner = prefs.getString("thirdWinner") ?? "";

    if (total_score.ceil() > thirdScore) {
      if (total_score.ceil() > secondScore) {
        if (total_score.ceil() > firstScore) {
          prefs.setInt("firstScore", total_score.ceil());
          prefs.setString("firstWinner", username);

          prefs.setInt("secondScore", firstScore);
          prefs.setString("secondWinner", firstWinner);
        } else {
          prefs.setInt("secondScore", total_score.ceil());
          prefs.setString("secondWinner", username);

          prefs.setInt("thirdScore", secondScore);
          prefs.setString("thirdWinner", secondWinner);
        }
      } else {
        prefs.setInt("thirdScore", total_score.ceil());
        prefs.setString("thirdWinner", username);
      }
    }
  }
}

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String username = prefs.getString("username") ?? "";
  return username;
}
