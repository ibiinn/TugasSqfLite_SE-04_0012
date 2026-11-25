class Produk {
  const Produk({this.id, required this.nama, required this.stok});

  final int? id;
  final String nama;
  final int stok;

  factory Produk.fromRow(Map<String, Object?> row) {
    return Produk(
      id: row['id'] as int?,
      nama: row['nama'] as String? ?? '',
      stok: row['stok'] as int? ?? 0,
    );
  }

  Map<String, Object?> toRow() {
    return {'nama': nama, 'stok': stok};
  }

  @override
  String toString() => 'Produk(#$id, $nama, stok: $stok)';

  @override
  bool operator ==(Object other) {
    return other is Produk &&
        other.id == id &&
        other.nama == nama &&
        other.stok == stok;
  }

  @override
  int get hashCode => Object.hash(id, nama, stok);
}
