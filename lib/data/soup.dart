import 'dart:convert';

class SoupDart
{
  String title;
  String image;

  SoupDart.fromJson(Map json)
  : title = json['title'],
    image = json['image'];
  Map toJson()
  {
    return {
      'title':title,
      'image':image,
    };
  }
}