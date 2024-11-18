import 'package:appverse/data/models/task_model.dart';
import 'package:appverse/domain/entities/task.dart';
import 'package:appverse/domain/mappers/task_mapper.dart';
import 'package:appverse/presentation/widgets/pages/task_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseTab extends StatefulWidget {
  const FirebaseTab({super.key});

  @override
  State<FirebaseTab> createState() => _FirebaseTabState();
}

class _FirebaseTabState extends State<FirebaseTab> {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('tasks');
  late final Stream<DatabaseEvent> _dbStream;

  @override
  void initState() {
    super.initState();
    _dbStream = _dbRef.onValue;
  }

  @override
  void dispose() {
    super.dispose();
    _dbRef.onValue.drain();
  }

  Future<void> deleteTask(String index) async {
    try {
      DatabaseReference userRef = _dbRef.child(index);

      await userRef.update({
        'status': 'deleted',
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error updating status: $e');
      }
    }
  }

  /// To convert database json into readable to converting
  Map<String, dynamic> convertMap(Map<Object?, Object?> inputMap) {
    return inputMap.map((key, value) {
      // Ensure the key is a String
      String stringKey = key.toString();

      // If the value is a map, recursively convert it
      dynamic convertedValue = value;
      if (value is Map<Object?, Object?>) {
        convertedValue = convertMap(value); // Recursively convert nested map
      }

      // Return MapEntry with String key and dynamic value
      return MapEntry(stringKey, convertedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: _dbStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Center(
            child: Text('No data available.'),
          );
        }

        Map<dynamic, dynamic> dbTasks =
            snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

        final dbTasksValues = dbTasks
            .map((key, value) => MapEntry(key.toString(), value))
            .values
            .toList();

        List<Task> tasks = [];

        for (var el in dbTasksValues) {
          Map<String, dynamic> convertedMap = convertMap(el);
          tasks.add(TaskModel.fromJson(convertedMap).toEntity);
        }

        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              if (tasks[index].status == Status.deleted) {
                return const SizedBox.shrink();
              }
              return TaskItem(
                tasks: tasks,
                index: index,
                onDelete: () => deleteTask(dbTasks.keys.toList()[index]),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          ),
        );
      },
    );
  }
}
