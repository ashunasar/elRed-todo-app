import 'package:fluttertoast/fluttertoast.dart';

class UtilFunctions {
  //* showToast function to display a toast message in app
  static void showToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

//* getFirstName function to split string by ' ' and returns the first value from list
  static String getFirstName(String fullName) {
    return fullName.split(' ')[0];
  }
}
