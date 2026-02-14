import 'dart:convert';

import 'package:flutter/services.dart';

class ProjectItem {
  final String name;
  final String description;
  final String androidLink;
  final String iosLink;

  const ProjectItem({
    required this.name,
    required this.description,
    required this.androidLink,
    required this.iosLink,
  });

  factory ProjectItem.fromJson(Map<String, dynamic> json) {
    return ProjectItem(
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      androidLink: (json['androidLink'] ?? '').toString(),
      iosLink: (json['iosLink'] ?? '').toString(),
    );
  }

  bool get hasAndroid => androidLink.trim().isNotEmpty;
  bool get hasIos => iosLink.trim().isNotEmpty;
  bool get hasSinglePlatform => hasAndroid ^ hasIos;

  String? get singlePlatformLink {
    if (hasAndroid && !hasIos) return androidLink;
    if (hasIos && !hasAndroid) return iosLink;
    return null;
  }
}

class ProjectsRepository {
  static const String _assetPath = 'assets/data/projects.json';

  static Future<List<ProjectItem>> loadProjects() async {
    final rawJson = await rootBundle.loadString(_assetPath);
    final decoded = jsonDecode(rawJson);
    if (decoded is! List) return const [];

    return decoded
        .whereType<Map>()
        .map((map) => map.map((key, value) => MapEntry(key.toString(), value)))
        .map(ProjectItem.fromJson)
        .toList(growable: false);
  }
}
