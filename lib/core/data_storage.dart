abstract interface class DataStorage {
  Future<void> close();

  Future<List<Map<String, Object?>>> read({
    required String table,
    String? column,
    List<Object?>? args,
  });

  Future<void> delete({
    required String table,
    required String column,
    required List<Object?> args,
  });

  Future<void> update({
    required String table,
    required Map<String, Object?> value,
    required String column,
    required List<Object?> args,
  });

  Future<List<Map<String, Object?>>> insert({
    required String table,
    required Map<String, Object?> value,
    String? column,
    List<Object?>? args,
  });

  Future<List<Map<String, Object?>>> searchMessage({
    required List<Object> args,
  });
}
