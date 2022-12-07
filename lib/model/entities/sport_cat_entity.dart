class SportCatEntity {
  SportCatEntity({
    String? id,
    String? url,
    int? width,
    int? height,
  }) {
    _id = id;
    _url = url;
    _width = width;
    _height = height;
  }

  SportCatEntity.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as String;
    _url = json['url'] as String;
    _width = json['width'] as int;
    _height = json['height'] as int;
  }

  String? _id;
  String? _url;
  int? _width;
  int? _height;

  String? get id => _id;

  String? get url => _url;

  int? get width => _width;

  int? get height => _height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    map['width'] = _width;
    map['height'] = _height;
    return map;
  }
}
