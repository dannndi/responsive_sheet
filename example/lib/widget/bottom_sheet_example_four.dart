import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_sheet/responsive_sheet.dart';

class BottomSheetExampleFour extends StatelessWidget {
  const BottomSheetExampleFour({
    super.key,
    required this.title,
    required this.type,
  });

  final String title;
  final ResponsiveSheetType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (type == ResponsiveSheetType.side)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
          if (type == ResponsiveSheetType.sheet)
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(8),
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
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
          if (type == ResponsiveSheetType.dialog)
            Padding(
              padding: const EdgeInsets.all(12),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
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
