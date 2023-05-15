import 'package:animated_emoji/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/shared/colors/app_colors.dart';
import 'package:todoapp/core/extensions/date_time.extension.dart';
import 'package:todoapp/shared/models/task.model.dart';
import 'package:todoapp/shared/widgets/custom_text_field.widget.dart';

import '../provider/task.provider.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key, this.task});
  final TaskModel? task;

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  late TaskProvider provider;

  @override
  void initState() {
    provider = Provider.of<TaskProvider>(context, listen: false);
    provider.initialize(widget.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(provider.isEdit ? 'Edit task' : 'Add new task')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70.h),
              getEmojiWidget(context),
              SizedBox(height: 30.h),
              CustomTextField(
                  controller: provider.titleController,
                  hintText: 'Enter task title'),
              CustomTextField(
                  controller: provider.descriptionController,
                  hintText: 'Enter task description'),
              SizedBox(height: 15.w),
              getDateWidget(context),
              SizedBox(height: 15.w),
              ElevatedButton(
                  onPressed: () {
                    provider.addNewTask(context);
                  },
                  child:
                      Text(provider.isEdit ? 'Update Task' : 'ADD YOUR TASK'))
            ],
          ),
        ),
      ),
    );
  }

  Consumer<TaskProvider> getEmojiWidget(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, value, child) {
      return InkWell(
        onTap: () {
          value.pickTaskEmojiMood(context);
        },
        child: Container(
          height: 80.h,
          width: 80.w,
          padding: EdgeInsets.all(5.h),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightBlue, width: 2)),
          child: value.selectedTaskEmojiMood != null
              ? AnimatedEmoji(value.selectedTaskEmojiMood!)
              : Icon(Icons.add_rounded, color: AppColors.lightBlue, size: 50.h),
        ),
      );
    });
  }

  Widget getDateWidget(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TaskProvider>(builder: (context, value, child) {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
            child: Row(children: [
              Text(value.pickedDate.format()),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  value.selectDate(context);
                },
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(3.r)),
                  child: Icon(Icons.calendar_month_outlined,
                      size: 20.w, color: Colors.white),
                ),
              )
            ]),
          )
        ],
      );
    });
  }
}
