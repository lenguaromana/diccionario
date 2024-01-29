import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoromano_diccionario/config.dart';
import 'package:neoromano_diccionario/dict/dict.dart';
import 'package:neoromano_diccionario/dict/dict_cubit.dart';
import 'package:neoromano_diccionario/dict/language.dart';
import 'package:neoromano_diccionario/style.dart';
import 'package:neoromano_diccionario/widget/page.dart';
import 'package:neoromano_diccionario/widget/searchbar.dart';

class SearchPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        BlocBuilder<DictionaryCubit, DictionaryState>(
          builder: (context, state) => PageTemplate(
            header: Searchbar(),
            content: state.matches.when(
              some: (matches) => ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: matches.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return match(matches[index]);
                },
              ),
              none: () => Container(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
          child: GestureDetector(
            onTap: () {
              _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Style.colorSurface,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget empty(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: Config.responsiveHeight(context, 100)),
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
        Container(),
      ],
    );
  }

  Widget match(SearchMatch match) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          width: 550,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Style.DarkerPink, width: 4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 120, child: Language.NeoRomano.widget()),
                      SizedBox(width: 20),
                      Flexible(
                        child: SelectableText(
                          match.entry.as(Language.NeoRomano).unwrap(),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Style.DarkerPink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu_book,
                          color: Style.DarkerPink,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SelectableText(
                            match.entry.catGram,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                              color: Style.DarkerPink,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (match.entry.theme() != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bookmark,
                            color: Style.DarkerPink,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SelectableText(
                                match.entry.theme()!,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  color: Style.DarkerPink,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 1,
                      color: Style.DarkerPink,
                    ),
                  ),
                  Column(
                    children: match.entry
                        .langs()
                        .skip(1)
                        .map(
                          (lang) => Row(
                            children: [
                              SizedBox(width: 120, child: lang.widget()),
                              SizedBox(width: 20),
                              Flexible(
                                child: SelectableText(
                                  match.entry.as(lang).unwrap(),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Style.DarkerPink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
