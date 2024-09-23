import 'package:flutter/material.dart';
import 'package:sikshya/graphics_design/lesson_graphics.dart';
import 'package:sikshya/graphics_design/overview.dart';
import 'package:sikshya/graphics_design/review_graphics.dart';

class GraphicsDesignScreen extends StatefulWidget {
  const GraphicsDesignScreen({super.key});

  @override
  State<GraphicsDesignScreen> createState() => _GraphicsDesignScreenState();
}

class _GraphicsDesignScreenState extends State<GraphicsDesignScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Graphics Design"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              "https://static.vecteezy.com/system/resources/previews/046/457/683/non_2x/a-close-up-shot-of-a-confused-cat-looking-at-a-screen-displaying-abstract-ai-generated-art-photo.jpg",
              fit: BoxFit.cover,
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Overview"),
              Tab(text: "Lesson"),
              Tab(text: "Reviews"),
            ],
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                OverviewGraphics(),
                LessonGraphics(),
                ReviewGraphics()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
