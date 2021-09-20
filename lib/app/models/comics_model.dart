import 'package:desafio_marvel/app/models/thumb_model.dart';

class Comics {
  String id;
  String title;
  String description;
  Thumbnail thumbnail;
  int pageCount;

  Comics(
      {this.id, this.title, this.description, this.thumbnail, this.pageCount});

  Comics.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    description = json['description'];
    pageCount = json['pageCount'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['title'] = this.title;
    data['pageCount'] = this.pageCount;
    data['description'] = this.description;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }

    return data;
  }
}
