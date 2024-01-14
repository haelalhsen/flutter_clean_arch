import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GeneralButton extends StatelessWidget {
  Color? color;
  Color? borderColor;
  Color? textColor;
  String? text;
  Function? onTap;
  double? width;
  double? height;

  GeneralButton(
      {Key? key,
      this.color,
      this.borderColor,
      this.textColor,
      this.text,
      this.width,
      this.height,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(width: 2, color: borderColor!),
        ),
        child: Text(
          text!,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class GeneralButtonRounded extends StatelessWidget {
  Color? color;
  Color? borderColor;
  Color? textColor;
  String? text;
  Function? onTap;
  double? width;
  double? height;
  String? icon;

  GeneralButtonRounded(
      {Key? key,
      this.color,
      this.borderColor,
      this.textColor,
      this.text,
      this.width,
      this.height,
      this.icon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(width: 2, color: borderColor!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Image.asset(
                    icon!,
                    width: 3.5.w,
                  )
                : const SizedBox(),
            const SizedBox(
              width: 8,
            ),
            Text(
              text!,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .merge(TextStyle(color: textColor)),
            ),
          ],
        ),
      ),
    );
  }
}
