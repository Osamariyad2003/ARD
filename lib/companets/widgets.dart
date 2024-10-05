import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { error,success }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.success:
      color = Colors.green;
      break;
  }
  return color;
}


class ShowDialogError extends StatefulWidget {
  final String title;
  final String subTitle;
  final Function()? functionPressed ;
  const ShowDialogError({super.key, required this.title, required this.subTitle,  this.functionPressed,});

  @override
  State<ShowDialogError> createState() => _ShowDialogErrorState();
}

class _ShowDialogErrorState extends State<ShowDialogError> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(widget.title),
      content: Text(widget.subTitle),
      actions: <Widget>[
        TextButton(
            child:  Text('Okay'),
            onPressed:     () {
              if(  widget.functionPressed!=null){
                GoRouter.of(context).pop();
                widget.functionPressed!();

              }
              else {
                GoRouter.of(context).pop();
              }

            }
        ),
      ],
    );
  }
}




class MyFormField extends StatelessWidget {
  final double radius;
  final String? title;
  final bool? readOnly;
  final String hint;
  final int? maxLines;
  final TextStyle? hintStyle;
  final TextInputType type;
  final VoidCallback? suffixIconPressed;
  final IconData? suffixIcon;
  final Widget? widget;
  final TextEditingController? controller;
  final dynamic validation;
  final bool isPassword;
  final   Color? fill;

  const MyFormField(
      {super.key,
        this.isPassword = false,
        this.radius = 15,
        required this.type,
        required this.hint,
        required this.maxLines,
        this.suffixIcon,
        this.readOnly=false,
        this.suffixIconPressed,
        this.widget,
        this.controller,
        this.hintStyle,
        this.title="",
        this.validation,
        this.fill,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),

          ),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            readOnly: readOnly!,
            obscureText: isPassword,
            controller: controller,
            keyboardType: type,
            maxLines: maxLines,
            // Allow for dynamic expansion
            decoration: InputDecoration(
              filled: true,

              fillColor:fill ,
              helperStyle: TextStyle(color: textcolor),
              focusColor: Colors.white,
              hintText: hint,
              hintStyle: hintStyle,
              border:  OutlineInputBorder(
                borderRadius: BorderRadius?.circular(20),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15),


              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                onPressed: () {
                  suffixIconPressed!();
                },
                icon: Icon(
                  suffixIcon,
                  color: Colors.blue,
                ),
              )
                  : null,
            ),
            validator: validation,
          ),
        ),
      ],
    );
  }
}