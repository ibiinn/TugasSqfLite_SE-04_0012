import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp05/data/produk_repository.dart';
import 'package:tp05/model/produk.dart';

class ProdukController extends GetxController {
  ProdukController(this._repository);

  final ProdukRepository _repository;

  final produk = <Produk>[].obs;
  final memuat = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => muatProduk());
  }

  Future<void> muatProduk() async {
    memuat.value = true;
    try {
      produk.value = await _repository.daftar();
    } catch (_) {
      _pesan('Data produk tidak dapat dimuat', gagal: true);
    } finally {
      memuat.value = false;
    }
  }

  Future<bool> tambahProduk(Produk item) async {
    try {
      await _repository.tambah(item);
      produk.value = await _repository.daftar();
      _pesan('${item.nama} tersimpan dengan stok ${item.stok}');
      return true;
    } catch (_) {
      _pesan('Produk gagal disimpan', gagal: true);
      return false;
    }
  }

  void _pesan(String teks, {bool gagal = false}) {
    Get.snackbar(
      gagal ? 'Gagal' : 'Berhasil',
      teks,
      backgroundColor: gagal ? Colors.red.shade600 : Colors.green.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
