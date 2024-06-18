// lib/feature/joboffer/presentation/widgets/service_card.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/secret/secret.dart';

class CardService extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const CardService({
    required this.image,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String baseUrl = Config.s3BaseUrl;
    // Replace with your actual base URL
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                baseUrl + image,
                width: 220,
                height: 155,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 155);
                },
              ),
            ),
            const Gap(4),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
