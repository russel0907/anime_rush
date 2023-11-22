import 'dart:async';
import 'package:flutter/material.dart';

class SearchResultPage extends StatefulWidget {
  final List<SearchResult> searchResults;
  final String searchText;

  const SearchResultPage(
      {Key? key, required this.searchResults, required this.searchText})
      : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121315),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1F2022),
        title: const SizedBox.shrink(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.015),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Results :'),
                  Text(widget.searchText),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16,
                top: MediaQuery.of(context).size.height * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!isLoading)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.searchResults.map((result) {
                        return ListTile(
                          title: Text(result.title),
                          subtitle: Text(result.description),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResult {
  final String title;
  final String description;

  SearchResult({
    required this.title,
    required this.description,
  });
}
