import 'package:hive_flutter/hive_flutter.dart';
import 'package:revalesuva/model/my_plan/lessons/local_video_player_model.dart';

class LocalLessonsVideoHelper {
  static final LocalLessonsVideoHelper instance = LocalLessonsVideoHelper._internal();

  factory LocalLessonsVideoHelper() {
    return instance;
  }

  LocalLessonsVideoHelper._internal();

  Box<LocalVideoPlayerModel>? _videoBox;

  Future<void> init() async {
    // Register the adapter if not already registered
    if (!Hive.isAdapterRegistered(8)) {
      // Use a unique adapter ID
      Hive.registerAdapter(LocalVideoPlayerModelAdapter());
    }
    _videoBox = await Hive.openBox<LocalVideoPlayerModel>('videoBox');
  }

  List<LocalVideoPlayerModel> getAllProducts() {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }
    return _videoBox!.values.toList();
  }

  LocalVideoPlayerModel? getProductsByIndex({required int index}) {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    return _videoBox!.getAt(index);
  }

  Future<void> addProduct(LocalVideoPlayerModel product) async {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    // Use product.id as the key to prevent duplicates
    await _videoBox!.put(product.id, product);
  }

  Future<void> updateQty({required int index, required String totalLength, required String playedLength}) async {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    final product = _videoBox!.getAt(index);
    if (product != null) {
      product.totalLength = totalLength;
      product.playedLength = playedLength;
      await _videoBox!.putAt(index, product);
    }
  }

  Future<void> removeProduct(int productId, LocalVideoPlayerModel product) async {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    await _videoBox!.delete(product.id);
  }

  Future<void> removeProductByProductList(List<LocalVideoPlayerModel> productList) async {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    for (var item in productList) {
      await _videoBox!.delete(item.id);
    }
  }

  Future<void> clearAllData() async {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    await _videoBox!.clear();
  }

  bool hasProduct(int productId) {
    if (_videoBox == null || !_videoBox!.isOpen) {
      throw StateError('Product box is not initialized. Call init() first.');
    }

    return _videoBox!.containsKey(productId);
  }

  Future<void> dispose() async {
    if (_videoBox != null && _videoBox!.isOpen) {
      await _videoBox!.close();
    }
  }
}
