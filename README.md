# 🧩 Responsive Sheet

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/default_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

A powerful and flexible **responsive bottom sheet** for Flutter that adapts automatically between **modal**, **side sheet**, and **dialog** modes — depending on the screen size.

It’s designed for apps that need a seamless experience across **mobile**, **tablet**, and **desktop** platforms.

---

## 🚀 Features

✅ Automatically adapts between **bottom sheet**, **side sheet**, or **dialog**  
✅ Fully customizable **style** (margin, radius, background)  
✅ Support for **state preservation**  
✅ **Nested** sheet support  
✅ **Return results** from sheet  
✅ Easy to integrate with a single function

---

## 📦 Installation

Add dependency to your `pubspec.yaml`:

```yaml
dependencies:
  responsive_sheet: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 🧱 Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:responsive_sheet/responsive_sheet.dart';

Future<void> showMySheet(BuildContext context) async {
  final result = await showResponsiveBottomSheet(
    context,
    builder: (context) => const MySheetContent(),
  );

  if (context.mounted && result != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Result: $result')),
    );
  }
}
```

---

## 🧩 Example Preview

Below are several use cases showing how `ResponsiveSheet` adapts automatically depending on device type and configuration.

### 🧱 Default Responsive Sheet

```dart
showResponsiveBottomSheet(
  context,
  builder: (context) => BottomSheetExampleOne(
    title: "Show Default Responsive BottomSheet",
  ),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/default_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### 🪟 Side Sheet Only

```dart
showResponsiveBottomSheet(
  context,
  typeBuilder: (_) => ResponsiveSheetType.side,
  builder: (context) => BottomSheetExampleOne(
    title: "Show Responsive BottomSheet Side Only",
  ),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/side_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### 🖼️ Dialog Only

```dart
showResponsiveBottomSheet(
  context,
  typeBuilder: (_) => ResponsiveSheetType.dialog,
  builder: (context) => SizedBox(
    width: 670,
    child: BottomSheetExampleOne(
      title: "Show Responsive BottomSheet Dialog Only",
    ),
  ),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/dialog_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### ⚙️ Fixed Size

```dart
showResponsiveBottomSheet(
  context,
  typeBuilder: (_) => ResponsiveSheetType.side,
  builder: (context) => SizedBox(
    width: 300,
    child: BottomSheetExampleOne(
      title: "Show Responsive BottomSheet Side with Fixed Size",
    ),
  ),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/fix_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### ⚙️ Fixed Ratio Size

```dart
showResponsiveBottomSheet(
  context,
  typeBuilder: (_) => ResponsiveSheetType.side,
  builder: (context) => SizedBox(
    width: MediaQuery.sizeOf(context).width * 0.4,
    child: BottomSheetExampleOne(
      title: "Show Responsive BottomSheet Side with Ratio Size",
    ),
  ),
);
```
you can also make size responsive to media query like this

```dart
showResponsiveBottomSheet(
  context,
  typeBuilder: (_) => ResponsiveSheetType.side,
  builder: (context) => SizedBox(
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
```
<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/ratio_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### ⚙️ Custom Style

```dart
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
  builder: (context) => BottomSheetExampleOne(
    title: "Show Responsive BottomSheet with Custom Style",
  ),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/custom_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">


### 🔁 With Result

```dart
final result = await showResponsiveBottomSheet(
  context,
  builder: (context) => BottomSheetExampleOne(
    title: "Pick a color",
  ),
);

if (context.mounted && result != null) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("Result: $result")));
}
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/result_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### 🧩 Nested Sheets

```dart
showResponsiveBottomSheet(
  context,
  builder: (context) => BottomSheetExampleThree(),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/nested_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

### ♻️ Preserve State Automatically

```dart
showResponsiveBottomSheet(
  context,
  builder: (context) => BottomSheetExampleTwo(),
);
```

<img src="https://raw.githubusercontent.com/dannndi/responsive_sheet/main/example/assets/example/auto_preserve_responsive_sheet.gif" width="720" alt="Responsive Sheet Example">

---

## 🧠 Responsive Logic

Internally, `ResponsiveSheet` will choose sheet type automatically:
- **Mobile:** Bottom sheet  
- **Tablet:** Side sheet  
- **Desktop:** Dialog  

You can override this by providing a custom `typeBuilder`.

---

## 🎨 Custom Styling with `styleBuilder`

The `styleBuilder` parameter allows you to define **custom visual styles** for each sheet type (`side`, `dialog`, or `sheet`).  
You can adjust the **margin**, **border radius**, and **elevation** dynamically.

Using the `BuildContext`, you can even manage **different styles per screen size** for more refined responsiveness.

---

## 🧰 Advanced Parameters

| Parameter | Type | Description |
|------------|------|-------------|
| `builder` | `Widget Function(BuildContext)` | Content builder for your sheet |
| `typeBuilder` | `ResponsiveSheetType Function(BuildContext)?` | Force a specific sheet type |
| `styleBuilder` | `ResponsiveSheetStyle Function(BuildContext, ResponsiveSheetType)?` | Customize margin, radius, color |
| `animationController` | `AnimationController?` | Provide custom animation controller |

---

## 📸 Example App

You can try all use cases by running the included example:

```bash
cd example
flutter run
```

---

## 🧑‍💻 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to open a [pull request](https://github.com/dannndi/responsive_sheet/pulls).

---