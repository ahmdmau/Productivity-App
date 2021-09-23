import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:productivity_app/constants/colors.dart';
import 'package:productivity_app/data/models/work_model.dart';

class WorkItemWidget extends StatelessWidget {
  final int index;
  final Function onTapItem;
  final WorkModel workModel;
  const WorkItemWidget({
    Key? key,
    required this.index,
    required this.onTapItem,
    required this.workModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        margin: EdgeInsets.only(top: index == 0 ? 4 : 20, left: 4, right: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColorShadow,
              offset: Offset(0, 3),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workModel.workName,
                  style: GoogleFonts.montserrat(
                    fontSize: 15.0,
                    color: kPrimaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.query_builder,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${workModel.startTime} - ${workModel.endTime}",
                      style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: kSecondaryTextColor,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}
