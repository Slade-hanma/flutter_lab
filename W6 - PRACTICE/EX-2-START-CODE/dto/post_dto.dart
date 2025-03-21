// lib/dto/post_dto.dart

class PostDTO {
  final int id;
  final String title;
  final String body; // Renamed from description to match the API

  PostDTO({required this.id, required this.title, required this.body});

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int, 'ID must be an integer');
    assert(json['title'] is String, 'Title must be a string');
    assert(json['body'] is String, 'Body must be a string');

    return PostDTO(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
