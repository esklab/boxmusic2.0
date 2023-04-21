import 'package:flutter/material.dart';
import 'package:boxmusic2/models/songs_json.dart';

class MyArtist extends StatefulWidget {
  const MyArtist({Key? key}) : super(key: key);

  @override
  State<MyArtist> createState() => _MyArtistState();
}

class _MyArtistState extends State<MyArtist> {
  List<Map<String, dynamic>> artistList = [];

  @override
  void initState() {
    super.initState();
    // Initialisation de la list des artistes
    for (final album in albums) {
      final artistName = album['artist'];
      if (!artistList.any((artist) => artist['name'] == artistName)) {
        final artistAlbums = albums.where((album) => album['artist'] == artistName).toList();
        final artistImage = artistAlbums[0]['img'];
        artistList.add({'name': artistName, 'img': artistImage});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: artistList.length,
        itemBuilder: (BuildContext context, int index)=> ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              artistList[index]['name'],
              style:const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                //fontFamily: 'OpenSans',
          ),
        ),
      ),

      leading:ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child:
        Image.asset(
          artistList[index]['img'],
          height: 60,
          width: 60,
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            // Afficher une image par défaut en cas d'erreur de chargement
            return const Image(
              image: AssetImage('lib/assets/images/default_artist.jpg'),
              height: 200,
            );
          },
        ),
        // Image.network(
        //   artist['img'],
        //   height: 200,
        //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        //     // Afficher une image par défaut en cas d'erreur de chargement
        //     return const Image(
        //       image: AssetImage('lib/assets/images/default_artist.jpg'),
        //       height: 200,
        //     );
        //   },
        // ),
      ),
        ),
      ),
    );
  }
}
