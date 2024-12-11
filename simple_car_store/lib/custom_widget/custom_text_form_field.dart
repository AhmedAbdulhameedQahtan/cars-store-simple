import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_car_store/custom_widget/container_card.dart';
import 'package:simple_car_store/resources/color_manager.dart';

class CustomTextFormField extends StatefulWidget {

  final TextEditingController? textController;
  final TextInputType? textInputType;
  final Icon? prefixIcon;
  final String? hintText;
  bool? obscureText;

   CustomTextFormField({
    super.key,
     required this.textController,
     required this.textInputType,
     this.prefixIcon,
     this.hintText,
     this.obscureText,

    });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: widget.textController,
        obscureText: widget.obscureText != null ? widget.obscureText! : false,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          filled: true,
          hintText: widget.hintText,
          iconColor: ColorsManager.lightBlack,
          suffixIcon: widget.obscureText != null ? IconButton(
            onPressed: () {
              setState(() {
                widget.obscureText =! widget.obscureText!;
              });
            },
            icon: widget.obscureText! ? const Icon(Icons.visibility): const Icon(Icons.visibility_off) ,
          )
              : null ,

        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "${'error'.tr()} ${widget.hintText}" ;
          }
        },
      ),
    );
  }
}
