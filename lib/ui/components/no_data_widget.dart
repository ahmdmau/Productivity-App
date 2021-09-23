import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(42),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icon/ic_no_data.svg',
            height: 72,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 16,
          ),
          Text("Belum Ada Data", style: GoogleFonts.montserrat(fontSize: 16.0)),
        ],
      ),
    );
  }
}
