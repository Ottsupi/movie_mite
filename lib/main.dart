import 'package:flutter/material.dart';
import 'package:movie_mite/core/database/setup.dart';
import 'package:movie_mite/core/network/api_client.dart';
import 'package:movie_mite/core/utils/logs/logger.dart';
import 'package:movie_mite/features/movie/presentation/pages/browse_movies_tabs_page.dart';

void main() {
  setupLogger();
  setupDio();
  setupDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BrowseMoviesTabsPage(),
    );
  }
}
