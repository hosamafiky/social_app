import 'package:flutter/material.dart';
import 'package:social_app/modules/login_module/login_screen.dart';
import 'package:social_app/shared/components/constants.dart';

import '../network/local/cache_helper.dart';
import '../style/my_flutter_app_icons.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.type,
    required this.validateFunc,
    required this.label,
    required this.prefix,
    this.isSecure = false,
    this.onSuffixPressed,
    this.onSubmit,
    this.suffix,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validateFunc, onSubmit;
  final Function? onSuffixPressed;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final bool isSecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: validateFunc,
        obscureText: isSecure,
        onFieldSubmitted: onSubmit,
        style: const TextStyle(
          color: Color(0xFF2D2D2D),
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: () {
                    onSuffixPressed!();
                  },
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.bgColor = kPrimaryColor,
  }) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.0,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.5),
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        child: Text(
          text!.toUpperCase(),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

customAppBar({
  required BuildContext context,
  String? text,
  bool? center,
  Widget? leading,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: leading ??
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              IconBroken.Arrow___Left_2,
            ),
          ),
      centerTitle: center,
      elevation: 1.0,
      titleSpacing: 0.0,
      title: text == null
          ? null
          : Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
      actions: actions,
    );

Widget divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20.0,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );
}

Widget customTextButton({
  String? text,
  VoidCallback? function,
  bool isUpper = false,
  double? size = 14.0,
  Color? textColor = kPrimaryColor,
}) =>
    TextButton(
      child: Text(
        isUpper ? text!.toUpperCase() : text!,
        style: TextStyle(
          color: textColor,
          fontSize: size,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: function,
    );

void navigateAndFinish(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

void navigateTo(context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void signOut(context) {
  CacheHelper.removeData(key: 'isLogged').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }

  return string[0].toUpperCase() + string.substring(1);
}

SnackBar buildSnackBar({required String message}) =>
    SnackBar(content: Text(message));
