import 'package:appverse/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatelessWidget {
  final List<Task> tasks;
  final int index;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.tasks,
    required this.index,
    required this.onDelete,
  });

  String get taskStatus => tasks[index].status.value;

  showAlertDialog(BuildContext context, String status) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Статус задачи:"),
      content: Text(status),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAlertDialog(context, taskStatus),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(tasks[index].taskId),
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm:ss')
                        .format(tasks[index].createdAt),
                  ),
                  Text(tasks[index].status.value),
                ],
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_forever),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
