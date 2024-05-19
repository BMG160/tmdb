import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmdb/constant/hive_constant.dart';
import 'package:tmdb/data/vos/movie_vo/movie_vo.dart';
import 'package:tmdb/pages/home_page.dart';

void main() async{
  
  await Hive.initFlutter();
  
  Hive.registerAdapter(MovieVOAdapter());

  await Hive.openBox<MovieVO>(kBoxNameGetNowPlaying);
  await Hive.openBox<MovieVO>(kBoxNameGetPopularMovie);
  await Hive.openBox<MovieVO>(kBoxNameGetMoviesByGenres);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

