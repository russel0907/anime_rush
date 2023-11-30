import 'package:anime_rush/screen/in_progress_anime_page.dart';
import 'package:anime_rush/screen/my_movies_anime_page.dart';
import 'package:anime_rush/screen/saved_anime_page.dart';
import 'package:flutter/material.dart';

import 'my_activities_anime_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        backgroundColor: const Color(0xff121315),
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
          Column(
            children: [
              Container(
                color: const Color(0xff121315),
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: const Color(0xFF1F2022),
                height: MediaQuery.of(context).size.height * 0.15,
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Followers',
                              style: TextStyle(color: Color(0xff398AD9)),
                            ),
                            Text('777'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Following',
                              style: TextStyle(color: Color(0xff398AD9)),
                            ),
                            Text('200'),
                          ],
                        )
                      ],
                    ),
                    Text("Levi34"),
                    Text("Berlin, Germany"),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xff121315),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: const Color(0xff398AD9),
                      labelColor: const Color(0xff398AD9),
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Saved Anime'),
                        Tab(text: 'In Progress'),
                        Tab(text: 'Movies'),
                        Tab(text: 'Activities'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        SavedAnimePage(),
                        InProgressAnimePage(),
                        MyMoviesAnimePage(),
                        MyActivitiesAnimePage()
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15 - 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Image.asset(
              'assets/images/circle-profile.png',
              width: 100,
              height: 100,
            ),
          ),
        ],
      )),
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
