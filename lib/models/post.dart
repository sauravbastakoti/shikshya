// // import 'dart:convert';

// // List<Post> postFromJson(String str) =>
// //     List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// // String postToJson(List<Post> data) =>
// //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// // class Post {
// //   int userId;
// //   int id;
// //   String title;
// //   String body;

// //   Post({
// //     required this.userId,
// //     required this.id,
// //     required this.title,
// //     required this.body,
// //   });

// //   factory Post.fromJson(Map<String, dynamic> json) => Post(
// //         userId: json["userId"],
// //         id: json["id"],
// //         title: json["title"],
// //         body: json["body"],
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "userId": userId,
// //         "id": id,
// //         "title": title,
// //         "body": body,
// //       };
// // }

// import 'dart:convert';

// List<Post> postFromJson(String str) =>
//     List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

// String postToJson(List<Post> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Post {
//   int albumId;
//   int id;
//   String title;
//   String url;
//   String thumbnailUrl;

//   Post({
//     required this.albumId,
//     required this.id,
//     required this.title,
//     required this.url,
//     required this.thumbnailUrl,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         albumId: json["albumId"],
//         id: json["id"],
//         title: json["title"],
//         url: json["url"],
//         thumbnailUrl: json["thumbnailUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "albumId": albumId,
//         "id": id,
//         "title": title,
//         "url": url,
//         "thumbnailUrl": thumbnailUrl,
//       };
// }

import 'dart:convert';

List<Courses> coursesFromJson(String str) =>
    List<Courses>.from(json.decode(str).map((x) => Courses.fromJson(x)));

String coursesToJson(List<Courses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Courses {
  int id;
  String title;
  String description;
  String videoUrl;
  String imageUrl;

  Courses({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.imageUrl,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        videoUrl: json["videoUrl"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "videoUrl": videoUrl,
        "imageUrl": imageUrl,
      };
}
