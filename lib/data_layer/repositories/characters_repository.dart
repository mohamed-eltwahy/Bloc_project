import '../models/characters_model.dart';
import '../models/quote.dart';
import '../web_services/characters_web_servises.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<dynamic> getallchatacters() async {
    final characters = await charactersWebServices.getallchatacters();
    return (characters as List)
        .map<CharactersModel>(
            (character) => CharactersModel.fromJson(character))
        .toList();
  }

   Future<dynamic> getcharacterquote(String charname) async {
    final characterquote = await charactersWebServices.getcharacterQuote(charname);
    return (characterquote as List)
        .map<Quote>(
            (character) => Quote.fromJson(character))
        .toList();
  }
}
