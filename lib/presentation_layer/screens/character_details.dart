import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../businessLogic_layer/cubit/characters_cubit.dart';
import '../../data_layer/models/characters_model.dart';
import '../../helper/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetails extends StatefulWidget {
  final CharactersModel characterDetails;

  const CharacterDetails({Key? key, required this.characterDetails})
      : super(key: key);

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context)
        .getquote(widget.characterDetails.name!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            expandedHeight: 600,
            pinned: true,
            stretch: true,
            backgroundColor: mainColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.characterDetails.nickname!),
              background: Hero(
                tag: widget.characterDetails.charId!,
                child: Image.network(
                  widget.characterDetails.img!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  // padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _characterInfo('Job : ',
                          widget.characterDetails.occupation!.join('/')),
                      _divider(316),
                      _characterInfo(
                          'Apeared In : ', widget.characterDetails.category!),
                      _divider(300),
                      _characterInfo('Seasons : ',
                          widget.characterDetails.appearance!.join('/')),
                      _divider(290),
                      _characterInfo(
                          'Status : ', widget.characterDetails.status!),
                      _divider(300),
                      // widget.characterDetails.betterCallSaulAppearance!.isEmpty
                      //     ? const SizedBox()
                      //     : _characterInfo(
                      //         'Better Call Saul : ',
                      //         widget.characterDetails.betterCallSaulAppearance!
                      //             .join('/')),
                      // widget.characterDetails.betterCallSaulAppearance!.isEmpty
                      //     ? const SizedBox()
                      //     : _divider(150),
                      _characterInfo(
                          'Actor/Actress : ', widget.characterDetails.name!),
                      _divider(250),
                      const SizedBox(
                        height: 20,
                      ),

                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          if (state is CharacterQuoteLoaded) {
                            var quotes = state.characterquoteState;
                            if (quotes.isNotEmpty) {
                              int randomquote = Random().nextInt(quotes.length);
                              return DefaultTextStyle(
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 7.0,
                                      color: Colors.white,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FlickerAnimatedText(
                                      quotes[randomquote].quote!,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          } else {
                            return const Center(
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: mainColor,
                                  )),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextSpan(
              text: value,
              style: const TextStyle(color: Colors.white, fontSize: 15))
        ],
      ),
    );
  }

  Widget _divider(double endindent) {
    return Divider(
      height: 30,
      color: mainColor,
      endIndent: endindent,
      thickness: 3,
    );
  }
}
