import 'package:demo_provider/data/models/task_model.dart';
import 'package:demo_provider/ui/pages/add_task_page/add_task_page.dart';
import 'package:demo_provider/ui/pages/home_page/providers/home_page_provider.dart';
import 'package:demo_provider/ui/pages/home_page/task_list.dart';
import 'package:demo_provider/ui/pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Colors.black;

  final _tabs = [
    const Tab(text: 'Today'),
    const Tab(text: 'Upcoming'),
    const Tab(text: 'Finished'),
  ];
   @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Task Manager",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [
          Icon(
            Icons.notifications_outlined,
            color: Colors.black,
            size: 41,
          ),
          SizedBox(
            width: 10,
          )
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Image.asset('assets/gr.png'),
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Here's Update Today",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 TabBar(
                  controller: _tabController,
                  tabs: _tabs,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    color: _selectedColor,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                //Expanded(child: TaskListScreen(taskProvider.tasks)),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TaskListScreen(taskProvider.tasks),
                      Container(),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.5),
          ),
          heroTag: "bt1",
          onPressed: () async {
            Task? newTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskScreen(
                  task: null,
                ),
              ),
            );

            if (newTask != null) {
              // ignore: use_build_context_synchronously
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(newTask);
            }
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          icon: const Icon(
            Icons.add_box_rounded,
            size: 21,
          ),
          label: const Text(
            "Add Task",
            style: TextStyle(fontSize: 21),
          ),
        ),
      ),
    );
  }
}