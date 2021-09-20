class Thumbnail {
  String path;
  String ext;

  Thumbnail({this.path, this.ext});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    ext = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.path + '.${this.ext}';
    return data;
  }
}