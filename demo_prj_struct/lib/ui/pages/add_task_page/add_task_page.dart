import 'package:demo_provider/ui/pages/home_page/providers/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:demo_provider/data/models/task_model.dart';
import 'package:demo_provider/ui/pages/add_task_page/providers/add_task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTaskProvider(task),
      child: Consumer<AddTaskProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                task == null ? 'Add Task' : 'Edit Task',
                style: const TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: provider.nameController,
                    decoration: const InputDecoration(labelText: 'Task Name'),
                  ),
                  TextField(
                    controller: provider.placeController,
                    decoration: const InputDecoration(labelText: 'Place'),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Color ',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: provider.selectedColor,
                        radius: 16,
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens),
                        onPressed: () async {
                          Color? pickedColor = await showDialog<Color>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Pick a color'),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: Colors.blue,
                                  onColorChanged: provider.setColor,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(provider.selectedColor);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          if (pickedColor != null) {
                            provider.setColor(pickedColor);
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(
                      height: 10, thickness: 2, color: Color(0xffEAEAEA)),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Due Time ',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            provider.selectedDateTime == null
                                ? 'No Date and Time Selected'
                                : DateFormat('MM/dd/yyyy HH:mm')
                                    .format(provider.selectedDateTime!),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.calendar_month_outlined),
                        onPressed: () async {
                          DateTime? pickedDateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDateTime != null) {
                            TimeOfDay? pickedTime = await showTimePicker(
                              // ignore: use_build_context_synchronously
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              provider.setDateTime(DateTime(
                                pickedDateTime.year,
                                pickedDateTime.month,
                                pickedDateTime.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              ));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(
                      height: 20, thickness: 2, color: Color(0xffEAEAEA)),
                  const Text(
                    'Level ',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildToggleButton('Urgent', 0, provider),
                          _buildToggleButton('Basic', 1, provider),
                          _buildToggleButton('Important', 2, provider),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                          height: 20, thickness: 2, color: Color(0xffEAEAEA)),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (provider.nameController.text.isEmpty ||
                      provider.placeController.text.isEmpty ||
                      provider.selectedDateTime == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill in all fields.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Level selectedLevel;
                    switch (provider.selectedLevelIndex) {
                      case 0:
                        selectedLevel = Level.urgent;
                        break;
                      case 1:
                        selectedLevel = Level.basic;
                        break;
                      case 2:
                        selectedLevel = Level.important;
                        break;
                      default:
                        selectedLevel = Level.basic;
                    }
                    Task editedTask = Task(
                      name: provider.nameController.text,
                      place: provider.placeController.text,
                      id: task?.id,
                      time: provider.selectedDateTime,
                      le: selectedLevel,
                      color: provider.selectedColor,
                    );
                    if (task == null) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(editedTask);
                    } else {
                      Provider.of<TaskProvider>(context, listen: false)
                          .updateTask(editedTask);
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29),
                  ),
                  minimumSize: const Size(346, 49),
                ),
                child: Text(task == null ? 'Add Task' : 'Save Task'),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggleButton(String text, int index, AddTaskProvider provider) {
    bool isSelected = provider.isSelected[index];
    return GestureDetector(
      onTap: () {
        provider.setSelectedLevel(index);
      },
      child: Center(
        child: Container(
          height: 38,
          width: 105,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
