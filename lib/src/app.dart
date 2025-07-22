import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/map.dart';
import 'screens/profile/profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // Flutter公式サイトThemeを設定
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       debugShowCheckedModeBanner: false, // ここでリボンを非表示にします
      // NavigaionBarのClassを呼び出す
      home: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // 各画面のリスト
  static const _screens = [HomeScreen(), MapScreen(), ProfileScreen()];
  // 選択されている画面のインデックス
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: _screens[_selectedIndex],
      // 本題のNavigationBar
      bottomNavigationBar: NavigationBar(
        // タップされたタブのインデックスを設定（タブ毎に画面の切り替えをする）
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // 選択されているタブの色（公式サイトのまま黄色）
        indicatorColor: Colors.amber,
        // 選択されたタブの設定（設定しないと画面は切り替わってもタブの色は変わらないです）
        selectedIndex: _selectedIndex,
        // タブ自体の設定（必須項目のため、書かないとエラーになります）
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(icon: Icon(Icons.face), label: 'Profile'),
        ],
      ),
    );
  }
}