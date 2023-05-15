import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/task.model.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.cancel))),
            Text(task.title, style: theme.textTheme.titleMedium),
            SizedBox(height: 10.h),
            Text(task.description, style: theme.textTheme.titleMedium),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
