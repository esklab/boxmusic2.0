import 'package:boxmusic2/ui/auth/signInUI.dart';
import 'package:boxmusic2/ui/homeUI.dart';
import 'package:boxmusic2/ui/libraryUI.dart';
import 'package:boxmusic2/ui/searchUI.dart';
import 'package:boxmusic2/ui/widgets/musicessai.dart';
import 'package:flutter/material.dart';

class MainUi extends StatefulWidget {
  const MainUi({Key? key}) : super(key: key);

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> with SingleTickerProviderStateMixin,WidgetsBindingObserver{
 int _pageIndex =0;
 bool _keyboardVisible = false;

 final List<Widget> _tabList =const [
   HomeUi(),
   SearchUi(),
   LibraryUi(),
   SignInUi(),
   // MusicPlayer(),
 ];

 @override
 void initState() {
   super.initState();
   WidgetsBinding.instance?.addObserver(this);
 }

 @override
 void dispose() {
   WidgetsBinding.instance?.removeObserver(this);
   super.dispose();
 }

 @override
 void didChangeMetrics() {
   final bottomInset = WidgetsBinding.instance?.window.viewInsets.bottom ?? 0;
   setState(() {
     _keyboardVisible = bottomInset > 0;
     if (!_keyboardVisible) {
       // Sauvegarder la valeur de _pageIndex lors de la fermeture du clavier
       _pageIndex = _pageIndex;
     }
   });
 }

 void _handleKeyboardVisibility() {
   final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
   if (isKeyboardVisible) {
     setState(() {
       _pageIndex = -1;
     });
   } else {
     setState(() {
       _pageIndex = 0;
     });
   }
 }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabList.elementAt(_pageIndex),
          if (!_keyboardVisible)
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: const Alignment(0.1,1.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(22),
                ),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.white ,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle: const TextStyle(fontSize: 12),
                  currentIndex: _pageIndex,
                  onTap: (int index){
                    setState(() {
                      _pageIndex=index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, size: 28,),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search, size: 28,),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.library_music, size: 28,),
                      label: "Library",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, size: 28,),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
