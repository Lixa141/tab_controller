import 'dart:convert';

import 'package:appverse/data/models/json_model.dart';
import 'package:appverse/domain/entities/json.dart';
import 'package:appverse/domain/mappers/json_mapper.dart';
import 'package:appverse/presentation/widgets/firebase_tab.dart';
import 'package:appverse/presentation/widgets/json_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Read from json file
Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

class _MyHomePageState extends State<MyHomePage> {
  Json? data;

  @override
  void initState() {
    super.initState();
    fetchJSON();
  }

  void fetchJSON() async {
    // Read from json file
    Map<String, dynamic> jsonData =
        await loadJsonFromAssets('assets/screen_1.json');

    // Deserialize to model for handy use and then convert to entity
    setState(() {
      data = JsonModel.fromJson(jsonData).toEntity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.code)),
                Tab(icon: Icon(Icons.local_fire_department_rounded)),
              ],
            ),
          ),
          body: data != null
              ? TabBarView(
                  children: [
                    JsonTab(
                      backgroundColor: data!.backgroundColor,
                      components: data!.components,
                    ),
                    const FirebaseTab(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
