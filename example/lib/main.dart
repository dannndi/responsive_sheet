import 'package:example_responsive_sheet/widget/bottom_sheet_example_four.dart';
import 'package:example_responsive_sheet/widget/bottom_sheet_example_one.dart';
import 'package:example_responsive_sheet/widget/bottom_sheet_example_three.dart';
import 'package:example_responsive_sheet/widget/bottom_sheet_example_two.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sheet/responsive_sheet.dart';

import 'extensions/build_context_ext.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Responsive Sheet",
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            ElevatedButton(
              child: Text("Show Default Responsive BottomSheet"),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  builder: (context, type) => BottomSheetExampleOne(
                    title: "Show Default Responsive BottomSheet",
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Show Responsive BottomSheet Side Only"),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  typeBuilder: (_) => ResponsiveSheetType.side,
                  builder: (context, type) => BottomSheetExampleOne(
                    title: "Show Responsive BottomSheet Side Only",
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Show Responsive BottomSheet Dialog Only"),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  typeBuilder: (_) => ResponsiveSheetType.dialog,
                  builder: (context, type) => SizedBox(
                    width: 670,
                    child: BottomSheetExampleOne(
                      title: "Show Responsive BottomSheet Dialog Only",
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Show Responsive BottomSheet Side with Fixed Size"),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  typeBuilder: (_) => ResponsiveSheetType.side,
                  builder: (context, type) => SizedBox(
                    width: 300,
                    child: BottomSheetExampleOne(
                      title: "Show Responsive BottomSheet Side with Fixed Size",
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Show Responsive BottomSheet Side with Ratio Size"),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  typeBuilder: (_) => ResponsiveSheetType.side,
                  builder: (context, type) => SizedBox(
                    width: context.responsiveValues(
                      desktop: MediaQuery.sizeOf(context).width * 0.4,
                      tablet: MediaQuery.sizeOf(context).width * 0.6,
                      mobile: MediaQuery.sizeOf(context).width * 0.8,
                    ),
                    child: BottomSheetExampleOne(
                      title: "Show Responsive BottomSheet Side with Ratio Size",
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Show Responsive BottomSheet with Custom Style"),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  styleBuilder: (context, type) {
                    return context.responsiveValues(
                      desktop: ResponsiveSheetStyle(
                        margin: 300,
                        borderRadius: BorderRadius.circular(72),
                      ),
                      tablet: ResponsiveSheetStyle(
                        margin: 100,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      mobile: ResponsiveSheetStyle(
                        margin: 90,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    );
                  },
                  builder: (context, type) => BottomSheetExampleOne(
                    title: "Show Responsive BottomSheet with Custom Style",
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("Show Responsive BottomSheet with Result"),
              onPressed: () async {
                final result = await showResponsiveBottomSheet(
                  context,
                  styleBuilder: (context, type) {
                    return context.responsiveValues(
                      desktop: ResponsiveSheetStyle(
                        margin: 300,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      tablet: ResponsiveSheetStyle(
                        margin: 100,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      mobile: ResponsiveSheetStyle(
                        margin: 90,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  },
                  builder: (context, type) =>
                      BottomSheetExampleOne(title: "Pick A Color"),
                );

                if (context.mounted && result != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Result : $result")));
                }
              },
            ),
            ElevatedButton(
              child: Text(
                "Show Responsive BottomSheet with Nested BottomSheet",
              ),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  builder: (context, type) => BottomSheetExampleThree(),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Show Responsive BottomSheet with auto preserved state",
              ),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  builder: (context, type) => BottomSheetExampleTwo(),
                );
              },
            ),
            ElevatedButton(
              child: Text(
                "Show Responsive BottomSheet with Custom Widget",
              ),
              onPressed: () {
                showResponsiveBottomSheet(
                  context,
                  builder: (context, type) => BottomSheetExampleFour(
                    title: "Show Responsive BottomSheet with Custom Widget",
                    type: type,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
