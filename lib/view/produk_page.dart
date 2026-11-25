import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp05/controller/produk_controller.dart';
import 'package:tp05/view/tambah_produk_dialog.dart';

class ProdukPage extends StatelessWidget {
  const ProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProdukController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      body: Obx(() {
        if (controller.memuat.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.produk.isEmpty) {
          return const _ProdukKosong();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.produk.length,
          itemBuilder: (context, index) {
            final item = controller.produk[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(_inisial(item.nama)),
                ),
                title: Text(item.nama),
                subtitle: Text('Stok tersedia: ${item.stok}'),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) => const TambahProdukDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Produk'),
      ),
    );
  }

  String _inisial(String nama) {
    final bersih = nama.trim();
    return bersih.isEmpty ? '?' : bersih.substring(0, 1).toUpperCase();
  }
}

class _ProdukKosong extends StatelessWidget {
  const _ProdukKosong();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.inventory_2_outlined,
            size: 56,
            color: Color(0xFF9E9E9E),
          ),
          const SizedBox(height: 12),
          const Text(
            'Belum ada produk',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'Tekan tombol Produk untuk menambah data.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
