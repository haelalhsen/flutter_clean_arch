import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GeneralHelper {
  BuildContext? context;
  DateTime? currentBackPressTime;

  GeneralHelper.of(BuildContext _context) {
    context = _context;
  }

  showErrorMessage(String message) {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          duration: const Duration(seconds: 3),
        ).show(context!);
      }
    });
    return const SizedBox.shrink();
  }


  showInfoMessage(String message) {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createInformation(
          message: message,
          duration: const Duration(seconds: 3),
        ).show(context!);
      }
    });
    return SizedBox.shrink();
  }

  showSuccessMessage(String message) {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          duration: const Duration(seconds: 3),
        ).show(context!);
      }
    });

    return const SizedBox.shrink();
  }

  Future<void> showLoadingDialog() async {
    return showDialog<void>(
      context: context!,
      builder: (BuildContext ctx) => SpinKitFadingCircle(
        color: Colors.white,
        size: 20.w,
      ),
      barrierDismissible: false,
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'tap_again_to_leave');
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
