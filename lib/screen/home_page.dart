import 'package:anime_rush/screen/home_anime_page.dart';
import 'package:anime_rush/screen/home_manga_page.dart';
import 'package:anime_rush/screen/home_movies_page.dart';
import 'package:anime_rush/screen/notification_page.dart';
import 'package:anime_rush/screen/profile_page.dart';
import 'package:anime_rush/screen/search_result_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  final String getMangaTrend = '''

{
  Page(page: 1, perPage: 10) {
    media(format: MANGA) {
      id
      description
      title {
        romaji
        english
        native
        userPreferred
      }
      format
      coverImage{
        large
      }
    }
  }
}

''';

  final String getMovieTrend = '''

{
  Page(page: 1, perPage: 10) {
    media(format: MOVIE) {
      id
      description
      title {
        romaji
        english
        native
        userPreferred
      }
      format
      coverImage{
        large
      }
    }
  }
}

''';

  var variables = {
    'page': 1,
    'perPage': 10,
  };

  void _onItemTapped(int index) {
    if (index == 0) {
      // Navigate to the NotificationPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationPage(
            variables: variables,
          ), // Replace with the actual widget
        ),
      );
    } else {
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

  List<SearchResult> allSearchResults = [
    SearchResult(title: "Item 1", description: "Description 1"),
    SearchResult(title: "Item 2", description: "Description 2"),
    SearchResult(title: "Item 3", description: "Description 3"),
  ];

  void _performSearch(String searchText) {
    // Filter the search results based on the search query
    List<SearchResult> searchResults = allSearchResults
        .where((result) =>
            result.title.toLowerCase().contains(searchText.toLowerCase()) ||
            result.description.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    // Navigate to the SearchResultPage with the filtered search results
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultPage(
            searchResults: searchResults, searchText: searchText),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF1F2022),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/icon-2.png'),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/images/circle-avatar.png'),
              ),
            ),
          ),
        ],
        title: const SizedBox.shrink(),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.015),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  color: const Color(0xff121315),
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (searchText) {
                      _performSearch(searchText);
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16.0),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            )),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xff121315),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xFF1F2022),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Anime'),
                      Tab(text: 'Manga'),
                      Tab(text: 'Movie'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      HomeAnimeTabPage(variables: variables),
                      HomeMangaTabPage(
                          getMediaTrend: getMangaTrend, variables: variables),
                      HomeMoviesTabPage(
                          getMediaTrend: getMovieTrend, variables: variables)
                    ],
                  ),
                ),
              ],
            ),
          ),
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
