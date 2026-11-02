import 'package:flutter/material.dart';
import 'sqflite_produk_tab.dart';
import 'drift_produk_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CRUD Produk: SQFlite vs Drift'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.table_chart), text: 'SQFlite'),
              Tab(icon: Icon(Icons.auto_awesome), text: 'Drift'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SqfliteProdukTab(),
            DriftProdukTab(),
          ],
        ),
      ),
    );
  }
}
