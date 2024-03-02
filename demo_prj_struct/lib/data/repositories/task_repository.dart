import 'package:demo_provider/data/models/task_model.dart';

abstract class TodoRepository {
  Future<List<Task>> fetchTasks();

  Future<Task> addTask(Task task);

  Future<Task> updateTask(Task task);

  Future<void> removeTask(String id);

  Future<void> updateTasks(List<Task> tasks);

  Future<void> clearCompletedTasks();

  Future<void> clearAllTasks();
}

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<Task> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> clearAllTasks() {
    // TODO: implement clearAllTasks
    throw UnimplementedError();
  }

  @override
  Future<void> clearCompletedTasks() {
    // TODO: implement clearCompletedTasks
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> fetchTasks() {
    // TODO: implement fetchTasks
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask(String id) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTasks(List<Task> tasks) {
    // TODO: implement updateTasks
    throw UnimplementedError();
  }

}