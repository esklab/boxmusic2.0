
class Playlist {
  //final int id;
  final String name;

  Playlist({ /*required this.id,*/ required this.name});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      //id:json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    //'id':id,
    'name': name,
  };
}

// class Playlist {
//   late String status;
//   late String message;
//   late String response;
//   Playlist({
//     required this.status,
//     required this.message,
//     required this.response,
//   });
//
//   static late List<PlaylistItem> playlists;
//   static late List<Images> images;
//
//   Playlist.getuserid(dynamic obj) {
//     playlists = obj
//         .map<PlaylistItem>((json) => new PlaylistItem.fromJson(json)).toList();
//   }
// }
//
// class PlaylistItem {
//   final String userplaylistid;
//   final String userplaylistname;
//   final int musicCount;
//   final List<Images> imagesslist;
//
//   PlaylistItem({
//     required this.userplaylistid,
//     required this.userplaylistname,
//     required this.imagesslist,
//     required this.musicCount,
//   });
//
//   factory PlaylistItem.fromJson(Map<String, dynamic> jsonMap) {
//     var list = jsonMap['images'] as List;
//     List<Images> imagesList = list.map((i) => Images.fromJson(i)).toList();
//
//     return PlaylistItem(
//       userplaylistid: jsonMap['user_playlist_id'],
//       userplaylistname: jsonMap['user_playlist_name'] ?? '',
//       musicCount: jsonMap['music_count'] ?? 0,
//       imagesslist: imagesList,
//     );
//   }
// }
//
// class Images {
//   final String musicImage;
//   Images({required this.musicImage});
//   factory Images.fromJson(Map<String, dynamic> jsonMap) {
//     return Images(musicImage: jsonMap['music_image']);
//   }
// }

