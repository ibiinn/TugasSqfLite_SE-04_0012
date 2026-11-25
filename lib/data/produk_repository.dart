import 'package:tp05/data/produk_dao.dart';
import 'package:tp05/model/produk.dart';

abstract class ProdukRepository {
  Future<int> tambah(Produk produk);
  Future<List<Produk>> daftar();
}

class SqliteProdukRepository implements ProdukRepository {
  SqliteProdukRepository(this._dao);

  final ProdukDao _dao;

  @override
  Future<int> tambah(Produk produk) => _dao.simpan(produk);

  @override
  Future<List<Produk>> daftar() => _dao.ambilSemua();
}
