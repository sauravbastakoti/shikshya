// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class Review {
//   final String imageurl;
//   final String name;
//   final String subtitle;
//   final String content;
//   final double rating;

//   Review({
//     required this.imageurl,
//     required this.name,
//     required this.subtitle,
//     required this.content,
//     required this.rating,
//   });
// }

// List<Review> reviews = [
//   Review(
//       imageurl:
//           "https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/3.jpg",
//       name: "Usman ",
//       subtitle: "Student",
//       content:
//           "A book review is a critical evaluation of a book, where the reviewer discusses its content, themes, and overall impact. It typically includes a summary of the book's main points, the reviewer's analysis and opinions, and a recommendation for potential readers.",
//       rating: 4.5),
//   Review(
//       imageurl:
//           "https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/3.jpg",
//       name: "Usman ",
//       subtitle: "Student",
//       content:
//           "A book review is a critical evaluation of a book, where the reviewer discusses its content, themes, and overall impact. It typically includes a summary of the book's main points, the reviewer's analysis and opinions, and a recommendation for potential readers.",
//       rating: 3.5),
// ];

// class ReviewWebsite extends StatefulWidget {
//   const ReviewWebsite({super.key});

//   @override
//   State<ReviewWebsite> createState() => _ReviewWebsiteState();
// }

// class _ReviewWebsiteState extends State<ReviewWebsite> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: reviews.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   margin: const EdgeInsets.all(8.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage:
//                                 NetworkImage(reviews[index].imageurl),
//                           ),
//                           title: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(children: [
//                                 Text(reviews[index].name),
//                                 Text(reviews[index].subtitle),
//                               ]),
//                               Row(
//                                 children: [
//                                   RatingBarIndicator(
//                                     rating: reviews[index].rating,
//                                     itemBuilder: (context, index) => Icon(
//                                       Icons.star,
//                                       color: Colors.amber,
//                                     ),
//                                     itemCount: 5,
//                                     itemSize: 20.0,
//                                     direction: Axis.horizontal,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 8.0),
//                         Text(reviews[index].content),
//                         const SizedBox(height: 8.0),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
