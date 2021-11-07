part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharacterLoaded extends CharactersState{
 final List<CharactersModel> charactersState;

  CharacterLoaded(this.charactersState);
}


class CharacterQuoteLoaded extends CharactersState{
 final List<Quote> characterquoteState;

  CharacterQuoteLoaded(this.characterquoteState);
}

