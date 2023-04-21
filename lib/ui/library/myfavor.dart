import 'package:flutter/material.dart';
import '../../models/songs_json.dart';

class MyFavor extends StatefulWidget {
  const MyFavor({Key? key}) : super(key: key);

  @override
  State<MyFavor> createState() => _MyFavorState();
}

class _MyFavorState extends State<MyFavor> with SingleTickerProviderStateMixin {

  List favAlbums= List.from(albums);
  List songs = [];
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController=TabController(length: 2, vsync: this);
    for (final album in albums) {
      for (final song in album['songs']) {
        songs.add(song);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

  Widget Songs(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                songs[index]['title'],
                style:const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  //fontFamily: 'OpenSans',
                ),
              ),
            ),
            subtitle: Text(
              songs[index]["duration"],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 10
              ),
            ),

            leading:ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child:
              Image.asset(
                songs[index]['duration'],
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
            ),
          );
        },
      ),
    );
  }

  Widget Albums(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: favAlbums.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                favAlbums[index]['title'],
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
                favAlbums[index]['img'],
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
            ),
          );
        }),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                //SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TabBar(
                          labelColor: Colors.pinkAccent[45],
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.white,
                          indicatorWeight: 3,
                          // indicator: BoxDecoration(
                          //   color: Colors.white,
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          controller: tabController,
                          tabs: const [
                            Tab(text:'Songs',),
                            Tab(text:'Albums',),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Songs(context),
                        Albums(context),
                      ],
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
