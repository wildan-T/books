import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({super.key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: const Text('Navigation Dialog Screen Wildan')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showColorDialog(context);
          },
          child: const Text("Change Color"),
        ),
      ),
    );
  }

  Future<void> _showColorDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Very Important Question'),
          content: const Text('Do you want to change the color?'),
          actions: [
            TextButton(
              onPressed: () {
                color = Colors.black38;
                Navigator.pop(context, Colors.cyan);
              },
              child: const Text('Black'),
            ),
            TextButton(
              onPressed: () {
                color = Colors.green.shade700;
                Navigator.pop(context, Colors.green);
              },
              child: const Text('Green'),
            ),
            TextButton(
              onPressed: () {
                color = Colors.blue.shade700;
                Navigator.pop(context, Colors.blue);
              },
              child: const Text('Blue'),
            ),
          ],
        );
      },
    );

    setState(() {});
  }
}
