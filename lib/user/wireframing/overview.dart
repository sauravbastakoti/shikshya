import 'package:flutter/material.dart';

class OverviewWireframing extends StatefulWidget {
  const OverviewWireframing({super.key});

  @override
  State<OverviewWireframing> createState() => _OverviewWireframingState();
}

class _OverviewWireframingState extends State<OverviewWireframing> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Graphics Design",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("by Syed Hasnain"),
                Text(
                  r"72 $",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Graphic design is a craft where professionals create visual content to communicate messages. By applying visual hierarchy and page layout techniques, designers use typography and pictures to meet users’ specific needs and focus on the logic of displaying elements in interactive designs to optimize the user experience."),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey),
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
              height: 100,
            ),
            SizedBox(
              height: 50,
              width: 400,
              child: MaterialButton(
                  color: Colors.lightBlue,
                  onPressed: () {},
                  child: Text(
                    "Get Enrolled",
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
