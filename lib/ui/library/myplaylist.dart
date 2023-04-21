import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/playlist_model.dart';
import '../../services/api_services.dart';
import 'package:http/http.dart' as http;

class MyPlayListUi extends StatefulWidget {
  const MyPlayListUi({Key? key}) : super(key: key);

  @override
  State<MyPlayListUi> createState() => _MyPlayListUiState();
}

class _MyPlayListUiState extends State<MyPlayListUi> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late NetworkUtils networkUtils;
  List<dynamic> _playlists = [];
  List<dynamic> _playlistIds=[];
  static const apiUrl= 'https://0dab-196-170-127-70.ngrok-free.app/api/';

  Future<void> _getPlaylists() async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}getplaylists'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _playlists = data;
          _playlistIds = _playlists.map((playlist) => playlist['id']).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching playlists: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to fetch playlists'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<Playlist> createPlaylist(String name) async {
    final response = await http.post(
      Uri.parse('${apiUrl}createplaylists'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );

    if (response.statusCode == 201) {
      return Playlist.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create playlist.');
    }
  }

  Future<void> _deletePlaylist(int id) async {
    final url = Uri.parse('${apiUrl}DeletePlaylist/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        _playlists.removeWhere((playlist) => playlist['id'] == id);
      });
    } else {
      // Handle error here
      print('Failed to delete playlist');
    }
  }

  @override
  void initState() {
    super.initState();
    _getPlaylists();
  }

  _showAddPlaylistDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Playlist'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Enter playlist name',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.pop(context);
              if (_formKey.currentState!.validate()) {
                final name = _nameController.text;
                await createPlaylist(name);
                navigator; // ferme le dialogue
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Playlist',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            onPressed: () {
              _showAddPlaylistDialog();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
      body: _playlists.isEmpty ? const Center(
        child: Text(
          'Your playlist is empty',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ) : ListView.builder(
        itemCount: _playlists.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(_playlists[index]['id']),
            onDismissed: (direction) {
              _deletePlaylist(_playlists[index]['id']);
              setState(() {
                _playlists.removeAt(index);
                _playlistIds.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Playlist deleted'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: InkWell(
              onTap: () {
                // Navigation vers la page de détails de la liste
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.music_note, color: Colors.white),
                      title: Text(
                        _playlists[index]['name'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      // subtitle: Text(
                      //   _playlists[index]['created_at'],
                      //   style: const TextStyle(color: Colors.grey),
                      // ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
