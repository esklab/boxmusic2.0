class Artists {
  late String status;
  late String message;
  late String response;
  static late List<ArtistsItem> favList;

  Artists.getuserid(dynamic obj) {
    favList = obj
        .map<ArtistsItem>((json) => ArtistsItem.fromJson(json))
        .toList();
  }
}

class ArtistsItem {
  final String artistId;
  final String artistName;
  final String artistImage;
  //int likedCount;
  // int isLiked;

  ArtistsItem({
    required this.artistId,
    required this.artistName,
    required this.artistImage,
    // required this.likedCount,
    // required this.isLiked,
  });

  factory ArtistsItem.fromJson(Map<String, dynamic> jsonMap) {
    return ArtistsItem(
      artistId: jsonMap['artist_id'],
      artistName: jsonMap['artist_name'] ?? '',
      artistImage: jsonMap['artist_image'] ?? '',
      // isLiked: jsonMap['is_liked'] ?? 0,
      // likedCount: jsonMap['like_count'] ?? 0,
    );
  }
}
