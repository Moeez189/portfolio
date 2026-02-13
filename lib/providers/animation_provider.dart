import 'package:flutter/foundation.dart';

class AnimationProvider extends ChangeNotifier {
  final Set<String> _animatedSections = {};

  bool hasAnimated(String sectionKey) {
    return _animatedSections.contains(sectionKey);
  }

  void markAsAnimated(String sectionKey) {
    if (!_animatedSections.contains(sectionKey)) {
      _animatedSections.add(sectionKey);
      notifyListeners();
    }
  }
}
