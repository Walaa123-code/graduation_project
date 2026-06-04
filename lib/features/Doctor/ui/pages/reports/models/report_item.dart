import 'package:flutter/material.dart';

class ReportItem {
  final String title;
  final String date;
  final String status;
  final Color statusColor;

  const ReportItem({
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
  });
}
