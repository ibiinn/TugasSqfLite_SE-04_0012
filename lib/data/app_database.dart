import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const String namaFile = 'produk.db';
  static const String produkTabel = 'produk';
  static const int versiSkema = 1;

  static const String _buatTabel = '''
    CREATE TABLE $produkTabel (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT NOT NULL,
      stok INTEGER NOT NULL DEFAULT 0
    )
  ''';

  Database? _koneksi;

  Future<Database> get db async {
    final aktif = _koneksi;
    if (aktif != null) return aktif;

    final baru = await _buka();
    _koneksi = baru;
    return baru;
  }

  Future<Database> _buka() async {
    final lokasi = kIsWeb ? namaFile : '${await getDatabasesPath()}/$namaFile';

    return openDatabase(
      lokasi,
      version: versiSkema,
      onCreate: (database, _) => database.execute(_buatTabel),
    );
  }
}
