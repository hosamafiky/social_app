class PostModel {
  String? name;
  String? uId;
  String? text;
  String? postImage;
  String? image;
  String? dateTime;

  PostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.text,
    this.postImage,
    this.image,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    uId = json['uId'];
    postImage = json['postImage'];
    image = json['image'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'dateTime': dateTime,
      'postImage': postImage,
      'uId': uId,
      'image': image,
    };
  }
}
