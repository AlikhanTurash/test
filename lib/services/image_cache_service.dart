import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheService extends CacheManager {
  static const key = 'customCacheKey';

  static final ImageCacheService _instance = ImageCacheService._();
  factory ImageCacheService() => _instance;

  ImageCacheService._() : super(Config(key, stalePeriod: const Duration(days: 7), maxNrOfCacheObjects: 100));

  Future<void> clearCache() async {
    await emptyCache();
  }
}