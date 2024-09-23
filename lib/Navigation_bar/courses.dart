// import 'package:flutter/material.dart';
// import 'package:sikshya/graphics_design/graphics_design_screen.dart';
// import 'package:sikshya/videoediting/videoediting.dart';
// import 'package:sikshya/website/website_design.dart';
// import 'package:sikshya/wireframing/wireframing_screen.dart';

// // class Course {
// //   final String imageurl;
// //   final String title;
// //   final String instructor;
// //   final double progress;

// //   Course(this.imageurl, this.title, this.instructor, this.progress);
// // }

// class CoursesNav extends StatefulWidget {
//   const CoursesNav({super.key});

//   @override
//   State<CoursesNav> createState() => _CoursesNavState();
// }

// class _CoursesNavState extends State<CoursesNav> {
//   // final List<Course> courses = [
//     // Course(
//     //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8FVkfCVQk_eEH19SjtNRXzWpWpHquroB3zA&s",
//     //     'Graphics Design',
//     //     'By Syed Hasnain',
//     //     0.35),
//     // Course("https://picsum.photos/250?image=238", 'Wire Framing',
//     //     'By Arpit Wason', 0.55),
//     // Course(
//     //     "https://bubble.io/blog/content/images/size/w600/2023/07/business-website-design.png",
//     //     'Website Design',
//     //     'By Asim Yaseen',
//     //     0.35),
//     // Course("https://picsum.photos/250?image=239", 'Video Editing',
//     //     'By Umer Saeed', 0.75),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text("My Courses"),
//         backgroundColor: Colors.lightBlue,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16.0),
//         itemCount: courses.length,
//         itemBuilder: (context, index) {
//           final course = courses[index];
//           return GestureDetector(
//             onTap: () {
//               switch (course.title) {
//                 case 'Graphics Design':
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => GraphicsDesignScreen(),
//                     ),
//                   );
//                   break;
//                 case "Wire Framing":
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => WireframingScreen(),
//                     ),
//                   );
//                   break;
//                 case "Website Design":
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => WebsiteScreen(),
//                     ),
//                   );
//                   break;
//                 case "Video Editing":
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Videoediting(),
//                     ),
//                   );
//               }
//             },
//             child: Card(
//               elevation: 3,
//               margin: EdgeInsets.only(bottom: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                             width: 50,
//                             height: 50,
//                             child: Image.network(course.imageurl)),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 course.title,
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 course.instructor,
//                                 style: TextStyle(color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     LinearProgressIndicator(
//                       value: course.progress,
//                       backgroundColor: Colors.grey[300],
//                       valueColor:
//                           AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       '${(course.progress * 100).toInt()}% Done',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:sikshya/models/post.dart';
import 'package:sikshya/my_course.dart';
import 'package:sikshya/service/dashboard_services.dart';
import 'package:sikshya/website/website_design.dart';

class CoursesNav extends StatefulWidget {
  const CoursesNav({super.key});

  @override
  State<CoursesNav> createState() => _CoursesNavState();
}

class _CoursesNavState extends State<CoursesNav> {
  List<Courses>? posts;
  var isloaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteServices().getPost();
    if (posts != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Courses",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyCourse()));
                },
                child: Container(
                  height: 30,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.school),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "My Courses",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Visibility(
          visible: isloaded,
          child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WebsiteScreen(post: posts![index]),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.network(posts![index].imageUrl),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  posts![index].title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
