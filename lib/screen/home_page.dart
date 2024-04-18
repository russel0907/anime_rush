import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            headComponent(),
            vsingRoom(),
            peoplePerformingList(),
            interestedList()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xff0C0A32),
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/home_bottom_app_bar_icon_inactive.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/home_bottom_app_bar_icon_active.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/moments_bottom_app_bar_icon_inactive.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/moments_bottom_app_bar_icon_active.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Moments',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/earn_bottom_app_bar_icon_inactive.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/earn_bottom_app_bar_icon_active.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Earn',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/chat_bottom_app_bar_icon_inactive.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/chat_bottom_app_bar_icon_active.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/profile_bottom_app_bar_icon_inactive.png',
                  width: 24,
                  height: 24,
                ),
                activeIcon: Image.asset(
                  'assets/images/profile_bottom_app_bar_icon_active.png',
                  width: 24,
                  height: 24,
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFFA2A1DD),
            unselectedItemColor: const Color(0xFF35357B),
            iconSize: 36,
            onTap: _onItemTapped,
            useLegacyColorScheme: true,
          ),
        ),
      ),
    );
  }

  Widget headComponent() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.search,
              color: Color(0xFFA2A1DD),
              size: 32,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Image.asset(
                    'assets/images/profile_pic.png',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  children: [
                    Container(
                      color: const Color(0xff302D62),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Color(0xFFA2A1DD),
                          ),
                          Text('Unlock Titles')
                        ],
                      ),
                    ),
                    const Text(
                      'Michelle Wong',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: ClipPolygon(
                sides: 6,
                borderRadius: 5.0,
                rotate: 0,
                child: Image.asset(
                  'assets/images/profile_pic_2.png',
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget vsingRoom() {
    return const Column(
      children: [],
    );
  }

  Widget peoplePerformingList() {
    return const Column(
      children: [],
    );
  }

  Widget interestedList() {
    return const Column(
      children: [],
    );
  }
}
