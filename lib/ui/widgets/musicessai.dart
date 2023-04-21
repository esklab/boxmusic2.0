import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() async {
    try {
      await _audioPlayer.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
      _audioPlayer.durationStream.listen((duration) {
        setState(() {});
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<Duration?>(
            stream: _audioPlayer.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              return StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
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
                      _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                    },
                  );
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                  await _audioPlayer.play();
                },
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () async {
                  await _audioPlayer.pause();
                },
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () async {
                  await _audioPlayer.stop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
//
// class MusicPage extends StatefulWidget {
//   const MusicPage({super.key});
//
//   @override
//   _MusicPageState createState() => _MusicPageState();
// }
//
// class _MusicPageState extends State<MusicPage> {
//   late AudioPlayer player;
//   bool isPlaying = false;
//   bool isPaused = false;
//
//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer();
//   }
//
//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
//
//   Future<void> playAudio(String url) async {
//     await player.setUrl(url);
//     await player.play();
//     setState(() {
//       isPlaying = true;
//       isPaused = false;
//     });
//   }
//
//   Future<void> pauseAudio() async {
//     await player.pause();
//     setState(() {
//       isPlaying = false;
//     });
//     final state = player.playerState;
//     if (state.processingState == ProcessingState.ready && !state.playing) {
//       setState(() {
//         isPaused = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: const Text('Play'),
//               onPressed: () => playAudio('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isPlaying ? pauseAudio : null,
//               child: const Text('Pause'),
//             ),
//             const SizedBox(height: 20),
//             if (isPaused) const Text('Paused'),
//           ],
//         ),
//       ),
//     );
//   }
// }
