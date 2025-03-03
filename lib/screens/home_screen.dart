import 'package:flutter/material.dart';
import 'package:fichasrpg/screens/character_sheet_list_screen.dart';
import 'books_page.dart';
import 'package:fichasrpg/screens/ia_page.dart';


// Tela principal 
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() { _currentPage = index; });
        },
        children: const [
          CharacterSheetListScreen(), // Página de fichas
          BooksPage(), // Página de livros de RPG
          AICharacterSheetScreen(), // Página de criação com IA
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Fichas'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Livros'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'IA'),
        ],
      ),
    );
  }
}