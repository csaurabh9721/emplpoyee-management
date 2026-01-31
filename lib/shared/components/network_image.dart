import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {

  const CustomNetworkImage(this.imageUrl,{
    super.key,
    required this.height,
    required this.width,
    required this.fit,
  });
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://example.com/image.png',
      fit: fit,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null ? child : const CircularProgressIndicator(),
      errorBuilder: (context, error, stackTrace) => const SizedBox(),
    );
  }
}
