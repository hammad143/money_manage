import 'package:hive/hive.dart';

part 'google_user_model.g.dart';

@HiveType(typeId: 3, adapterName: "GoogleUserModelAdapter")
class GoogleUserModel {
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

  GoogleUserModel(
      {this.email, this.displayName, this.photoUrl, this.id, this.appUserKey});

  GoogleUserModel.fromJson(Map<String, dynamic> data) {
    this.id = BigInt.parse(data['id']);
    this.email = data['email'];
    this.photoUrl = data['photo_url'];
    this.displayName = data['displayName'];
    this.appUserKey = data['appKey'];
  }

  @override
  String toString() {
    return "$displayName $email $photoUrl $appUserKey";
  }
}
