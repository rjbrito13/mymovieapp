class Movie {
  final String title;
  final String imagePath;
  final String subtitle;
  final String category;
  final int releaseDate;
  final String screentime;
  final String director;
  final List<String> casts;
  final String videoid;

  Movie({
    required this.title,
    required this.imagePath,
    required this.subtitle,
    required this.category,
    required this.releaseDate,
    required this.screentime,
    required this.director,
    required this.casts,
    required this.videoid,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      imagePath: json['imagePath'],
      subtitle: json['subtitle'],
      category: json['category'],
      releaseDate: json['releasedate'],
      screentime: json['screentime'],
      director: json['director'],
      casts: List<String>.from(json['casts']),
      videoid: json['videoid'],
    );
  }
}