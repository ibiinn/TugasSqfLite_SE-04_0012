import 'package:tp05/data/app_database.dart';
import 'package:tp05/model/produk.dart';

class ProdukDao {
  ProdukDao(this._database);

  final AppDatabase _database;

  Future<int> simpan(Produk produk) async {
    final koneksi = await _database.db;
    return koneksi.insert(AppDatabase.produkTabel, produk.toRow());
  }

  Future<List<Produk>> ambilSemua() async {
    final koneksi = await _database.db;
    final baris = await koneksi.query(
      AppDatabase.produkTabel,
      orderBy: 'nama COLLATE NOCASE ASC',
    );

    return baris.map(Produk.fromRow).toList();
  }
}
