import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tp05/controller/produk_controller.dart';
import 'package:tp05/model/produk.dart';

class TambahProdukDialog extends StatefulWidget {
  const TambahProdukDialog({super.key});

  @override
  State<TambahProdukDialog> createState() => _TambahProdukDialogState();
}

class _TambahProdukDialogState extends State<TambahProdukDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _stok = TextEditingController();
  bool _menyimpan = false;

  @override
  void dispose() {
    _nama.dispose();
    _stok.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _menyimpan = true);

    final berhasil = await Get.find<ProdukController>().tambahProduk(
      Produk(
        nama: _nama.text.trim(),
        stok: int.parse(_stok.text.trim()),
      ),
    );

    if (!mounted) return;
    setState(() => _menyimpan = false);

    if (berhasil) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Produk Baru'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nama,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nama produk',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) {
                if (nilai == null || nilai.trim().isEmpty) {
                  return 'Nama produk wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _stok,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah stok',
                border: OutlineInputBorder(),
              ),
              validator: (nilai) {
                final stok = int.tryParse((nilai ?? '').trim());
                if (stok == null || stok < 0) {
                  return 'Stok harus angka 0 atau lebih';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _menyimpan ? null : () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _menyimpan ? null : _submit,
          child: _menyimpan
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
