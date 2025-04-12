import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/profile/view/profile_view.dart';
import 'package:flutter_app/presentation/transaction/view/transaction_view.dart';

class MainConstants {
  static const floatingActionButtonDimension = 56;
  static const floatingActionButtonIconSize = 52;

  static const screenAnimatingDuration = Duration(milliseconds: 300);

  static final List<Map<String, dynamic>> bottomIconsData = [
    {
      "iconPath": Icons.monetization_on,
      "label": 'Transactions',
    },
    {
      "iconPath": Icons.home,
      "label": 'My page',
    },
  ];

  static final screens = [
    const TransactionScreenProvider(),
    const ProfileScreen(),
  ];
}
