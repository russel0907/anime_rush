import 'package:flutter/material.dart';

class SavedAnimePage extends StatefulWidget {
  const SavedAnimePage({super.key});

  @override
  State<SavedAnimePage> createState() => _SavedAnimePageState();
}

class _SavedAnimePageState extends State<SavedAnimePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff121315),
      body: Center(child: Text('Saved Anime')),
    );
  }
}
