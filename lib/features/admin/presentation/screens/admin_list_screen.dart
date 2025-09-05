import 'package:flutter/material.dart';

class AdminListScreen extends StatelessWidget {
  const AdminListScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (BuildContext context, int i) => ListTile(
          title: Text('$title Item ${i + 1}'),
          subtitle: const Text('Details...'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

