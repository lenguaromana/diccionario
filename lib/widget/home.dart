import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoromano_diccionario/config.dart';
import 'package:neoromano_diccionario/style.dart';
import 'package:neoromano_diccionario/widget/page.dart';
import 'package:neoromano_diccionario/widget/searchbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "NEOROMANO",
            style: GoogleFonts.headlandOne(
              fontSize: Config.responsiveWidth(context, 80),
              color: Style.colorAccent,
            ),
          ),
          Text(
            "DICCIONARIO",
            style: GoogleFonts.headlandOne(
              fontSize: Config.responsiveWidth(context, 25),
              color: Style.colorOnPrimary,
            ).copyWith(letterSpacing: Config.responsiveWidth(context, 32)),
          ),
          SizedBox(height: Config.responsiveHeight(context, 100)),
          Container(
            constraints: BoxConstraints(maxWidth: 550),
            child: Searchbar(),
          ),
          Container(),
          SizedBox(height: Config.responsiveHeight(context, 500)),
        ],
      ),
    );
  }
}
