import 'package:hive_flutter/hive_flutter.dart';
import 'package:revalesuva/model/product_and_recipes/shopping_model.dart';
import 'package:revalesuva/utils/enums.dart';

class LocalShoppingHelper {
  static final LocalShoppingHelper instance = LocalShoppingHelper._internal();

  factory LocalShoppingHelper() {
    return instance;
  }

  LocalShoppingHelper._internal();

  Box<ShoppingModel>? _productBox;

  Future<void> init() async {
    // Register the adapter if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      // Use a unique adapter ID
      Hive.registerAdapter(ShoppingModelAdapter());
    }
    _productBox = await Hive.openBox<ShoppingModel>('productBox');
  }

  List<ShoppingModel> getAllProducts() {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }
    return _productBox!.values.toList();
  }

  Future<void> addProduct(ShoppingModel product, ShopType type) async {
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

  Future<void> removeProduct(int productId, ShoppingModel product) async {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    await _productBox!.delete(product.id);
  }

  Future<void> removeProductByProductList(List<ShoppingModel> productList) async {
    if (_productBox == null || !_productBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    for (var item in productList) {
      await _productBox!.delete(item.id);
    }
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
