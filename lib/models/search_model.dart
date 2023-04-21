class Searches {
  late String status;
  late String message;
  late String response;

  static late List<SearchesItem> searchlist;

  Searches.getuserid(dynamic obj) {
    searchlist = obj
        .map<SearchesItem>((json) => new SearchesItem.fromJson(json))
        .toList();
  }
}

class SearchesItem {
  final String searchType;
  final String id;
  final String searchText;

  SearchesItem(
      {
        required this.searchText,
        required this.id,
        required this.searchType
      });

  factory SearchesItem.fromJson(Map<String, dynamic> jsonMap) {
    return SearchesItem(
        searchText: jsonMap['search_text'] ?? '',
        id: jsonMap['id'],
        searchType: jsonMap['search_type'] ?? '');
  }
}
