import 'package:hive_flutter/hive_flutter.dart';
import 'package:revalesuva/model/store/store_model.dart' as store_model;

class LocalCartHelper {
  static final LocalCartHelper instance = LocalCartHelper._internal();

  factory LocalCartHelper() {
    return instance;
  }

  LocalCartHelper._internal();

  Box<store_model.Datum>? _productBox;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(store_model.DatumAdapter());
    }
    _productBox = await Hive.openBox<store_model.Datum>('cartBox');
  }

  List<store_model.Datum> getAllProducts() {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }
    return _productBox!.values.toList();
  }

  Future<void> addProduct(store_model.Datum product) async {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    // Use product.id as the key to prevent duplicates
    await _productBox!.put(product.id, product);
  }

  Future<void> updateQty(int index, int qty) async {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    final product = _productBox!.getAt(index);
    if (product != null) {
      product.qty = qty;
      await _productBox!.putAt(index, product);
    }
  }

  Future<void> removeProduct(int productId) async {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    await _productBox!.deleteAt(productId);
  }

  Future<void> clearAllData() async {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    await _productBox!.clear();
  }

  bool hasProduct(int productId) {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    return _productBox!.containsKey(productId);
  }

  Future<void> dispose() async {
    if (_productBox != null && _productBox!.isOpen) {
      await _productBox!.close();
    }
  }
}
