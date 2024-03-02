import 'package:flutter/material.dart';
import 'package:demo_provider/data/models/task_model.dart';

class AddTaskProvider extends ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController placeController;
  DateTime? selectedDateTime;
  Color? selectedColor;
  late List<bool> isSelected;
  int selectedLevelIndex = 0;
  Task? task;

  AddTaskProvider(Task? task) {
    nameController = TextEditingController(text: task?.name);
    placeController = TextEditingController(text: task?.place);
    selectedDateTime = task?.time;
    selectedColor = task?.color;
    isSelected = List<bool>.generate(3, (index) => index == (task?.le?.index ?? 0));
   
  }

  void setColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  void setDateTime(DateTime dateTime) {
    selectedDateTime = dateTime;
    notifyListeners();
  }

  void setSelectedLevel(int index) {
    selectedLevelIndex = index;
    isSelected = List<bool>.generate(3, (idx) => idx == index);
    notifyListeners();
  }


  @override
  void dispose() {
    nameController.dispose();
    placeController.dispose();
    super.dispose();
  }
}
