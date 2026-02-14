// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';

import '../constants/app_strings.dart';

const String _sectionQueryKey = 'section';

String _normalizedLocation() {
  final rawLocation = Uri.base.fragment;
  if (rawLocation.isEmpty) return AppStrings.routeHome;
  return rawLocation.startsWith('/') ? rawLocation : '/$rawLocation';
}

String _readSectionFromLocation() {
  final locationUri = Uri.parse(_normalizedLocation());
  return locationUri.queryParameters[_sectionQueryKey] ?? '';
}

final ValueNotifier<String> fragmentNotifier = ValueNotifier<String>(
  _readSectionFromLocation(),
);

String get currentFragment => _readSectionFromLocation();

void _syncFragmentFromLocation() {
  final section = _readSectionFromLocation();
  if (fragmentNotifier.value != section) {
    fragmentNotifier.value = section;
  }
}

final StreamSubscription<html.PopStateEvent> _popStateSubscription = html
    .window
    .onPopState
    .listen((_) => _syncFragmentFromLocation());
final StreamSubscription<html.Event> _hashChangeSubscription = html
    .window
    .onHashChange
    .listen((_) => _syncFragmentFromLocation());

void setFragment(String fragment, {bool replace = false}) {
  // Keep subscriptions alive for the app lifetime.
  _popStateSubscription;
  _hashChangeSubscription;

  final normalizedFragment = fragment.trim();
  final homeLocation = Uri(
    path: AppStrings.routeHome,
    queryParameters: normalizedFragment.isEmpty
        ? null
        : <String, String>{_sectionQueryKey: normalizedFragment},
  ).toString();
  final currentLocation = _normalizedLocation();

  if (homeLocation == currentLocation) {
    _syncFragmentFromLocation();
    return;
  }

  final uri = Uri.base;
  final pathAndQuery = uri.hasQuery ? '${uri.path}?${uri.query}' : uri.path;
  final next = '$pathAndQuery#$homeLocation';

  // Always use replaceState — section scrolls are in-page navigation
  // and should never create new browser history entries.
  html.window.history.replaceState(null, '', next);
  fragmentNotifier.value = normalizedFragment;
}

void clearFragment() {
  setFragment('');
}
