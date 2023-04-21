class Music {
  final int id;
  final String title;
  final String filePath;
  final String imagePath;
  final String size;
  final String duration;
  final String status;
  final int badgeId;
  final int categoryId;
  // final int playlistId;
  // final int musicParentId;
  // final String createdAt;
  // final String updatedAt;
  // final int nbLecture;
  // final List<dynamic> likes;
  // final List<dynamic> downLoadings;
  // final Map<String, dynamic> parent;
  // final Map<String, dynamic> category;

  Music({
    required this.id,
    required this.title,
    required this.filePath,
    required this.imagePath,
    required this.size,
    required this.duration,
    required this.status,
    required this.badgeId,
    required this.categoryId,
    // required this.playlistId,
    // required this.musicParentId,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.nbLecture,
    // required this.likes,
    // required this.downLoadings,
    // required this.parent,
    // required this.category,
  });

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      title: json['title'],
      filePath: json['file_path'],
      imagePath: json['image_path'],
      size: json['size'],
      duration: json['duration'],
      status: json['status'],
      badgeId: json['badge_id'],
      categoryId: json['category_id'],
      // playlistId: json['playlist_id'],
      // musicParentId: json['music_parent_id'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      // nbLecture: json['nb_lecture'],
      // likes: json['likes'],
      // downLoadings: json['downloadings'],
      // parent: json['parent'],
      // category: json['category'],
    );
  }
}

// class PlayMusic {
//   late String status;
//   late String message;
//   late String response;
//
//   static late List<PlayMusicItem> playMusic;
//
//   PlayMusic.getuserid(dynamic obj) {
//     playMusic = obj
//         .map<PlayMusicItem>((json) => PlayMusicItem.fromJson(json))
//         .toList();
//   }
// }
//
// class PlayMusicItem {
//   final String musicTitle;
//   final String musicId;
//   final String musicFile;
//   final String musicImage;
//   final String musicDuration;
//   int? isLiked;
//   //final int likeCount;
//   final String albumName;
//   final List<Artists> artistList;
//
//   PlayMusicItem({
//     required this.musicId,
//     required this.musicTitle,
//     required this.musicImage,
//     required this.musicDuration,
//     required this.musicFile,
//     //required this.likeCount,
//     required this.albumName,
//     required this.artistList,
//     this.isLiked,
//   });
//
//   factory PlayMusicItem.fromJson(Map<String, dynamic> jsonMap) {
//     var list = jsonMap['artists'] as List;
//     // print(list.runtimeType);
//     List<Artists> imagesList = list.map((i) => Artists.fromJson(i)).toList();
//
//     return PlayMusicItem(
//         musicDuration: jsonMap['music_duration'],
//         isLiked: jsonMap['is_liked'] ?? 0,
//         musicFile: jsonMap['music_file'] ?? '',
//         musicImage: jsonMap['music_image'] ?? '',
//         //likeCount: jsonMap['like_count'] ?? '',
//         musicId: jsonMap['music_id'],
//         albumName: jsonMap['album_name'] ?? '',
//         artistList: imagesList,
//         musicTitle: jsonMap['music_title'] ?? '');
//   }
// }
//
// class Artists {
//   final String artistname;
//   Artists({
//     required this.artistname,
//   });
//   factory Artists.fromJson(Map<String, dynamic> jsonMap) {
//     return Artists(
//       artistname: jsonMap['artist_name'],
//     );
//   }
// }
