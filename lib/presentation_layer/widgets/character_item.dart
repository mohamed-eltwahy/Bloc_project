import '../../data_layer/models/characters_model.dart';
import '../../helper/const.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final CharactersModel? characteritem;
  const CharacterItem({Key? key, this.characteritem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context,characterscren,
            arguments: characteritem),
        child: GridTile(
          child: Hero(
            tag: characteritem!.charId as int,
            child: Container(
              color: Colors.grey[400],
              child: characteritem!.img != null
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: characteritem!.img as String,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/notfound.jpg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              characteritem!.name as String,
              style: TextStyle(
                  color: Colors.grey[400], fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
