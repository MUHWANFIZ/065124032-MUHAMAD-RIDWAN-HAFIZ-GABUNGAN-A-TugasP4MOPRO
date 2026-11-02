import 'package:flutter/material.dart';
import '../helpers/sqflite_produk_helper.dart';

class SqfliteProdukTab extends StatefulWidget {
  const SqfliteProdukTab({super.key});

  @override
  State<SqfliteProdukTab> createState() => _SqfliteProdukTabState();
}

class _SqfliteProdukTabState extends State<SqfliteProdukTab>
    with AutomaticKeepAliveClientMixin {
  List<Map<String, dynamic>> _produk = [];
  bool _isLoading = true;
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshProduk();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  Future<void> _refreshProduk() async {
    try {
      final data = await SqfliteProdukHelper.getAllProduk();
      if (!mounted) return;
      setState(() {
        _produk = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  void _showFormDialog({Map<String, dynamic>? existing}) {
    final isEdit = existing != null;
    _namaController.text = existing?['nama_produk'] ?? '';
    _hargaController.text = existing?['harga']?.toString() ?? '';
    _stokController.text = existing?['stok']?.toString() ?? '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Produk',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Stok',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => _saveProduk(ctx, existing?['id']),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProduk(BuildContext dialogCtx, int? id) async {
    final nama = _namaController.text.trim();
    final harga = int.tryParse(_hargaController.text.trim());
    final stok = int.tryParse(_stokController.text.trim());

    if (nama.isEmpty || harga == null || stok == null) {
      if (dialogCtx.mounted) {
        ScaffoldMessenger.of(dialogCtx).showSnackBar(
          const SnackBar(
            content: Text('Nama, harga, dan stok wajib diisi dengan valid'),
          ),
        );
      }
      return;
    }

    if (id == null) {
      await SqfliteProdukHelper.insertProduk(nama, harga, stok);
    } else {
      await SqfliteProdukHelper.updateProduk(id, nama, harga, stok);
    }

    _namaController.clear();
    _hargaController.clear();
    _stokController.clear();

    if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
    _refreshProduk();
  }

  Future<void> _deleteProduk(int id) async {
    await SqfliteProdukHelper.deleteProduk(id);
    _refreshProduk();
  }

  void _confirmDelete(int id, String nama) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Produk'),
        content: Text('Hapus "$nama" dari database?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteProduk(id);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _produk.isEmpty
              ? const Center(child: Text('Belum ada produk di database'))
              : ListView.builder(
                  itemCount: _produk.length,
                  itemBuilder: (context, index) {
                    final item = _produk[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${item['id']}'),
                        ),
                        title: Text(item['nama_produk'] ?? ''),
                        subtitle: Text(
                          'Harga: ${item['harga']} | Stok: ${item['stok']}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showFormDialog(existing: item),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _confirmDelete(item['id'], item['nama_produk']),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah Produk',
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
