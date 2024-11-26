class VideoModel {
  final String link;
  VideoModel({required this.link});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(link: json['LINK']);
  }
}
