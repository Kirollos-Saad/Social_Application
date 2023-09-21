class PostModel
{
  String? name;
  String? uId;
  String? image;
  DateTime? dateTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = DateTime.parse(json['dateTime']);
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}