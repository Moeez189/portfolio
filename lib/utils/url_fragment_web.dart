// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/foundation.dart';

final ValueNotifier<String> fragmentNotifier = ValueNotifier<String>(
  Uri.base.fragment,
);

String get currentFragment => fragmentNotifier.value;

void setFragment(String fragment) {
  final uri = Uri.base;
  final pathAndQuery = uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
  final next = fragment.isEmpty ? pathAndQuery : '$pathAndQuery#$fragment';

  html.window.history.replaceState(null, '', next);
  fragmentNotifier.value = fragment;
}

void clearFragment() {
  setFragment('');
}
