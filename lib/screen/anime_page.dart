import 'package:anime_rush/screen/season_page.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class AnimePage extends StatefulWidget {
  final dynamic media;

  const AnimePage({
    super.key,
    required this.media,
  });

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121315),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1F2022),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/icon-2.png'),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/circle-avatar.png'),
            ),
          ),
        ],
        title: const SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFF1F2022),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
            ),
            Column(
              children: [
                Column(
                  children: [
                    Center(
                        child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                      ),
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: widget.media['streamingEpisodes'] != null &&
                              widget.media['streamingEpisodes'].isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Stack(
                                alignment: Alignment.center,
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    widget.media['streamingEpisodes'][0]
                                        ['thumbnail'] as String,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(35, 212, 212, 212),
                                              Color.fromARGB(
                                                  106, 195, 195, 195),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Image.asset(
                                              'assets/images/play_button.png',
                                              width: 48.0,
                                              height: 48.0,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text("No streaming episode available"),
                            ),
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xff1F2022),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the desired border radius
                                        child: Image.network(
                                          widget.media['coverImage']['medium']
                                              as String,
                                          width: 84.0,
                                          height: 84.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                        color: const Color(0xff398AD9),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Text(
                                        widget.media['title']['english'] ??
                                            widget.media['title']['romaji'],
                                      )
                                    ],
                                  ),
                                  Image.asset(
                                    'assets/images/save.png',
                                    width: 44.0,
                                    height: 44.0,
                                  ),
                                ],
                              ),
                              const Text('Description'),
                              ExpandableText(
                                widget.media['description']
                                    .replaceAll('<br>', '\n'),
                                expandText: 'Show more',
                                collapseText: 'Show less',
                                maxLines: 3,
                                linkEllipsis: false,
                                linkColor: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Text('Episode Counts'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      // height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xff1F2022),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the desired border radius
                                        child: Image.network(
                                          widget.media['streamingEpisodes'] !=
                                                      null &&
                                                  widget
                                                      .media[
                                                          'streamingEpisodes']
                                                      .isNotEmpty
                                              ? widget.media[
                                                      'streamingEpisodes'][0]
                                                  ['thumbnail'] as String
                                              : widget.media['coverImage']
                                                  ['medium'] as String,
                                          width: 72.0,
                                          height: 72.0,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                        color: const Color(0xff398AD9),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Status : ${widget.media['status'] == 'RELEASING' ? 'ONGOING' : widget.media['status']}'),
                                          Text(
                                              '${widget.media['nextAiringEpisode'] != null ? widget.media['nextAiringEpisode']['episode'] : widget.media['episodes']} Episodes'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SeasonPage(
                                            media: widget.media,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/dropdown.png',
                                      width: 28.0,
                                      height: 28.0,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1F2022),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Color(0xFFDBDBDB),
            ),
            activeIcon: Icon(Icons.notifications, color: Color(0xFF398AD9)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFFDBDBDB)),
            activeIcon: Icon(Icons.home, color: Color(0xFF398AD9)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, color: Color(0xFFDBDBDB)),
            activeIcon: Icon(Icons.bookmark, color: Color(0xFF398AD9)),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF398AD9),
        iconSize: 36,
        onTap: _onItemTapped,
        useLegacyColorScheme: true,
      ),
    );
  }
}
