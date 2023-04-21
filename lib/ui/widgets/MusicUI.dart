import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../models/music_models.dart';
import '../../models/songs_json.dart';
import 'package:http/http.dart' as http;

class MusicUi extends StatefulWidget {
  final int musicId;
  final String musicTitle;
  final String musicArtist;
  final String musicUrl;
  final String musicImg;
  final String musicDuration;

  const MusicUi({
    super.key,
    required this.musicId,
    required this.musicTitle,
    required this.musicArtist,
    required this.musicUrl,
    required this.musicImg,
    required this.musicDuration,
  });

  @override
  State<MusicUi> createState() => _MusicUiState();
}

class _MusicUiState extends State<MusicUi> {
  int currentSongIndex = 0;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<PositionDiscontinuity>? _positionSubscription;
  Duration? currentPosition = Duration.zero;
  Duration? totalDuration = Duration.zero;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  bool isPaused = false;
  bool isFavorite = false;
  bool isLoading = true;
  List songs= [];
  List songsApi =[];
  List<dynamic> _playlists = [];
  static const apiUrl= 'https://0dab-196-170-127-70.ngrok-free.app/api/';
  static const zikUrl='https://0dab-196-170-127-70.ngrok-free.app/storage/';

  Future<void> _getPlaylists() async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}getplaylists'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _playlists = data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching playlists: $error');
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to fetch playlists'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

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
    songs = albums[currentSongIndex]["songs"];
    _getPlaylists();
    isLoading = false;
    _initAudioPlayer();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    getMusicList().then((songs) {
      setState(() {
        songsApi = songs;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _initAudioPlayer() async {
    try {
      await player.setUrl(zikUrl+widget.musicUrl);
      player.durationStream.listen((duration) {
        setState(() {
          totalDuration = duration;
        });
        player.positionStream.listen((position) => setState(() {
          currentPosition = position;
        }));
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> playAudio(String url) async {
    await player.setUrl(url);
    await player.play();
    setState(() {
      isPlaying = true;
      isPaused = false;
    });
  }

  Future<void> pauseAudio() async {
    await player.pause();
    setState(() {
      isPlaying = false;
    });
    final state = player.playerState;
    if (state.processingState == ProcessingState.ready && !state.playing) {
      setState(() {
        isPaused = true;
      });
    }
  }
  // void playNextSong() {
  //   if (currentSongIndex < songs.length - 1) {
  //     currentSongIndex++;
  //     // playAudio(songs[currentSongIndex]['song_url']);
  //     playAudio(songs[currentSongIndex][zikUrl+widget.musicUrl]);
  //   }
  // }
  // void playPreviousSong() {
  //   if (currentSongIndex > 0) {
  //     currentSongIndex--;
  //     // playAudio(songs[currentSongIndex]['song_url']);
  //     playAudio(songs[currentSongIndex][zikUrl+widget.musicUrl]);
  //   }
  // }
  void playNextSong() {
   setState(() {
     currentSongIndex++;
     if(currentSongIndex >= songsApi.length){
       currentSongIndex=0;
      playAudio(songsApi[currentSongIndex]);
     }
   });
  }
  void playPreviousSong() {
    setState(() {
      currentSongIndex--;
      if (currentSongIndex < 0) {
        currentSongIndex = songsApi.length - 1;
      }
    });
  }

  Future<void> seekSound(int seconds) async {
    Duration newPosition = player.position + Duration(seconds: seconds);
    await player.seek(newPosition);
  }

  String getMinutes(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white,),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 100,
                  height: size.width - 100,
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        blurRadius: 50,
                        spreadRadius: 5,
                        offset: Offset(-10, 40))
                  ], borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 60,
                  height: size.width - 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(zikUrl+widget.musicImg),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
            child: SizedBox(
              width: size.width - 80,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.musicTitle,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(
                      //   width: 150,
                      //   child: Text(
                      //     widget.musicArtist,
                      //     maxLines: 1,
                      //     textAlign: TextAlign.center,
                      //     style: TextStyle(
                      //         fontSize: 15, color: Colors.white.withOpacity(0.5)),
                      //   ),
                      // ),
                    ],),],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          StreamBuilder<Duration?>(
            stream: player.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  var position = snapshot.data ?? Duration.zero;
                  if (position > duration) {
                    position = duration;
                  }
                  return Slider(
                    min: 0,
                    max: duration.inMilliseconds.toDouble(),
                    value: position.inMilliseconds.toDouble(),
                    onChanged: (double value) {
                      player.seek(Duration(milliseconds: value.toInt()));
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getMinutes(currentPosition!),
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                Text(
                  getMinutes(totalDuration!),
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ],),
          ),
          const SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: _showDialog
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    ),
                  onPressed: playPreviousSong,),
                IconButton(
                    iconSize: 50,
                    icon: Container(
                      decoration:
                      const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                      child: Center(
                        child: Icon(
                          isPlaying ? Icons.pause :Icons.play_arrow,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                    if (isPlaying) {
                       playAudio(zikUrl+widget.musicUrl);
                    } else {
                      pauseAudio();
                    }
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    ),
                  onPressed: playNextSong,),
                IconButton(
                    icon: Icon(
                      isFavorite? Icons.favorite : Icons.favorite_border,
                      color: Colors.white.withOpacity(0.8),
                      size: 25,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        setState(() {
                          isFavorite = false;
                        });
                      } else {
                        setState(() {
                          isFavorite = true;
                        });
                      }
                    }),
              ],),
          ),
          const SizedBox(height: 25,)
        ],
      ),
    );
  }
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("lib/assets/images/default_artist.jpg"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Select a playlist',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: isLoading
                      ? const Center(child:CircularProgressIndicator(),)
                      : ListView.separated(
                    itemCount: _playlists.length,
                    separatorBuilder: (BuildContext context, int index) => const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 0.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.music_note, color: Colors.black),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _playlists[index]['name'],
                                      style: const TextStyle(fontSize: 16.0,color: Colors.black),
                                    ),
                                    const SizedBox(height: 4.0),
                                  ],),
                              ),],
                          ),
                        ),
                      );
                    },),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  child:const Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }
}