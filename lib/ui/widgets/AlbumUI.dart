import 'package:boxmusic2/ui/widgets/MusicUI.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:boxmusic2/models/songs_json.dart';

class AlbumUi extends StatefulWidget {
  const AlbumUi({Key? key, this.albumUi}) : super(key: key);
  final dynamic albumUi;

  @override
  State<AlbumUi> createState() => _AlbumUiState();
}

class _AlbumUiState extends State<AlbumUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List songAlbums = widget.albumUi['songs'];
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 6),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: size.width,
                  height: 220,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.albumUi['img']),
                          fit: BoxFit.cover
                      ),
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          widget.albumUi['title'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                      ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              child: MusicUi(
                                musicId: songAlbums[0]['id'],
                                musicTitle: songAlbums[0]['title'],
                                musicArtist: songAlbums[0]['artist'],
                                musicUrl:songAlbums[0]['song_url'],
                                musicImg: songAlbums[0]['img'],
                                musicDuration: songAlbums[0]['duration'],
                              ),
                              type: PageTransitionType.scale
                          )
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Play",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),],
                  ),
                ),
                const SizedBox(height: 30,),
                Column(
                    children: List.generate(songAlbums.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      child: MusicUi(
                                        musicId: songAlbums[index]['id'],
                                        musicTitle: songAlbums[index]['title'],
                                        musicArtist: songAlbums[index]['artist'],
                                        musicUrl:songAlbums[index]['song_url'],
                                        musicImg: songAlbums[index]['img'],
                                        musicDuration: songAlbums[index]['duration'],
                                      ),
                                      type: PageTransitionType.scale
                                  )
                              );
                              },
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (size.width - 60) * 0.77,
                                child: Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "${index + 1}  " + songAlbums[index]['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: (size.width - 60) * 0.23,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      songAlbums[index]['duration'],
                                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                                    ),
                                    const SizedBox(width: 25,),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                      child: const Center(
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.white,
                                      height: 2,
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ),
                        ),
                      );
                    })
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
      ]),
      ),
    );
  }
}