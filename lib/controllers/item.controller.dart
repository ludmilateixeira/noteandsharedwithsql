import 'package:noteandsharedwithsql/repositories/item.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:noteandsharedwithsql/models/item.model.dart';
import '../app_status.dart';
part 'item.controller.g.dart';

class ItemController = _ItemController with _$ItemController;

abstract class _ItemController with Store {
  ItemRepository repository;
  _ItemController() {
    _init();
  }
  Future<void> _init() async {
    repository = await ItemRepository.getInstance();
    await getAll();
  }

  @observable
  AppStatus status = AppStatus.none;
  @observable
  ObservableList<Produto> list = ObservableList<Produto>();
  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      if (repository != null) {
        final allList = await repository.getAll();
        list.clear();
        list.addAll(allList);
      }
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> create(Produto p) async {
    status = AppStatus.loading;
    try {
      await repository.create(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> update(Produto p) async {
    status = AppStatus.loading;
    try {
      await repository.update(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      await repository.delete(id);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }
}
