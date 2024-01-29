import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoromano_diccionario/config.dart';
import 'package:neoromano_diccionario/style.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  final Widget? custom;

  const Header({
    Key? key,
    this.custom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: custom != null
            ? BoxDecoration(
                color: Style.colorSecondary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              left(context),
              socialLinks(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget left(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          if (custom != null && !Config.isWebMobile())
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MaterialButton(
                // navigate to home
                // onPressed: () => BlocProvider.of<DictionaryBloc>(context)
                //     .add(DictionaryEvent.home()),
                onPressed: () => GoRouter.of(context).go('/home'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "NEOROMANO",
                      style: GoogleFonts.headlandOne(
                        fontSize: 23.0,
                        color: Style.colorAccent,
                      ),
                    ),
                    Text(
                      "DICCIONARIO",
                      style: GoogleFonts.headlandOne(
                        fontSize: 10.0,
                        color: Style.colorOnPrimary,
                      ).copyWith(letterSpacing: 7.2),
                    ),
                  ],
                ),
              ),
            ),
          if (custom != null)
            Config.isWebMobile()
                ? Expanded(
                    child: custom!,
                  )
                : Container(
                    padding: const EdgeInsets.only(left: 10),
                    constraints: BoxConstraints(maxWidth: 400),
                    child: custom,
                  ),
        ],
      ),
    );
  }

  Widget socialLinks(BuildContext context) {
    return Visibility(
      visible: !Config.isWebMobile(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          socialLink("Sito Officiale", Config.OfficialWebsiteUrl),
          separator(),
          socialIcon(FontAwesomeIcons.discord, Config.DiscordUrl),
          separator(),
          socialIcon(FontAwesomeIcons.reddit, Config.RedditUrl),
          separator(),
          socialIcon(FontAwesomeIcons.github, Config.GithubUrl),
        ],
      ),
    );
  }

  Widget separator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        height: 30,
        child: VerticalDivider(color: Style.colorOnPrimary),
      ),
    );
  }

  Widget socialLink(String label, String url) {
    return TextButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18.0,
          color: Style.colorOnPrimary,
        ),
      ),
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
    );
  }

  Widget socialIcon(IconData icon, String url) {
    return IconButton(
      iconSize: 35,
      padding: EdgeInsets.zero,
      icon: FaIcon(
        icon,
        color: Style.colorOnSecondary,
      ),
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
    );
  }
}
