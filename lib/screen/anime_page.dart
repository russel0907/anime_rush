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
      body: Stack(
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
                            widget.media['streamingEpisodes'].isNotEmpty &&
                            widget.media['streamingEpisodes'][0] != null &&
                            widget.media['streamingEpisodes'][0]['thumbnail'] !=
                                null &&
                            (widget.media['streamingEpisodes'][0]['thumbnail']
                                    as String)
                                .isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust the radius as needed
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
                                            Color.fromARGB(106, 195, 195, 195),
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width * 0.85,
                    color: Colors.amber,
                  )
                ],
              ),
            ],
          )
        ],
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
