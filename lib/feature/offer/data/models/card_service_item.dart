// lib/feature/offer/data/models/card_service_item.dart

import 'package:flutter/material.dart';

class CardServiceItem {
  final String image;
  final String title;
  final VoidCallback onTap;

  CardServiceItem({
    required this.image,
    required this.title,
    required this.onTap,
  });
}
