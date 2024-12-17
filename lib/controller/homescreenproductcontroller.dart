import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_ecpmmerce_api/model/shopmodel.dart'; 

class Homescreenproductcontroller with ChangeNotifier {
  List<Ecommerceshopmodel>? shopobj = [];


  getshop() async {
    notifyListeners(); 

    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts"); 
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List; 
        shopobj = data.map((json) => Ecommerceshopmodel.fromJson(json)).toList(); 
        notifyListeners(); 
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("");
    }
  }
}
