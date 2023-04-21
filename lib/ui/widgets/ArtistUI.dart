import 'package:boxmusic2/models/songs_json.dart';
import 'package:boxmusic2/ui/widgets/AlbumUI.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'MusicUI.dart';

class ArtistUi extends StatefulWidget {
  const ArtistUi({Key? key,this.artistUi}) : super(key: key);
  final dynamic artistUi;
  @override
  State<ArtistUi> createState() => _ArtistUiState();
}

class _ArtistUiState extends State<ArtistUi> {
  bool _subscribed = false;

  void _toggleSubscription() {
    setState(() {
      _subscribed = !_subscribed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List songAlbums = widget.artistUi['songs'];
    return Padding(
      padding: const EdgeInsets.only(top: 0,bottom: 0),
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
                          image:
                          AssetImage(widget.artistUi['img']),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.artistUi['artist'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: _toggleSubscription,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _subscribed ? Colors.green : Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    _subscribed ? Icons.check : Icons.subscriptions_outlined,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _subscribed ? "Subscriber" : "Subscribe",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: List.generate(albums.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: AlbumUi(
                                      albumUi: albums[index],
                                    ),
                                    type: PageTransitionType.scale,
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(albums[index]['img']),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    albums[index]['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        albums[index]['song_count'],
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 38,),
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
              const SizedBox(height: 38,),
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
