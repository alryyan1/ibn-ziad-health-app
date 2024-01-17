import 'dart:convert';
import 'constants.dart';
import 'package:http/http.dart' as http;

class MainTest {
  int id;
  String name;
  int price;
  int? pack_id;
  int? container_id;
  bool loading = false;
  String translation;
  String terms;
  MainTest({
    required this.id,
    required this.container_id,
    required this.name,
    required this.pack_id,
    required this.price,
    required this.translation,
    required this.terms
  });

  factory MainTest.fromJson(Map<String, dynamic>? json) {
    var price = json!['price'] == false ? 0 : json['price'];
    if (price is String) {
      price = int.parse(price);
    }

    return MainTest(
      id: json['id'],
      container_id: json['container_id'],
      name: json['main_test_name'],
      pack_id: json['pack_id'],
      price: price,
      translation:  json['translation'],
      terms:  json['terms']
    );
  }

  static Future<List<MainTest>> getMainTests() async {
    Map<String, String> headers = {
      'Content-type': 'application/pdf',
      'Accept': 'application/pdf',
    };
    var url = Uri.parse("http://${host}${api}?&all_tests=1");
    var response = await http.get(url);
    var list = jsonDecode(response.body) as List<dynamic>;
    List<MainTest> mainTestList = list.map((e) {
      return MainTest.fromJson(e);
    }).toList();

    return mainTestList;
  }

  static Future<bool> changePrice(int test, int price) async {
    Map<String, String> headers = {
      'Content-type': 'application/pdf',
      'Accept': 'application/pdf',
    };
    var url =
        Uri.parse("http://${host}${api}?&change_price=1&id=$test&val=$price");
    var response = await http.get(url);
    var json = jsonDecode(response.body);

    return json['status'];
  }

  ///custom comparing function to check if two MainTests are equal
  bool isEqual(MainTest model) {
    return this.id == model.id;
  }

  @override
  String toString() => name;

  Map<String, Object?> toJson() {
    return {
      'id': this.id,
      'main_test_name': this.name,
      'price': this.price,
      'available': true,
      'translation': this.translation,
      'terms': this.terms,
    };
  }
}
