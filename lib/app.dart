import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'config/theme.dart';
import 'services/graphql_service.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/question_page.dart';
import 'screens/auth/question_page_2.dart';
import 'screens/home/home_page.dart';
import 'screens/anime/anime_detail_page.dart';
import 'screens/profile/profile_page.dart';
import 'screens/notifications/notification_page.dart';
import 'screens/search/search_result_page.dart';

class AnimeRushApp extends StatelessWidget {
  const AnimeRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: graphQLClient,
      child: MaterialApp(
        title: 'Anime Rush',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
            case '/question':
              return MaterialPageRoute(
                builder: (_) => const QuestionPage(),
              );
            case '/question2':
              return MaterialPageRoute(
                builder: (_) => const Question2Page(),
              );
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomePage(),
              );
            case '/anime-detail':
              final media = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => AnimeDetailPage(media: media),
              );
            case '/profile':
              return MaterialPageRoute(
                builder: (_) => const ProfilePage(),
              );
            case '/notifications':
              return MaterialPageRoute(
                builder: (_) => const NotificationPage(),
              );
            case '/search':
              final searchTerm = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => SearchResultPage(searchTerm: searchTerm),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
          }
        },
      ),
    );
  }
}
