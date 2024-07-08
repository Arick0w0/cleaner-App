// lib/feature/offer/data/dummy_data.dart

import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/offer/data/models/card_service_item.dart';
import 'package:mae_ban/feature/offer/data/models/cleaner_model.dart';

// Dummy data for the lists
final List<String> advertItems = [
  MTexts.ab01,
  MTexts.ab01,
  MTexts.ab01,
];

// Popular service
final List<CardServiceItem> cardServiceItems = [
  CardServiceItem(
    image: MTexts.mock02,
    title: MTexts.cleanService,
    onTap: () {
      print('1');
    },
  ),
  CardServiceItem(
    image: MTexts.mock02,
    title: MTexts.cleanService,
    onTap: () {
      print('2');
    },
  ),
  CardServiceItem(
    image: MTexts.mock01,
    title: MTexts.cleanService,
    onTap: () {
      print('3');
    },
  ),
];

// Cleaner items
final List<Cleaner> cleaners = [
  Cleaner(
    name: 'Somsy Souvannaphong',
    image: 'assets/mock/mock02.png',
    imageProfile: 'assets/mock/human.png',
  ),
  Cleaner(
    name: 'Vannasy Keola',
    image: 'assets/mock/mock02.png',
    imageProfile: 'assets/mock/human.png',
  ),
  Cleaner(
    name: 'Vannasy Keola',
    image: 'assets/mock/mock02.png',
    imageProfile: 'assets/mock/human.png',
  ),
  Cleaner(
    name: 'Vannasy Keola',
    image: 'assets/mock/mock02.png',
    imageProfile: 'assets/mock/human.png',
  ),
  // เพิ่มข้อมูลจำลองอีกตามต้องการ
];
