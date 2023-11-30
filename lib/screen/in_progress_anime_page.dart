import 'package:flutter/material.dart';

class InProgressAnimePage extends StatefulWidget {
  const InProgressAnimePage({super.key});

  @override
  State<InProgressAnimePage> createState() => _InProgressAnimePageState();
}

class _InProgressAnimePageState extends State<InProgressAnimePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff121315),
      body: Center(child: Text('In Progress Anime')),
    );
  }
}
