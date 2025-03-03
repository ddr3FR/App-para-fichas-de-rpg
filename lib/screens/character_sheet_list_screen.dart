import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_sheet.dart';
import 'character_sheet_details_screen.dart';
import 'new_character_sheet_screen.dart';
import 'new_character_sheet_gaia_screen.dart';

// Tela que exibe a lista das fichas salvas (agora com suporte para D&D e Gaia)
class CharacterSheetListScreen extends StatefulWidget {
  const CharacterSheetListScreen({super.key});
  @override
  _CharacterSheetListScreenState createState() =>
      _CharacterSheetListScreenState();
}

class _CharacterSheetListScreenState extends State<CharacterSheetListScreen> {
  List<CharacterSheetUniveresal> characterSheets = [];

  @override
  void initState() {
    super.initState();
    _loadCharacterSheets();
  }

  Future<void> _loadCharacterSheets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('characterSheets');
    if (data != null) {
      try {
        final List<dynamic> decoded = json.decode(data);
        setState(() {
          characterSheets = decoded.map((item) {
            final map = item as Map<String, dynamic>;
            if (map['type'] == 'dnd') {
              return CharacterSheetDeD.fromMap(map);
            } else if (map['type'] == 'gaia') {
              return CharacterSheetGaia.fromMap(map);
            } else {
              return CharacterSheetDeD.fromMap(map);
            }
          }).toList();
        });
      } catch (e) {
        print("Erro ao decodificar as fichas: $e");
      }
    }
  }

  Future<void> _saveCharacterSheets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> maps =
        characterSheets.map((cs) => cs.toMap()).toList();

    await prefs.setString('characterSheets', json.encode(maps));
  }

  void _navigateToNewSheet() async {
    // Exibe um diálogo para escolher entre D&D e Gaia
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha o tipo de ficha'),
        content: const Text('Selecione o sistema para a ficha:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'dnd'),
            child: const Text('D&D'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'gaia'),
            child: const Text('Gaia'),
          ),
        ],
      ),
    );
    if (choice == 'dnd') {
      final newSheet = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewCharacterSheetScreen()),
      );
      if (newSheet != null && newSheet is CharacterSheetDeD) {
        setState(() { characterSheets.add(newSheet); });
        _saveCharacterSheets();
      }
    } else if (choice == 'gaia') {
      final newSheet = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewCharacterSheetGaiaScreen()),
      );
      if (newSheet != null && newSheet is CharacterSheetGaia) {
        setState(() { characterSheets.add(newSheet); });
        _saveCharacterSheets();
      }
    }
  }

  void _navigateToEditSheet(int index) async {
    final sheetToEdit = characterSheets[index];
    if (sheetToEdit is CharacterSheetDeD) {
      final updatedSheet = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewCharacterSheetScreen(sheet: sheetToEdit),
        ),
      );
      if (updatedSheet != null && updatedSheet is CharacterSheetDeD) {
        setState(() { characterSheets[index] = updatedSheet; });
        _saveCharacterSheets();
      }
    } else if (sheetToEdit is CharacterSheetGaia) {
      final updatedSheet = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewCharacterSheetGaiaScreen(sheet: sheetToEdit),
        ),
      );
      if (updatedSheet != null && updatedSheet is CharacterSheetGaia) {
        setState(() { characterSheets[index] = updatedSheet; });
        _saveCharacterSheets();
      }
    }
  }

  void _navigateToSheetDetails(CharacterSheetUniveresal sheet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterSheetDetailsScreen(sheet: sheet),
      ),
    );
  }

  void _deleteSheet(int index) {
    setState(() { characterSheets.removeAt(index); });
    _saveCharacterSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Fichas de RPG')),
      body: characterSheets.isEmpty
          ? const Center(child: Text("Nenhuma ficha encontrada."))
          : ListView.builder(
              itemCount: characterSheets.length,
              itemBuilder: (context, index) {
                final cs = characterSheets[index];
                String subtitle = "Nível ${cs.nivel}";
                if (cs is CharacterSheetDeD) {
                  subtitle = "${cs.classe} - Nível ${cs.nivel}";
                } else if (cs is CharacterSheetGaia) {
                  subtitle = "Legado: ${cs.legado} - Nível ${cs.nivel}";
                }
                return Card(
                  child: ListTile(
                    title: Text(cs.nome),
                    subtitle: Text(subtitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility, color: Colors.blue),
                          onPressed: () => _navigateToSheetDetails(cs),
                          tooltip: "Visualizar",
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _navigateToEditSheet(index),
                          tooltip: "Editar",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSheet(index),
                          tooltip: "Excluir",
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewSheet,
        tooltip: "Nova Ficha",
        child: const Icon(Icons.add),
      ),
    );
  }
}