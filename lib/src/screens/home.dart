import 'package:flutter/material.dart';
import 'package:puroject1/src/screens/mise.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '甘歩',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildSection(String title, List<String> stores, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ...stores.map(
            (store) => Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: Colors.grey[300],
              child: ListTile(
                title: Text(store),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MiseScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('甘歩'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSection('おすすめ洋菓子店', ['お店 1', 'お店 2'], context),
            buildSection('おすすめ和菓子店', ['お店 1', 'お店 2'], context),
          ],
        ),
      ),
    );
  }
}
