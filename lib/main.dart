import 'package:anime_rush/screen/login_page.dart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  runApp(const MyApp());
}

final HttpLink httpLink = HttpLink(
  'https://graphql.anilist.co',
);

final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.fredokaTextTheme(
            ThemeData(brightness: Brightness.dark).textTheme.copyWith(
                  bodyLarge: const TextStyle(color: Colors.white),
                  bodyMedium: const TextStyle(color: Colors.white),
                  labelLarge: const TextStyle(color: Colors.white),
                  labelMedium: const TextStyle(color: Colors.white),
                  labelSmall: const TextStyle(color: Colors.white),
                ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
