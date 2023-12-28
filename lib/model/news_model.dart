class News {
  String? link, title, pubDate, description, thumbnail;

  News({this.link, this.title, this.pubDate, this.description, this.thumbnail});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      link: json['link'],
      title: json['title'],
      pubDate: json['pubDate'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }
}
