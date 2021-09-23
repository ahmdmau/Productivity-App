import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';

class CustomButton {
  static Widget primaryButton({
    @required VoidCallback? onClick,
    String? text,
    Color? textColor,
    Color? backgroundColor,
    double? borderRadius,
    double? height,
    double? fontSize,
    Color? borderSideColor,
    Widget? leadingIcon,
    Widget? trailingIcon,
  }) {
    return Container(
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
              side: BorderSide(color: borderSideColor ?? kPrimaryColor),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? kPrimaryColor,
          ),
          elevation: MaterialStateProperty.all(0.0),
          textStyle: MaterialStateProperty.all<TextStyle>(
            GoogleFonts.montserrat(
              color: textColor ?? kPrimaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onPressed: () => onClick?.call(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leadingIcon == null
                ? SizedBox(
                    width: 20,
                  )
                : Row(
                    children: [
                      leadingIcon,
                      SizedBox(width: 10),
                    ],
                  ),
            Text(
              text ?? "",
              style: GoogleFonts.montserrat(
                color: textColor ?? kPrimaryColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailingIcon == null
                ? SizedBox(
                    width: 20,
                  )
                : Row(
                    children: [
                      SizedBox(width: 10),
                      trailingIcon,
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
