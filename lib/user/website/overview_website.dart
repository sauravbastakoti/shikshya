// import 'package:flutter/material.dart';
// import 'package:sikshya/user/get_enrolled.dart';

// class OverviewWebsite extends StatefulWidget {
//   const OverviewWebsite({super.key});

//   @override
//   State<OverviewWebsite> createState() => _OverviewWebsiteState();
// }

// class _OverviewWebsiteState extends State<OverviewWebsite> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Website Design",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("by Syed Hasnain"),
//                 Text(
//                   r"72 $",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//                 "Web designing is the process of planning, conceptualizing, and implementing the plan for designing a website in a way that is functional and offers a good user experience. User experience is central to the web designing process. Websites have an array of elements presented in ways that make them easy to navigate"),
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//               height: 80,
//               width: double.infinity,
//               decoration: const BoxDecoration(color: Colors.grey),
//               child: const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.book),
//                           SizedBox(width: 5),
//                           Text("80+ Lectures"),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.read_more),
//                           SizedBox(width: 5),
//                           Text("Certificate"),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.access_time),
//                           SizedBox(width: 5),
//                           Text("10 Hours"),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.language),
//                           SizedBox(width: 5),
//                           Text("English"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 80,
//             ),
//             SizedBox(
//               height: 50,
//               width: 400,
//               child: MaterialButton(
//                   color: Colors.lightBlue,
//                   onPressed: () {
//                     showModalBottomSheet(
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (context) => const GetEnrolled());
//                   },
//                   child: const Text(
//                     "Get Enrolled",
//                     style: TextStyle(fontSize: 20),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
