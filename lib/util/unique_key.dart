class StoreUniqueKey {
  final String uniqueID;
  static StoreUniqueKey instance;

  StoreUniqueKey._(this.uniqueID);
  factory StoreUniqueKey() => instance;

  static void set(String key) {
    instance = StoreUniqueKey._(key);
  }
}
