// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/playlist_model.dart';
import '../models/users_model.dart';

class NetworkUtils {

  // ignore: non_constant_identifier_names
  static const BASEURL = "https://clear-geese-rush-196-170-127-70.loca.lt/api/";

  // ignore: non_constant_identifier_names
  static const BaserL1 = "https://b3bd-2c0f-f0f8-64a-0-7d7a-7f06-d342-22dd.eu.ngrok.io/ThaVicious/api/api/";

  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(Uri.parse(url)).then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" + statusCode.toString() + ",\"message\":\"error\",\"response\":" + res + "}";
        throw Exception(statusCode);
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String baseUrl,
      {required Map<String, String> headers, body, encoding}) {
    return http
        .post(Uri.parse(baseUrl),
        body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      String res = response.body;
      int statusCode = response.statusCode;
      print("API Response: " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        res = "{\"status\":" + statusCode.toString() + ",\"message\":\"error\",\"response\":" + res + "}";
        throw Exception(statusCode);
      }
      return _decoder.convert(res);
    });
  }

  Future addPlaylist(String name) async {
    await post(
      BASEURL + 'createPlayList',
      body: {
        'user_id': '1',
        'user_playlist_name': name,
      },
      headers: {},
    );
  }

  // Future getPlaylist() async {
  //   await post(
  //       BASEURL + 'getplaylists',
  //       body: {
  //         'user_id': '1',
  //       },
  //       headers: {}).then((value) {
  //         return Playlist.getuserid(value);
  //   });
  // }

  // Future deleteplaylist(String id) async {
  //   await post(BASEURL + 'deletePlayList',
  //       body: {'user_id': '1', 'user_playlist_id': id}, headers: {});
  // }

  // Future getAllMusics() async {
  //   await post(apiUrl+ '');
  // }
  Future<List<Users>?> postGoogleSignin(
      String email,
      String pass,
      ) async {
    final response = await http.post(
      Uri.parse(BASEURL + 'signin'),
      body: {
        'user_email': email,
        'is_social_login': pass,
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var jsons = response.body;
      // var decode = json.decode(jsons);

      final List<Users> users = userFromJson(jsons);

      return users;
    } else {
      return null;
    }
  }

  Future<List<Users>?> postlogin(
      String email,
      String pass,
      ) async {
    final response = await http.post(
      Uri.parse(BASEURL + 'signin'),
      body: {
        'user_email': email,
        'user_password': pass,
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var jsons = response.body;

      final List<Users> users = userFromJson(jsons);

      return users;
    } else {
      return null;
    }
  }

  Future<SignupUser?> postSignup(
      String email,
      String pass,
      String username,
      ) async {
    final response = await http.post(
      Uri.parse(BASEURL + 'signup'),
      body: {
        'user_email': email,
        'user_password': pass,
        'user_name': username,
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var jsons = response.body;
      // var decode = json.decode(jsons);

      final SignupUser users = signupUserFromJson(jsons);

      return users;
    } else {
      return null;
    }
  }

  Future<SignupUser?> postGoogleSignUp(
      String email,
      String pass,
      String username,
      ) async {
    final response = await http.post(
      Uri.parse(BASEURL + 'signup'),
      body: {
        'user_email': email,
        'user_password': pass,
        'user_name': username,
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      var jsons = response.body;
      // var decode = json.decode(jsons);

      final SignupUser users = signupUserFromJson(jsons);

      return users;
    } else {
      return null;
    }
  }


//   Future getallcomponents() async {
//     await post(BASEURL + 'home_components', body: {}, headers: {})
//         .then((value) {
//       var result = AllComponents.getuserid(value);
//       return result;
//     });
//   }
//
//   Future getBannerSlider() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Banner Slider',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = Banner.getuserid(value);
//       return result;
//     });
//   }
//
//   Future mostplayed() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Most Played',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = m.MostPlayed.getuserid(value);
//       return result;
//     });
//   }
//
//   Future allmusic() async {
//     await post(BASEURL + 'getAllMusics', body: {
//       'user_id': '1',
//     }, headers: {}).then((value) {
//       return m.MostPlayed.getuserid(value);
//     });
//   }
//
//   Future recommededMusic() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Recommended Music',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = m.MostPlayed.getuserid(value);
//       return result;
//     });
//   }
//
//   Future addMusicinPlaylist(String playlistid, String musicid) async {
//     await post(BASEURL + 'addInPlaylist', body: {
//       'user_id': '1',
//       'user_playlist_id': playlistid,
//       'music_id': musicid,
//     }, headers: {});
//   }
//
//   Future recommendedMovie() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Recommended Movies',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = Movie.getuserid(value);
//       return result;
//     });
//   }
//
//   Future movie() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Popular Movies',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = PopularMovie.getuserid(value);
//       return result;
//     });
//   }
//
//   Future recommededAlbum() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Recommended Album',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = RecommendedAlbum.getuserid(value);
//       return result;
//     });
//   }
//
//   Future recentPlayed() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Recently Played',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((value) {
//       var result = m.MostPlayed.getuserid(value);
//       return result;
//     });
//   }
//
//   Future playlistmusic(String id) async {
//     await post(BASEURL + 'getPlaylistMusic', body: {
//       'user_id': '1',
//       'user_playlist_id': id,
//     }, headers: {}).then((value) {
//       var result = m.MostPlayed.getuserid(value);
//       return result;
//     });
//   }
//
//   Future searchdata() async {
//     await post(BASEURL + 'search', body: {
//       "user_id": '1',
//     }, headers: {}).then((dynamic res) async {
//       var results = Searches.getuserid(res);
//       return results;
//     });
//   }
//
//   static late m.MostPlayedItem musicItem;
//   Future getsingelMusic(String userid, String musicid) async {
//     await post(BASEURL + 'playMusic', body: {
//       "user_id": userid,
//       "music_id": musicid,
//     }, headers: {}).then((dynamic res) async {
//       musicItem = m.MostPlayedItem.fromJson(res);
//       return musicItem;
//     });
//   }
//
//   static int download = 0;
//
//   downloads() async {
//     await post(BASEURL + 'isAllowDownloads',
//         body: {"user_id": '1'}, headers: {}).then((dynamic res) async {
//       download = Downloads.fromJson(res).isallowdownloads;
//       return download;
//     });
//   }
//
//   Future getpackage() async {
//     await post(BASEURL + 'getPackages', body: {}, headers: {})
//         .then((dynamic res) async {
//       var list = Packages.getuserid(res);
//
//       return list;
//     });
//   }
//
//   Future deleteMusic(String id) async {
//     await post(BASEURL + 'removeFromPlaylist',
//         body: {'user_id': '1', 'music_id': id}, headers: {});
//   }
//
//   Future getAlbum() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Popular Albums',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((dynamic res) async {
//       var result = PopularAlbum.getuserid(res);
//       return result;
//     });
//   }
//
//   Future getPlaylist() async {
//     await post(BASEURL + 'getPlaylists', body: {
//       'user_id': '1',
//     }, headers: {}).then((value) {
//       return Playlist.getuserid(value);
//     });
//   }
//
//   Future getFavArtist() async {
//     await post(BASEURL + 'home', body: {
//       'home_components_name': 'Favourite Artists',
//       'user_id': '1',
//       'is_myProfile': '1',
//     }, headers: {}).then((dynamic res) async {
//       var result = FavouriteArtist.getuserid(res);
//       return result;
//     });
//   }
//
//   Future getAllMovies() async {
//     await post(BASEURL + 'getAllMovies', body: {
//       'user_id': '1',
//     }, headers: {}).then((value) {
//       return PopularMovie.getuserid(value);
//     });
//   }
//
//   Future getAllArtist() async {
//     await post(BASEURL + 'getAllArtists', body: {
//       'user_id': '1',
//     }, headers: {}).then((value) {
//       return AllArtist.getuserid(value);
//     });
//   }
//
//   Future like(String id, String liketype, String liketypeId) async {
//     await post(BASEURL + 'like', body: {
//       'user_id': id,
//       'like_type': liketype,
//       'like_type_id': liketypeId,
//     }, headers: {});
//   }
//
//   Future unlike(String id, String liketype, String liketypeId) async {
//     await post(BASEURL + 'unlike', body: {
//       'user_id': id,
//       'like_type': liketype,
//       'like_type_id': liketypeId,
//     }, headers: {});
//   }
//
//   static late MovieAlbumModel model;
//   static late ViewMovie movies;
//   static late ViewArtistItem item;
//   Future getViewAlbum(String id) async {
//     await post(BASEURL + 'viewAlbum', body: {
//       'user_id': '1',
//       'album_id': id,
//     }, headers: {}).then((value) {
//       model = MovieAlbumModel.fromJson(value);
//       return model;
//     });
//   }
//
//   Future viewMovie(String id) async {
//     await post(BASEURL + 'viewMovie', body: {
//       'user_id': '1',
//       'movie_id': id,
//     }, headers: {}).then((value) {
//       return movies = ViewMovie.fromJson(value);
//     });
//   }
//
//   Future getAllAlbum() async {
//     await post(BASEURL + 'getAllAlbums', body: {
//       'user_id': '1',
//     }, headers: {}).then((value) {
//       return PopularAlbum.getuserid(value);
//     });
//   }
//
//   Future viewArtist(String id) async {
//     await post(BASEURL + 'viewArtist', body: {
//       'user_id': '1',
//       'artist_id': id,
//     }, headers: {}).then((value) {
//       return item = ViewArtistItem.fromJson(value);
//     });
//   }
}
