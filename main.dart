import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key});

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  //variaveis
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];


  //criando função stop()
  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //criando funçao reset()
  void reset(){
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
      laps.clear();
    });
  }

  //criando função addLaps()
  void addLaps(){
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes >59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2000),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "App Cronômetro",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  height: 20.0
              ),
              Center(
                child: Text("$digitHours:$digitMinutes:$digitSeconds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                    fontWeight: FontWeight.w600,
                  )),
              ),
              Container(
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index){
                   return Padding(
                     padding: const EdgeInsets.all(16.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Volta nº${index+1}",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: 16.0,
                           ),
                         ),
                         Text(
                           "${laps[index]}",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 16.0,
                           ),
                         ),
                       ],
                     ),
                   );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text(
                        (!started) ? "Iniciar" : "Pausar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: started,
                    child: Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          addLaps();
                        },
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          "Volta",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: started,
                    child: Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          reset();
                        },
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Text(
                          "Resetar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
