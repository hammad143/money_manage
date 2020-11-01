import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';

part 'list_of_tiles.g.dart';

@HiveType(typeId: 0)
class ListOfTilesViewModel extends HiveObject {
  @HiveField(0)
  List<ListOfTilesModel> tiles = <ListOfTilesModel>[];
  @HiveField(1)
  final singleton = ListOfTilesViewModel._();

  ListOfTilesViewModel._();

  factory ListOfTilesViewModel() => ListOfTilesViewModel._();
}
