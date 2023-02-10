// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));


class CategoryModel {
    CategoryModel({
        required this.category,
    });

    List<Category> category;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    
}

class Category {
    Category({
        required this.name,
        required this.subcategory,
    });

    String name;
    List<String> subcategory;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
    );

   
}
