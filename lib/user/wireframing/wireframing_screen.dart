import 'package:flutter/material.dart';
import 'package:sikshya/user/wireframing/overview.dart';

class WireframingScreen extends StatefulWidget {
  const WireframingScreen({super.key});

  @override
  State<WireframingScreen> createState() => _WireframingScreenState();
}

class _WireframingScreenState extends State<WireframingScreen>
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
        title: const Text("WireFraming"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              "https://static.vecteezy.com/system/resources/previews/046/457/683/non_2x/a-close-up-shot-of-a-confused-cat-looking-at-a-screen-displaying-abstract-ai-generated-art-photo.jpg",
              fit: BoxFit.cover,
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [
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
              children: const [
                OverviewWireframing(),
                Center(child: Text("Lesson Content")),
                Center(child: Text("Reviews Content")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
