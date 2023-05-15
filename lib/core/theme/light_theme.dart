import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/shared/colors/app_colors.dart';
import '../../gen/fonts.gen.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.darkBlue,
      colorScheme: ColorScheme.light(
        secondary: AppColors.lightBlue,
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.blue),
          backgroundColor: AppColors.darkBlue,
          elevation: 0,
          titleTextStyle:
              const TextStyle(fontFamily: FontFamily.lexendRegular)),
      textTheme: const TextTheme(
          displaySmall: TextStyle(
              color: Colors.white,
              fontFamily: FontFamily.zillaSlabMediumItalic),
          bodySmall: TextStyle(
              color: Colors.white, fontFamily: FontFamily.lexendRegular),
          bodyMedium: TextStyle(fontFamily: FontFamily.lexendRegular),
          titleMedium: TextStyle(color: Colors.black)),
      listTileTheme: ListTileThemeData(
          iconColor: Colors.black,
          contentPadding: EdgeInsets.zero,
          textColor: AppColors.grey,
          shape: Border(bottom: BorderSide(color: AppColors.grey)),
          minVerticalPadding: 15),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            color: Colors.white,
            fontFamily: FontFamily.lexendRegular,
            fontSize: 12.sp),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff5D66AE)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff5D66AE)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 40)),
        backgroundColor: MaterialStateProperty.all(AppColors.lightBlue),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(color: Colors.white)),
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 40)),
              foregroundColor:
                  MaterialStateProperty.all(const Color(0xffFFFFFF)))),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(foregroundColor: Colors.white));
}
