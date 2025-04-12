import 'dart:io';

import 'package:flutter/material.dart';
import 'service.dart';

final baseUrl = !Platform.isWindows
    // ? "https://10.0.2.2:5000/v1"
    ? "https://192.168.13.135:5000/v1"
    : "https://localhost:5000/v1";
final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
Service? serviceApp;
