import '../businessLogic_layer/cubit/characters_cubit.dart';
import '../data_layer/models/characters_model.dart';
import '../data_layer/repositories/characters_repository.dart';
import '../data_layer/web_services/characters_web_servises.dart';
import 'const.dart';
import '../presentation_layer/screens/character_details.dart';
import '../presentation_layer/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late final CharactersRepository charactersRepository;
  late final CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: const CharacterScreen(),
          ),
        );
      case characterscren:
        final character = settings.arguments as CharactersModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>  CharactersCubit(charactersRepository),
                  child: CharacterDetails(characterDetails: character),
                ));

      //   break;
      // default:
    }
  }
}
