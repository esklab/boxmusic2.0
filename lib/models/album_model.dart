class AlbumModel {
  late String status;
  late String message;
  late String response;
  static late List<AlbumModelItem> popalbumlist;

  AlbumModel.getuserid(dynamic obj) {
    popalbumlist = obj
        .map<AlbumModelItem>((json) => AlbumModelItem.fromJson(json))
        .toList();
  }
}

class AlbumModelItem {
  final String albumId;
  final String albumName;
  final String albumDescription;
  final String albumImage;
  //final String viewCount;
  final int isLiked;
  //final int likeCount;
  final int musicCount;

  AlbumModelItem({
    required this.albumId,
    required this.albumName,
    required this.albumDescription,
    required this.albumImage,
    //required this.viewCount,
    required this.musicCount,
    required this.isLiked,
    //required this.likeCount,
  });

  factory AlbumModelItem.fromJson(Map<String, dynamic> jsonMap) {
    return AlbumModelItem(
      albumId: jsonMap['album_id'],
      albumName: jsonMap['album_name'] ?? '',
      albumDescription: jsonMap['album_description'] ?? '',
      albumImage: jsonMap['album_image'] ?? '',
      isLiked: jsonMap['is_liked'] ?? 0,
      //likeCount: jsonMap['like_count'] ?? 0,
      musicCount: jsonMap['music_count'] ?? 0,
      //viewCount: jsonMap['viewCount'] ?? '',
    );
  }
}
