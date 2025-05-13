import 'dart:convert';

import '../models/sample_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class SampleService {
  Future<List<Sections>> loadSampleData() async {
    final jsonString = await rootBundle.loadString('assets/data/data.json');
    final jsonMap = json.decode(jsonString);
    final List sections = jsonMap['sections'];

    return sections.map((json) => Sections.fromJson(json)).toList();
  }
}
