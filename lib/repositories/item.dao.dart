import 'package:noteandsharedwithsql/models/item.model.dart';
import 'package:floor/floor.dart';  

@dao
abstract class ItemDao{
  @Query('SELECT * FROM Produto')
  Future<List<Produto>> getAll();

  @Query("SELECT * from Produto where id = :id")
  Future<Produto> getItemById(int id);

  @insert
  Future<int> insertItem(Produto p);

  @update
  Future<int> updateItem(Produto p);

  @delete
  Future<int> deleteItem(Produto p);
}