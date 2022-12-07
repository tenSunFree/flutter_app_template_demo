import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';

final navigatorStateKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final dioProvider = Provider((ref) => Dio());
