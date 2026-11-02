import 'package:flutter/material.dart';
import '../database/app_database.dart';

class DriftProdukTab extends StatefulWidget {
  const DriftProdukTab({super.key});

  @override
  State<DriftProdukTab> createState() => _DriftProdukTabState();
}

class _DriftProdukTabState extends State<DriftProdukTab>
    with AutomaticKeepAliveClientMixin {
  final AppDatabase _db = AppDatabase();
  List<ProdukItem> _produk = [];
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
    _db.close();
    super.dispose();
  }

  Future<void> _refreshProduk() async {
    try {
      final data = await _db.getAllProduk();
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

  void _showFormDialog({ProdukItem? existing}) {
    final isEdit = existing != null;
    _namaController.text = existing?.namaProduk ?? '';
    _hargaController.text = existing?.harga.toString() ?? '';
    _stokController.text = existing?.stok.toString() ?? '';

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
            onPressed: () => _saveProduk(ctx, existing),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProduk(BuildContext dialogCtx, ProdukItem? existing) async {
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

    if (existing == null) {
      await _db.insertProduk(
        ProdukCompanion.insert(namaProduk: nama, harga: harga, stok: stok),
      );
    } else {
      await _db.updateProduk(
        existing.copyWith(namaProduk: nama, harga: harga, stok: stok),
      );
    }

    _namaController.clear();
    _hargaController.clear();
    _stokController.clear();

    if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
    _refreshProduk();
  }

  Future<void> _deleteProduk(int id) async {
    await _db.deleteProduk(id);
    _refreshProduk();
  }

  void _confirmDelete(ProdukItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Produk'),
        content: Text('Hapus "${item.namaProduk}" dari database?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(ctx).pop();
              _deleteProduk(item.id);
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
                          child: Text('${item.id}'),
                        ),
                        title: Text(item.namaProduk),
                        subtitle: Text(
                          'Harga: ${item.harga} | Stok: ${item.stok}',
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
                              onPressed: () => _confirmDelete(item),
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
