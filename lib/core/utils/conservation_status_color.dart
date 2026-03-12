import 'package:flutter/material.dart';

Color statusColor(String status) {
  switch (status) {
    case "EN":
      return Colors.orange;
    case "VU":
      return Colors.yellow;
    case "CR":
      return Colors.red;
    case "NT":
      return Colors.lime;
    case "LC":
      return Colors.green;
    default:
      return Colors.grey;
  }
}