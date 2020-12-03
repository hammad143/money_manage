abstract class Model {
  Map<String, dynamic> toMap();
  T toJson<T extends Model>(Map<String, dynamic> map);
}
