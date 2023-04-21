import 'package:boxmusic2/ui/library/myartist.dart';
import 'package:boxmusic2/ui/library/myfavor.dart';
import 'package:boxmusic2/ui/library/myplaylist.dart';
import 'package:flutter/material.dart';

class LibraryUi extends StatefulWidget {
  const LibraryUi({Key? key}) : super(key: key);

  @override
  State<LibraryUi> createState() => _LibraryUiState();
}

class _LibraryUiState extends State<LibraryUi> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Library',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          // actions: [
          //   IconButton(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.person,
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //   ),
          // ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.0,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 14,),
            tabs: [
              Tab(
                icon: Icon(Icons.playlist_play,color: Colors.white),
                text: 'Playlists',
              ),
              Tab(
                icon: Icon(Icons.music_note,color: Colors.white),
                text: 'Artists',
              ),
              Tab(
                icon: Icon(Icons.favorite,color: Colors.white),
                text: 'Favorites',
              ),
            ],
          ),
          elevation: 0.0,
        ),
        body: const TabBarView(
          children: [
            MyPlayListUi(),
            MyArtist(),
            MyFavor(),
          ],
        ),
      ),
    );
  }

}