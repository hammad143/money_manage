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
  @HiveField(5)
  String currency;
  @HiveField(6)
  double latitude;
  @HiveField(7)
  double longitude;

  ListOfTilesModel(
      {this.title,
      this.amount,
      this.dateInString,
      this.option,
      this.latitude,
      this.longitude});

  ListOfTilesModel.fromJSON(Map<String, dynamic> data) {
    this.title = data['title'];
    this.amount = data['amount'];
    this.dateInString = data['date'];
    this.option = data['option'];
    this.currency = data['currency'];
    this.latitude = data['latitude'];
    this.longitude = data['longitude'];
  }
}

/*
*       "auto_increment": numOfItems,
          "title": title,
          "amount": amount,
          "date": date,
          "option": option,
* */
