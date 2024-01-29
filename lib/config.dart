import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Config {
  static const GithubUrl = "https://github.com/lenguaromana/diccionario";
  static const OfficialWebsiteUrl = "https://lenguaromana.github.io/";
  static const Home = "/";
  static const RedditUrl = "javascript:void(0);";
  static const DiscordUrl = "javascript:void(0);";

  static bool isWebMobile() => (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android);

  static T responsive<T>(T mobile, T desktop) =>
      isWebMobile() ? mobile : desktop;

  static double responsiveWidth(BuildContext context, double size) {
    final w = MediaQuery.of(context).size.width;
    final t = (w - 350.0) / 1200.0;
    return (1 - t) * (size * 0.6) + t * size;
  }

  static double responsiveHeight(BuildContext context, double size) {
    final w = MediaQuery.of(context).size.height;
    final t = (w - 700.0) / 600.0;
    return (1 - t) * (size * 0.6) + t * size;
  }
}
