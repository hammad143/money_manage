import 'package:hive/hive.dart';
import 'package:money_management/model/user_adding_model/model.dart';

part 'google_user_model.g.dart';

@HiveType(typeId: 3, adapterName: "GoogleUserModelAdapter")
class GoogleUserModel extends Model {
  @HiveField(0)
  String email;
  @HiveField(1)
  String displayName;
  @HiveField(2)
  String photoUrl;
  @HiveField(3)
  BigInt id;
  @HiveField(4)
  String appUserKey;
  @HiveField(5)
  int autoInc;
  @HiveField(6)
  Map<String, dynamic> fields;

  GoogleUserModel(
      {this.fields,
      this.email,
      this.displayName,
      this.photoUrl,
      this.id,
      this.appUserKey});

  GoogleUserModel.fromJson(this.fields) {
    this.id = BigInt.parse(fields['id']);
    this.email = fields['email'];
    this.photoUrl = fields['photoUrl'];
    this.displayName = fields['name'];
    this.appUserKey = fields['appKey'];
    this.autoInc = fields['auto_increment'];
  }

  @override
  String toString() {
    return "$displayName $email $photoUrl $appUserKey";
  }

  @override
  Map<String, dynamic> toMap() {}

  @override
  T toJson<T extends Model>(Map<String, dynamic> map) {}
}
