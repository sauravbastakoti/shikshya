import 'package:flutter/material.dart';

class GetEnrolled extends StatefulWidget {
  const GetEnrolled({super.key});

  @override
  State<GetEnrolled> createState() => _GetEnrolledState();
}

class _GetEnrolledState extends State<GetEnrolled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Overview",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Course Name: Graphics Design",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 5),
                        Text("80+ Lectures"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.read_more),
                        SizedBox(width: 5),
                        Text("Certificate"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 5),
                        Text("10 Hours"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.language),
                        SizedBox(width: 5),
                        Text("English"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Course Time: 8 weeks",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Course Trainner: Syed Hasnain",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Purchase Detail",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Divider(
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Date : 19/03/2024"), Text(r"Price : 72$")],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Coupon : 10% Off"), Text(r"Final Price : 65$")],
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 50,
            width: 400,
            child: MaterialButton(
                color: Colors.blue[700],
                onPressed: () {},
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
          )
        ]),
      ),
    );
  }
}
