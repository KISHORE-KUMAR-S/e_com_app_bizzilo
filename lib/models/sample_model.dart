class SampleModel {
  List<Sections>? sections;

  SampleModel({this.sections});

  SampleModel.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? type;
  List<Data>? data;
  String? title;

  Sections({this.type, this.data, this.title});

  Sections.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Data {
  String? imageUrl;
  String? videoUrl;
  String? thumbnail;
  String? name;
  String? image;
  String? title;
  double? price;
  String? discount;

  Data({
    this.imageUrl,
    this.videoUrl,
    this.thumbnail,
    this.name,
    this.image,
    this.title,
    this.price,
    this.discount,
  });

  Data.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    thumbnail = json['thumbnail'];
    name = json['name'];
    image = json['image'];
    title = json['title'];
    price = json['price'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_url'] = imageUrl;
    data['video_url'] = videoUrl;
    data['thumbnail'] = thumbnail;
    data['name'] = name;
    data['image'] = image;
    data['title'] = title;
    data['price'] = price;
    data['discount'] = discount;
    return data;
  }
}
