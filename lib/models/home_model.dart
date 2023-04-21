class AllComponents {
  late String status;
  late String message;
  late String response;

  static late List<AllComponentsItem> list;

  AllComponents.getuserid(dynamic obj) {
    list = obj
        .map<AllComponentsItem>((json) => new AllComponentsItem.fromJson(json))
        .toList();
  }
}

class AllComponentsItem {
  final String homeComponentsId;
  final String homeComponentsName;
  final String homeComponentsOrder;
  final String homeComponentsSliderAllowed;

  AllComponentsItem(
      {required this.homeComponentsId,
        required this.homeComponentsName,
        required this.homeComponentsOrder,
        required this.homeComponentsSliderAllowed
      });

  factory AllComponentsItem.fromJson(Map<String, dynamic> jsonMap) {
    return AllComponentsItem(
      homeComponentsId: jsonMap['home_components_id'] ?? '',
      homeComponentsName: jsonMap['home_components_name'] ?? '',
      homeComponentsOrder: jsonMap['home_components_order'] ?? '',
      homeComponentsSliderAllowed: jsonMap['home_components_slider_allowed'] ?? '',
    );
  }
}
