import 'package:html/parser.dart' show parse;

class Item {
  final int id;
  final String title;
  final String? description;
  final String? imageId;

  Item({
    required this.id,
    required this.title,
    this.description,
    this.imageId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: _parseHtmlString(json['description'] ?? 'No description available'),
      imageId: json['image_id'],
    );
  }

  String? getImageUrl({int size = 843}) {
    return imageId != null
        ? 'https://www.artic.edu/iiif/2/$imageId/full/$size,/0/default.jpg'
        : null;
  }

  static String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;
    return parsedString;
  }
}