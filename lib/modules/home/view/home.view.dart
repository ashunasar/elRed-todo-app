import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modules/auth/view/auth.view.dart';
import 'package:todoapp/modules/home/provider/home.provider.dart';
import 'package:todoapp/modules/task/view/add_task.view.dart';
import 'package:todoapp/services/auth/google_signin.service.dart';
import 'package:todoapp/shared/colors/app_colors.dart';
import 'package:todoapp/core/extensions/date_time.extension.dart';
import 'package:todoapp/core/extensions/string_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../../core/utils/util_functions.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getTasks();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final currentUser = FirebaseAuth.instance.currentUser;

  void logOut() async {
    bool isSuccess = await GoogleSigninService().signOut();
    if (isSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthView()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            drawer: getDrawer(),
            floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTaskView())),
                child: Icon(Icons.add_rounded, size: 40.h)),
            body: Column(
              children: [
                Container(
                  height: 199.h,
                  width: 360.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:
                              AssetImage(Assets.images.morningMountain.path))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: Assets.icons.hamburgerIcon.svg())),
                        Text(
                            'Your tasks\n${UtilFunctions.getFirstName(currentUser!.displayName!)}',
                            style: theme.textTheme.displaySmall),
                        Text(
                          DateTime.now().format(),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 15.h),
                        const Text('Task in progress'),
                        SizedBox(height: 24.h),
                        getTasksList()
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  SingleChildScrollView getTasksList() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Consumer<HomeProvider>(builder: (context, value, child) {
        return value.tasks == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: value.tasks!
                    .map((e) => Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  value.editTask(context, e);
                                },
                                backgroundColor: AppColors.darkBlue,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  value.removeTask(e);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 30.r,
                                backgroundColor: AppColors.lightGrey,
                                child: AnimatedEmoji(
                                  AnimatedEmojiData(e.emojiDataId),
                                  size: 30.h,
                                )),
                            title: Text(e.title,
                                style: theme.textTheme.titleMedium),
                            subtitle: Text(
                                '${e.description.truncateText(35)}\n ${e.date.format()}',
                                style: theme.textTheme.bodySmall!
                                    .copyWith(color: AppColors.grey)),
                            trailing: InkWell(
                                onTap: () {
                                  value.showTaskDialog(context, e);
                                },
                                child:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          ),
                        ))
                    .toList());
      }),
    );
  }

  Drawer getDrawer() {
    final theme = Theme.of(context);
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: AppColors.darkBlue),
            child: Column(children: [
              CircleAvatar(
                  radius: 40.r,
                  backgroundImage:
                      CachedNetworkImageProvider(currentUser!.photoURL!)),
              SizedBox(height: 10.h),
              Text(
                  'Hey, ${UtilFunctions.getFirstName(currentUser!.displayName!)}',
                  style: theme.textTheme.bodySmall)
            ])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListTile(
            onTap: logOut,
            leading: const Icon(Icons.logout_rounded),
            title: Text('Logout', style: theme.textTheme.bodyMedium),
          ),
        )
      ],
    ));
  }
}
