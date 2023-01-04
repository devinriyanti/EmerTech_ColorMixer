// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:color_mixer_160419083/screens/highscore.dart';
import 'package:color_mixer_160419083/screens/login.dart';
import 'package:color_mixer_160419083/screens/permainan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String active_user = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String username = prefs.getString("username") ?? "";
  return username;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String input) {
    if (input == "") {
      runApp(MyLogin());
    } else {
      active_user = input;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Mixer',
      routes: {
        'playgame': (context) => PlayGame(),
        'highscore': (context) => HighScore(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Color Mixer Homepage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void doLogout() async {
    final perfs = await SharedPreferences.getInstance();
    perfs.remove("username");
    main();
  }

  Widget myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text(
                active_user,
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            ListTile(
              title: Text("High Score"),
              leading: Icon(Icons.leaderboard),
              onTap: () {
                Navigator.pushNamed(context, "highscore");
              },
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () {
                doLogout();
              },
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
              child: Text("Welcome, $active_user!",
                  style: TextStyle(fontSize: 30)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "The goal of this game is produce the exact color as shown within a time limit. Provide the red, green, and blue values (0 to 255), then press the Guess color button to answer. Your scpre is determine by the remaining time. When the time is up, then it's a game over! See if you can reach top 5!",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, wordSpacing: 2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "playgame");
                  },
                  child: Text("PLAY GAME",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: myDrawer(),
    );
  }
}
