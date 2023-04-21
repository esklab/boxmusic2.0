import 'dart:convert';
import 'package:boxmusic2/models/songs_json.dart';
import 'package:boxmusic2/ui/widgets/AlbumUI.dart';
import 'package:boxmusic2/ui/widgets/ArtistUI.dart';
import 'package:boxmusic2/ui/widgets/MusicUI.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../models/music_models.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  List<Map<String, dynamic>> songsLists = [];
  List<Music> songsListsApi = [];
  bool isLoading = true;
  static const apiUrl= 'https://0dab-196-170-127-70.ngrok-free.app/api/';
  static const zikUrl='https://0dab-196-170-127-70.ngrok-free.app/storage/';

  Future<List<Music>> getMusicList() async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}getAllmusics'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final songs = List<Music>.from(data.map((song) => Music.fromJson(song)));
        return songs;
      } else {
        throw Exception('Failed to load music list');
      }
    } catch (e) {
      throw Exception('Failed to load music list: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    for (final album in albums) {
      for (final song in album['songs']) {
        // Add the artist name to the song object
        song['artist'] = album['artist'];
        songsLists.add(song);
      }
    }
    getMusicList().then((songs) {
      setState(() {
        songsListsApi = songs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      //elevation: 0,
      title: const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "BOX MUSIC",
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount:1,
        itemBuilder: (context, index) => ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Recently Listened",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 200,
                child: isLoading
                    ? const Center( child: CircularProgressIndicator(),)
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                // itemCount: songsLists.length,
                  itemCount: songsListsApi.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  child: MusicUi(
                                    musicId: songsListsApi[index].id,
                                    musicTitle: songsListsApi[index].title,
                                    musicArtist: songsListsApi[index].status,
                                    musicUrl:songsListsApi[index].filePath,
                                    musicImg: songsListsApi[index].imagePath,
                                    musicDuration: songsListsApi[index].duration,
                                  ),
                                  type: PageTransitionType.scale
                              )
                          );
                          },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0,3),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        // image: AssetImage(songsLists[index]['img']),
                                        image: NetworkImage(zikUrl+songsListsApi[index].imagePath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // songsLists[index]['title'],
                                      songsListsApi[index].title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // Text(
                                    //   songsLists[index]['artist'],
                                    //   songsListsApi[index].status,
                                    //   maxLines: 1,
                                    //   style: const TextStyle(
                                    //     fontSize: 12,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
                const SizedBox(height: 30),
                const Text(
                  "Recommended Songs",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 14),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: songsLists.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  child: MusicUi(
                                    musicId: songsLists[index]['id'],
                                    musicTitle: songsLists[index]['title'],
                                    musicArtist: songsLists[index]['artist'],
                                    musicUrl:songsLists[index]['song_url'],
                                    musicImg: songsLists[index]['img'],
                                    musicDuration: songsLists[index]['duration'],
                                  ),
                                  type: PageTransitionType.scale
                              )
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0,3),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(songsLists[index]['img']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        songsLists[index]['title'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        songsLists[index]['artist'],
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
                const Text(
                  "Recommended Albums ",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: albums.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: AlbumUi(albumUi: albums[index],
                                    ),
                                    type: PageTransitionType.scale));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(0, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              albums[index]['img']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          albums[index]['title'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          albums[index]['description'],
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              const Text(
                "Recommended Artists",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
              child: SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              alignment: Alignment.bottomCenter,
                              child: ArtistUi(artistUi: albums[index]),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: Container(
                          height: 240,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    albums[index]['img'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                right: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      albums[index]['artist'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.5),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
