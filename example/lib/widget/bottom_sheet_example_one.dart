import 'dart:math';

import 'package:flutter/material.dart';

class BottomSheetExampleOne extends StatelessWidget {
  const BottomSheetExampleOne({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Scrollable content
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: Colors.primaries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final color = Colors.primaries[index];
                return _ColorTile(color: color);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorTile extends StatefulWidget {
  const _ColorTile({required this.color});

  final Color color;

  @override
  State<_ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<_ColorTile> {
  String name = "";

  @override
  void initState() {
    name = _generateRandomPersonName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.pop(context, name);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.color.withValues(alpha: 0.4)),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            name,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

String _generateRandomPersonName() {
  final random = Random();
  const firstNames = [
    "Liam",
    "Emma",
    "Noah",
    "Olivia",
    "Ava",
    "Ethan",
    "Sophia",
    "Lucas",
    "Mia",
    "Isabella",
    "Amelia",
    "Elijah",
    "James",
    "Charlotte",
    "Benjamin",
    "Henry",
    "Mason",
    "Ella",
    "Harper",
    "Alexander",
    "Leo",
    "Chloe",
    "Aiden",
    "Grace",
    "Sebastian",
  ];

  const lastNames = [
    "Smith",
    "Johnson",
    "Williams",
    "Brown",
    "Jones",
    "Garcia",
    "Miller",
    "Davis",
    "Rodriguez",
    "Martinez",
    "Hernandez",
    "Lopez",
    "Gonzalez",
    "Wilson",
    "Anderson",
    "Thomas",
    "Taylor",
    "Moore",
    "Jackson",
    "Martin",
    "Lee",
    "Perez",
    "Thompson",
    "White",
  ];

  final first = firstNames[random.nextInt(firstNames.length)];
  final last = lastNames[(random.nextInt(lastNames.length))];
  return "$first $last";
}
