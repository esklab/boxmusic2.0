
import 'package:boxmusic2/ui/widgets/AlbumUI.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:boxmusic2/models/songs_json.dart';

class SearchUi extends StatefulWidget {
  const SearchUi({Key? key}) : super(key: key);

  @override
  State<SearchUi> createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {

  List displayList = List.from(albums);

  void updateList(String value) {
    setState(() {
      displayList = albums
          .where((element) =>
      element['title'] != null &&
          element['title'].toLowerCase().contains(value.toLowerCase()) ||
          element['artist'] != null &&
              element['artist'].toLowerCase().contains(value.toLowerCase()) ||
          element['songs'] != null &&
              element['songs']
                  .where((song) =>
              song['title'] != null &&
                  song['title'].toLowerCase().contains(value.toLowerCase()) ||
                  song['artist'] != null &&
                      song['artist'].toLowerCase().contains(value.toLowerCase()))
                  .isNotEmpty)
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          "Research",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12.0,),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(16.0),
              ),
              height: 56.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) => updateList(value),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 16.0),
                    prefixIcon: Icon(Icons.search, color: Colors.black,),
                    hintText: 'Search for music',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Expanded(
              child: displayList.isEmpty
                  ? const Center(
                child: Text(
                  "No results found",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              child: AlbumUi(albumUi: albums[index],),
                              type: PageTransitionType.scale
                          )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              displayList[index]['img'],
                              height: 78,
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16.0,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  displayList[index]['title'],
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                                const SizedBox(height: 4.0,),
                                Text(
                                  displayList[index]['artist'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}