import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/general_validator.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final int? maxLines;
  final String? validationMessage;
  final bool? isNumber;
  final bool? isEnabled;
  final bool? validate;
  final bool? isEmail;

  CustomTextInput({
    Key? key,
    this.controller,
    this.maxLines,
    this.validationMessage,
    this.isNumber,
    this.hint,
    this.isEmail,
    this.isEnabled, this.validate,
  }) : super(key: key);

  String? textValidation(String input) {
   if(!validate!){
     return null;
   }else{
     if(isEmail != null){
       return validator.email(input)
           ? null
           :validationMessage;
     }
     if(input.isEmpty){
       return validationMessage;
     }else{
       return null;
     }
   }
  }

  OutlineInputBorder outlineInputBorder=OutlineInputBorder(
    borderSide: const BorderSide(
        color: Colors.grey, width: 2),
    borderRadius: BorderRadius.circular(2),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: isEnabled,
        controller: controller,
        keyboardType: isNumber == null ? null : TextInputType.number,
        textInputAction: maxLines! > 1 ? TextInputAction.newline : null,
        maxLines: maxLines,
        validator: (input) => textValidation(input!),
        decoration: InputDecoration(
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder:outlineInputBorder,
          disabledBorder: outlineInputBorder,
          // hintStyle: Theme.of(context).textTheme.labelMedium,
          hintText: hint!,
        ),
        // style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
// class PasswordTextInput extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? hint;
//   final Function? passToggle;
//   final String? validationMessage;
//   final bool? isVisible;
//
//   PasswordTextInput({
//     Key? key,
//     this.controller,
//     this.validationMessage,
//     this.hint,
//     this.passToggle,
//     this.isVisible,
//   }) : super(key: key);
//
//   String? textValidation(String input) {
//     if(input.length <8){
//       return validationMessage!.tr;
//     }else{
//       return null;
//     }
//   }
//
//   OutlineInputBorder outlineInputBorder=OutlineInputBorder(
//     borderSide: BorderSide(
//         color: AppColors.mainColor(1), width: 2),
//     borderRadius: BorderRadius.circular(2),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//         controller: controller,
//         validator: (input) => textValidation(input!),
//         obscureText:!isVisible!,
//         decoration: InputDecoration(
//           suffixIcon: IconButton(
//             onPressed: (){
//               passToggle!();
//             },
//             icon: Icon(
//               !isVisible!
//                   ? Icons.visibility
//                   : Icons.visibility_off_rounded,
//               color: AppColors.mainColor(1),
//             ),
//           ),
//           border: outlineInputBorder,
//           focusedBorder: outlineInputBorder,
//           enabledBorder:outlineInputBorder,
//           disabledBorder: outlineInputBorder,
//           hintStyle: Theme.of(context).textTheme.labelMedium,
//           hintText: hint!.tr,
//         ),
//         style: Theme.of(context).textTheme.displayMedium);
//   }
// }
