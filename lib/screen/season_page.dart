import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SeasonPage extends StatefulWidget {
  final dynamic media;

  const SeasonPage({
    super.key,
    required this.media,
  });

  @override
  State<SeasonPage> createState() => _SeasonPageState();
}

class _SeasonPageState extends State<SeasonPage> {
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
                  child: widget.media['bannerImage'] != null &&
                          widget.media['bannerImage'].isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius as needed
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                widget.media['bannerImage'] as String,
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
                                          Color.fromARGB(0, 238, 238, 238),
                                          Color.fromARGB(242, 0, 0, 0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            color: const Color(0xff398AD9),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, bottom: 15),
                                            child: Text(
                                              widget.media['title']
                                                      ['english'] ??
                                                  widget.media['title']
                                                      ['romaji'],
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
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
                    height: MediaQuery.of(context).size.height * 0.065,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.365,
                            color: const Color(0xff0B0D11),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Episode Count'),
                                )),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.24,
                            color: const Color(0xff1F2022),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Center(child: Text('English Sub'))),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.24,
                            color: const Color(0xff1F2022),
                            child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Center(child: Text('English Dub'))),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: widget.media['streamingEpisodes'].length,
                          itemBuilder: (BuildContext context, int index) {
                            final episode =
                                widget.media['streamingEpisodes'][index];
                            final double paddingValue = index ==
                                    widget.media['streamingEpisodes'].length - 1
                                ? MediaQuery.of(context).size.height * 0.12
                                : MediaQuery.of(context).size.height * 0.03;

                            return Padding(
                              padding: EdgeInsets.only(bottom: paddingValue),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      episode['thumbnail'] as String,
                                      width: 72.0,
                                      height: 72.0,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${episode['title'].split(' - ')[1]}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${episode['title'].split(' - ')[0]}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      var url = Uri.parse(episode['url']);

                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/images/tick.png',
                                      width: 28.0,
                                      height: 28.0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                  ),
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
