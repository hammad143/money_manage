import 'package:hive/hive.dart';

part 'google_user_model.g.dart';

@HiveType(typeId: 3, adapterName: "GoogleUserModelAdapter")
class GoogleUserModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String displayName;
  @HiveField(2)
  final String photoUrl;
  @HiveField(3)
  final BigInt id;
  @HiveField(4)
  final String appUserKey;

  GoogleUserModel(
      {this.email, this.displayName, this.photoUrl, this.id, this.appUserKey});

  @override
  String toString() {
    return "$displayName $email $photoUrl $appUserKey";
  }
}
