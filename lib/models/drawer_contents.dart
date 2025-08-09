import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:trend_music_demo/providers/theme_provider.dart';

class DrawerContents extends StatelessWidget {
  const DrawerContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(child: Icon(Icons.music_note_rounded, size: 80)),
        Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "dark mode",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              CupertinoSwitch(
                inactiveTrackColor: Colors.red.shade400,
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
