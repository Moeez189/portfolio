import 'package:flutter/foundation.dart';

/// Web-only behavior in production. On non-web platforms this is a no-op.
final ValueNotifier<String> fragmentNotifier = ValueNotifier<String>('');

String get currentFragment => fragmentNotifier.value;

void setFragment(String fragment, {bool replace = false}) {
  if (replace) {
    // Non-web platforms do not manage browser history.
  }
  fragmentNotifier.value = fragment;
}

void clearFragment() {
  fragmentNotifier.value = '';
}
