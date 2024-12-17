import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:simple_ecpmmerce_api/model/shopmodel.dart';  

class ProductDetailController with ChangeNotifier {
  Ecommerceshopmodel? product;  
  bool isLoading = false;

 
  getProductDetail(int productId) async {
    isLoading = true;
    notifyListeners();
    
   
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts/$productId");
    
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        product = Ecommerceshopmodel.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to load product details.");
      }
    } catch (e) {
      print(e);
    }
    
    isLoading = false;
    notifyListeners();
  }
}
