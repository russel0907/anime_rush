import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/common/app_bottom_nav.dart';
import '../../widgets/common/app_bar_widget.dart';
import '../../widgets/common/search_bar_widget.dart';
import '../../widgets/common/particle_background.dart';
import 'home_anime_tab.dart';
import 'home_manga_tab.dart';
import 'home_movies_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final Map<String, dynamic> variables = {
    'page': 1,
    'perPage': 10,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushNamed(context, '/notifications');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _performSearch(String searchText) {
    if (searchText.trim().isEmpty) return;
    Navigator.pushNamed(
      context,
      '/search',
      arguments: searchText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        bottom: SearchBarWidget(
          controller: _searchController,
          onSubmitted: _performSearch,
        ),
      ),
      body: ParticleBackground(
        particleCount: 15,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                color: AppColors.navBarDark,
                child: TabBar(
                  dividerColor: Colors.transparent,
                  indicatorColor: AppColors.accentBlue,
                  labelColor: AppColors.accentBlue,
                  unselectedLabelColor: AppColors.textSecondary,
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
                    HomeMangaTabPage(variables: variables),
                    HomeMoviesTabPage(variables: variables),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
