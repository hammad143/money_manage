import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';

//part 'list_of_tiles.g.dart';

class ListOfTilesViewModel extends HiveObject {
  List<ListOfTilesModel> tiles = <ListOfTilesModel>[];

  final singleton = ListOfTilesViewModel._();

  ListOfTilesViewModel._();

  factory ListOfTilesViewModel() => ListOfTilesViewModel._();
}
