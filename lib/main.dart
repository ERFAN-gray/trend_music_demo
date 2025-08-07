import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trend_music_demo/pages/home_page.dart';
import 'package:trend_music_demo/themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: TrendMusic()),
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
