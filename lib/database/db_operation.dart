abstract class DbOperation<Model> {
  Future<int> create(Model userAzkar);

  Future<List<Model>> read();

  Future<bool> update(Model userAzkar);

  Future<bool> delete(int id);
}
