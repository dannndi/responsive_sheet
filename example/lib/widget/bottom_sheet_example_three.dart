import 'package:example_responsive_sheet/widget/bottom_sheet_example_one.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sheet/responsive_sheet.dart';

class BottomSheetExampleThree extends StatefulWidget {
  const BottomSheetExampleThree({super.key});

  @override
  State<BottomSheetExampleThree> createState() =>
      _BottomSheetExampleThreeState();
}

class _BottomSheetExampleThreeState extends State<BottomSheetExampleThree> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Nested Bottom Sheet",
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          ElevatedButton(
            child: Text("Show another bottom sheet"),
            onPressed: () {
              showResponsiveBottomSheet(
                context,
                typeBuilder: (_) => ResponsiveSheetType.side,
                builder: (context) => SizedBox(
                  width: 670,
                  child: BottomSheetExampleOne(
                    title: "Show Responsive BottomSheet Side Only",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
