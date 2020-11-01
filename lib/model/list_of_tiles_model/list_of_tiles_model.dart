import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ListOfTilesModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  String amount;
  @HiveField(2)
  String dateInString;

  ListOfTilesModel({this.title, this.amount, this.dateInString});
}
