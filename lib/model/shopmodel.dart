// To parse this JSON data, do
//
//     final ecommerceshopmodel = ecommerceshopmodelFromJson(jsonString);

import 'dart:convert';

List<Ecommerceshopmodel> ecommerceshopmodelFromJson(String str) => List<Ecommerceshopmodel>.from(json.decode(str).map((x) => Ecommerceshopmodel.fromJson(x)));

String ecommerceshopmodelToJson(List<Ecommerceshopmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ecommerceshopmodel {
    int? userId;
    int? id;
    String? title;
    String? body;

    Ecommerceshopmodel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory Ecommerceshopmodel.fromJson(Map<String, dynamic> json) => Ecommerceshopmodel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

  get price => null;

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
