import 'package:flutter/material.dart';

class Chapter {
  final String title;
  final String content;
  bool isExpanded;

  Chapter(
      {required this.title, required this.content, this.isExpanded = false});
}

class LessonGraphics extends StatefulWidget {
  const LessonGraphics({super.key});

  @override
  State<LessonGraphics> createState() => _LessonGraphicsState();
}

class _LessonGraphicsState extends State<LessonGraphics> {
  List<Chapter> _chapters = [
    Chapter(
      title: "Chapter 1",
      content: "What is Graphics Designing?",
    ),
    Chapter(
      title: "Chapter 2",
      content: "What is Logo Designing ",
    ),
    Chapter(
      title: "Chapter 3",
      content: "What is Poster Designing",
    ),
    Chapter(
      title: "Chapter 4",
      content: "What is Picture Editing",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _chapters[index].isExpanded = !_chapters[index].isExpanded;
                  for (int i = 0; i < _chapters.length; i++) {
                    if (i != index) {
                      _chapters[i].isExpanded = false;
                    }
                  }
                });
              },
              children: _chapters.map<ExpansionPanel>((Chapter chapter) {
                return ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(chapter.title),
                      );
                    },
                    body: ListTile(
                      title: Text(chapter.content),
                    ),
                    isExpanded: chapter.isExpanded);
              }).toList(),
            ),
            SizedBox(
              height: 200,
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
