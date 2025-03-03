import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_sheet.dart';

class StorageService {
  static const String _characterSheetsKey = 'characterSheets';

  Future<List<CharacterSheetUniveresal>> loadCharacterSheets() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_characterSheetsKey);
    if (data != null) {
      try {
        final List<dynamic> decoded = json.decode(data);
        return decoded.map((item) {
          final map = item as Map<String, dynamic>;
          if (map['type'] == 'dnd') {
            return CharacterSheetDeD.fromMap(map);
          } else if (map['type'] == 'gaia') {
            return CharacterSheetGaia.fromMap(map);
          } else {
            return CharacterSheetDeD.fromMap(map);
          }
        }).toList();
      } catch (e) {
        print("Erro ao decodificar as fichas: $e");
        return [];
      }
    }
    return [];
  }

  Future<void> saveCharacterSheets(List<CharacterSheetUniveresal> sheets) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> maps = sheets.map((cs) => cs.toMap()).toList();
    await prefs.setString(_characterSheetsKey, json.encode(maps));
  }
}