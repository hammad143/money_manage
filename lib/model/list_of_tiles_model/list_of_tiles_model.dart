import 'package:hive/hive.dart';

part 'list_of_tiles_model.g.dart';

@HiveType(typeId: 1, adapterName: "ListTilesModelNewAdapter")
class ListOfTilesModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String amount;
  @HiveField(2)
  String dateInString;
  @HiveField(3)
  String option;

  ListOfTilesModel({this.title, this.amount, this.dateInString, this.option});

  ListOfTilesModel.fromJSON(Map<String, dynamic> data) {
    this.title = data['title'];
    this.amount = data['amount'];
    this.dateInString = data['date'];
    this.option = data['option'];
  }
}

/*
*       "auto_increment": numOfItems,
          "title": title,
          "amount": amount,
          "date": date,
          "option": option,
* */
