class News {
  final String image;
  final String date;
  final String title;
  final String desc;
  News(
      {required this.image,
      required this.title,
      required this.date,
      required this.desc});

  factory News.fromJson(Map<String, dynamic> json) => News(
      // ignore: prefer_interpolation_to_compose_strings
      // image: json["IMAGE"],
      image: 'https://news.usindh.edu.pk/${json['IMAGE_PATH']}',
      title: json["TITLE"],
      date: json["PUBLICATION_DATE"],
      desc: json["DESCRIPTION"]);
}
