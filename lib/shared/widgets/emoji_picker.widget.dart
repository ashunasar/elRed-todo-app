import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmojiPicker extends StatelessWidget {
  const EmojiPicker({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
        color: Colors.white,
      ),
      height: height * 0.8,
      child: Column(
        children: [
          Container(
              height: 5.h,
              width: 30.w,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.r))),
          SizedBox(height: 10.h),
          const Text('Pick an emoji accourding to your task\'s mood.'),
          SizedBox(height: 10.h),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              children: AnimatedEmojis.values
                  .map((e) => InkWell(
                      onTap: () => Navigator.pop<AnimatedEmojiData>(context, e),
                      child: AnimatedEmoji(e)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
