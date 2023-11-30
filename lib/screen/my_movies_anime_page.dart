import 'package:flutter/material.dart';

class MyMoviesAnimePage extends StatefulWidget {
  const MyMoviesAnimePage({super.key});

  @override
  State<MyMoviesAnimePage> createState() => _MyMoviesAnimePageState();
}

class _MyMoviesAnimePageState extends State<MyMoviesAnimePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff121315),
      body: Center(child: Text('My Movies Anime')),
    );
  }
}
