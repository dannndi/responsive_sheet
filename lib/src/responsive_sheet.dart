import 'package:flutter/material.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_route.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_utils.dart';

/// Displays a **responsive bottom sheet, dialog, or side sheet**
/// depending on the current platform size or custom logic.
///
/// This method pushes a custom [ResponsiveSheetRoute] onto the
/// [Navigator] stack, allowing the UI to automatically adapt
/// between mobile (bottom sheet), tablet (dialog), or desktop (side sheet)
/// layouts — similar to how responsive modals behave on the web.
///
/// Example:
/// ```dart
/// await showResponsiveBottomSheet(
///   context,
///   builder: (context) => MyFormContent(),
///   typeBuilder: (context) => ResponsiveSheetUtils.defaultType(context),
/// );
/// ```
///
/// The sheet type is determined automatically by [typeBuilder],
/// or defaults to [ResponsiveSheetUtils.defaultType].
///
/// - On mobile: shows a draggable bottom sheet
/// - On tablet: shows a centered dialog
/// - On desktop: shows a side panel on the right
///
/// Parameters:
/// - [context]: The build context to show the sheet from.
/// - [builder]: The widget content builder for the sheet.
/// - [typeBuilder]: Optional callback that defines how to choose
///   between sheet, dialog, or side layout.
/// - [barrierDismissible]: Whether tapping outside dismisses the sheet.
/// - [barrierColor]: The background color behind the sheet.
/// - [transitionDuration]: Duration of the show/hide transition animation.
/// - [styleBuilder]: Optional style override for customizing margin,
///   border radius, or elevation for each layout type.
///
/// Returns:
/// A [Future] that completes when the sheet is dismissed, with an optional result.
Future<T?> showResponsiveBottomSheet<T>(
  BuildContext context, {
  required ResponsiveSheetBuilder builder,
  ResponsiveSheetTypeBuilder? typeBuilder,
  bool barrierDismissible = true,
  Color barrierColor = Colors.black54,
  Duration transitionDuration = const Duration(milliseconds: 300),
  ResponsiveSheetStyleBuilder? styleBuilder,
}) {
  return Navigator.of(context, rootNavigator: true).push<T>(
    ResponsiveSheetRoute(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      typeBuilder: typeBuilder,
      styleBuilder: styleBuilder,
      builder: builder,
    ),
  );
}
