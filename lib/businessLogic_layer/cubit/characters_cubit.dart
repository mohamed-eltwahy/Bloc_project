import 'package:bloc/bloc.dart';
import '../../data_layer/models/characters_model.dart';
import '../../data_layer/models/quote.dart';
import '../../data_layer/repositories/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository characterrepository;
  late List<CharactersModel> listCharacters = [];
  List<Quote> characterQuote = [];
  CharactersCubit(this.characterrepository) : super(CharactersInitial());

  List<CharactersModel> getalldata() {
    characterrepository.getallchatacters().then((value) {
      emit(CharacterLoaded(value));
      listCharacters = value;
    });
    return listCharacters;
  }

  List<Quote> getquote(String charName) {
    characterrepository.getcharacterquote(charName).then((value) {
      emit(CharacterQuoteLoaded(value));
      characterQuote = value;
    });
    return characterQuote;
  }
}
