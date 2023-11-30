import 'package:flutter/material.dart';

class MyActivitiesAnimePage extends StatefulWidget {
  const MyActivitiesAnimePage({super.key});

  @override
  State<MyActivitiesAnimePage> createState() => _MyActivitiesAnimePageState();
}

class _MyActivitiesAnimePageState extends State<MyActivitiesAnimePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff121315),
      body: Center(child: Text('My Activities Anime')),
    );
  }
}
