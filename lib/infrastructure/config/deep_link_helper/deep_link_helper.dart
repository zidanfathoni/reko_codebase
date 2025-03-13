import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DeepLinkHelper {
  StreamSubscription<Uri>? _linkSubscription;

  Future<void> initDeepLinks() async {
    // Handle initial link
    final initialUri = await AppLinks().getInitialLink();
    if (initialUri != null) {
      debugPrint('Initial link: $initialUri');
      _handleDeepLink(initialUri);
    }

    // Listen for subsequent links
    _linkSubscription = AppLinks().uriLinkStream.listen(
      (uri) {
        debugPrint('onAppLink: $uri');
        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Failed to handle link: $err');
      },
    );
  }

  void _handleDeepLink(Uri link) {
    final pathSegments = link.pathSegments;

    if (pathSegments.isEmpty) return;

    switch (pathSegments.first) {
      case 'blogs':
        final slug = pathSegments.length > 1 ? pathSegments[1] : '';
        // Navigator.pushNamed(context, '/blog-detail', arguments: slug);
        // ApiBLogs().apiGetBlogDetail(slug: slug, idBlog: 0);
        // // Get.toNamed('/blog-detail', arguments: slug);
        // Get.to(
        //   const BlogDetail(),
        //   binding: BindingsBuilder.put(() => BlogBinding()),
        //   transition: Transition.downToUp,
        // );
        break;

      // case 'articles':
      //   final articleId = pathSegments.length > 1 ? pathSegments[1] : '';
      //   Navigator.pushNamed(context, '/article-detail', arguments: articleId);
      //   break;

      // case 'products':
      //   final productId = pathSegments.length > 1 ? pathSegments[1] : '';
      //   Navigator.pushNamed(context, '/product-detail', arguments: productId);
      //   break;

      default:
        Navigator.pushNamed(Get.context!, '/home');
    }
  }
}
