import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_music_demo/pages/home_page.dart';
import 'package:trend_music_demo/providers/music_provider.dart';
import 'package:trend_music_demo/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MusicProvider()),
      ],
      child: TrendMusic(),
    ),
  );
}

class TrendMusic extends StatelessWidget {
  const TrendMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context).theme,
    );
  }
}
