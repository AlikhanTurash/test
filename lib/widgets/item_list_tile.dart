import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:untitled/models/item.dart';
import 'package:untitled/screens/detail_screen.dart';
import 'package:untitled/services/image_cache_service.dart';

class ItemListTile extends StatelessWidget {
  final Item item;

  const ItemListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 50,
        child: item.getImageUrl(size: 100) != null
            ? CachedNetworkImage(
          imageUrl: item.getImageUrl(size: 100)!,
          fit: BoxFit.cover,
          cacheManager: ImageCacheService(),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
            : const Icon(Icons.image_not_supported),
      ),
      title: Text(item.title),
      subtitle: Text(
        item.description ?? 'No description available',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(item: item),
          ),
        );
      },
    );
  }
}