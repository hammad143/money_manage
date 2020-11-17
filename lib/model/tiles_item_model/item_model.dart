import 'package:money_management/model/model.dart';

class ItemOfTilesModel extends Model {
  final String auto_increment, title, amount, date, option;
  final Map<String, dynamic> fields;

  ItemOfTilesModel({
    this.auto_increment,
    this.title,
    this.amount,
    this.date,
    this.option,
    this.fields,
  }) : super(fields);
}
