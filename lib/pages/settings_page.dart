import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('S E T T I N G S'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 3,
              spreadRadius: 1,
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dark Mode'),
            CupertinoSwitch(
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).switchMode(),
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            ),
          ],
        ),
      )
    );
  }
}
