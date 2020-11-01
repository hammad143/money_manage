import 'package:hive/hive.dart';

part 'list_of_tiles_model.g.dart';

@HiveType(typeId: 0)
class ListOfTilesModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  String amount;
  @HiveField(2)
  String dateInString;

  ListOfTilesModel({this.title, this.amount, this.dateInString});
}
