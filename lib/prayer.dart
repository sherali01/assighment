import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Models/prayers_models.dart';
import 'dart:async';

class ApiPrayers extends StatefulWidget {
  const ApiPrayers({super.key});

  @override
  State<ApiPrayers> createState() => _ApiPrayersState();
}

class _ApiPrayersState extends State<ApiPrayers> {

  late PrayerModel list;
  static String city = 'Dammam';
  static String country = 'Saudi Arabia';
  static int method = 4;

  Future<PrayerModel> getPrayerApi()async{
    final response = await http.get(Uri.parse("http://api.aladhan.com/v1/timingsByCity?city=Dammam&country=Saudi%20Arabia&method=method=4"));
    var data=jsonDecode(response.body.toString());
    list=PrayerModel.fromJson(data);
    


    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Api_Example'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child:FutureBuilder(
              future: getPrayerApi(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text('Fajr'),
                                Text('Dhuhr'),
                                Text('Asr'),
                                Text('Maghrib'),
                                Text('Isha'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(snapshot.data.data.timings.fajr),
                                Text(snapshot.data.data.timings.dhuhr),
                                Text(snapshot.data.data.timings.asr),
                                Text(snapshot.data.data.timings.maghrib),
                                Text(snapshot.data.data.timings.isha),
                              ],
                            ),
                          ),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: Column(children: <Widget>[
                              Text(snapshot.data.data.meta.timezone),
                            ],),)
                        ],
                      ),
                    ),
                  );
                } else  {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}