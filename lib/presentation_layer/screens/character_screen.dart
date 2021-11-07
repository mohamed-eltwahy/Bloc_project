import '../../businessLogic_layer/cubit/characters_cubit.dart';
import '../../data_layer/models/characters_model.dart';
import '../../helper/const.dart';
import '../widgets/character_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  List<CharactersModel> allcharacters = [];
  List<CharactersModel> searchedcharacters = [];
  bool search = false;
  final _controller = TextEditingController();
  Widget _buildsearchItem() {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'Search about Character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (val) {
        searchedcharacters = allcharacters
            .where(
              (element) => element.name!.toLowerCase().startsWith(val),
            )
            .toList();
        setState(() {});
      },
    );
  }

  List<Widget> _buildsearchappbar() {
    if (search) {
      return [
        IconButton(
            onPressed: () {
              _controller.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
      ];
    } else {
      return [
        IconButton(onPressed: _startsearch, icon: const Icon(Icons.search)),
      ];
    }
  }

  _startsearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopsearch));
    setState(() {
      search = true;
    });
  }

  _stopsearch() {
    setState(() {
      _controller.clear();
      search = false;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getalldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: search
            ? _buildsearchItem()
            : const Text(
                'Breaking Bad',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        actions: _buildsearchappbar(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocBuilder<CharactersCubit, CharactersState>(
              builder: (context, state) {
                if (state is CharacterLoaded) {
                  allcharacters = state.charactersState;
                  return _buildgridviewList()!;
                } else {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    radius: 18.0,
                  ));
                }
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'No Internet Connection !',
                  style: TextStyle(color: mainColor, fontSize: 20),
                ),
                Image.asset(
                  'assets/images/noInternet.png',
                ),
              ],
            );
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget? _buildgridviewList() {
    return ListView(
      shrinkWrap: true,
      children: [
        // allcharacters.isEmpty || searchedcharacters.isEmpty
        //     ? const Center(child: Text('no data'))
        //     :
        GridView.builder(
            itemCount: _controller.text.isEmpty
                ? allcharacters.length
                : searchedcharacters.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1),
            itemBuilder: (context, index) {
              return (index % 2 != 1)
                  ? Transform.translate(
                      offset: const Offset(0, 90),
                      child: CharacterItem(
                        characteritem: _controller.text.isEmpty
                            ? allcharacters[index]
                            : searchedcharacters[index],
                      ),
                    )
                  : CharacterItem(
                      characteritem: _controller.text.isEmpty
                          ? allcharacters[index]
                          : searchedcharacters[index]);
            })
      ],
    );
  }
}
