import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import 'package:music_player/models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("P L A Y L I S T"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        final List<Song> playlist = value.playlist;
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
            final Song song = playlist[index];
            return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artistName),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(song.imagePath)),
              onTap: () => goToSong(index),
            );
          },
        );
      }),
    );
  }
}
