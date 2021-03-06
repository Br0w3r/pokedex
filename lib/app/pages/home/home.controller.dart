import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pokedex/app/pages/home/widgets/detail_pokemon.dart';
import 'package:pokedex/core/routes/pages.dart';
import 'package:pokedex/data/models/entities/pokemon.model.dart';
import 'package:pokedex/data/services/pokemons/pokemon.contract.dart';

class HomeController extends GetxController {
  // ignore: unused_field
  final IPokemonService _pokemonService;
  final nameShared = const FlutterSecureStorage();

  HomeController(this._pokemonService);

  var loading = false.obs;
  var nameUser = ''.obs;
  var pokemon = <PokemonModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    nameUser.value =
        await const FlutterSecureStorage().read(key: 'nameUser') ?? '';
    getPokemon();
  }

  getPokemon() async {
    loading.value = true;
    for (int i = 1; i <= 150; i++) {
      var data = await _pokemonService.getPokemonById(i);
      pokemon.add(data);
    }
    loading.value = false;
  }

  signOut() {
    nameShared.write(key: 'nameUser', value: '');
    Get.offAllNamed(Routes.login);
  }

  goToDetail(PokemonModel pokemonModel) {
    Get.to(() => DetailPokemon(pokemonModel));
  }
}
