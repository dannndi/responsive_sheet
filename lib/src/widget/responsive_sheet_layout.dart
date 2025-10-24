import 'package:flutter/material.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_style.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_type.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_utils.dart';

/// A responsive container layout that adapts between
/// different sheet types: [side], [dialog], and [sheet].
///
/// This widget decides how to position and style the given [builder]
/// content depending on the current [ResponsiveSheetType].
///
/// It is used internally by [ResponsiveSheetRoute] to build
/// consistent layouts across platforms and screen sizes.
class ResponsiveSheetLayout extends StatefulWidget {
  const ResponsiveSheetLayout({
    super.key,
    this.animationController,
    required this.typeBuilder,
    required this.builder,
    this.styleBuilder,
  });

  /// Defines how to determine the current sheet type (side/dialog/sheet)
  /// based on the screen size or context.
  final ResponsiveSheetTypeBuilder? typeBuilder;

  /// The widget content to be displayed inside the sheet.
  final Widget Function(BuildContext) builder;

  /// Optional animation controller used only when displaying
  /// a bottom sheet (slide-up animation).
  final AnimationController? animationController;

  /// Optional style builder to customize margin and border radius
  /// for each [ResponsiveSheetType].
  final ResponsiveSheetStyleBuilder? styleBuilder;

  @override
  State<ResponsiveSheetLayout> createState() => _ResponsiveSheetLayoutState();
}

class _ResponsiveSheetLayoutState extends State<ResponsiveSheetLayout> {
  /// Ensures the content widget has a unique identity so that
  /// Flutter preserves its state even if the sheet type changes.
  ///
  /// Using [GlobalObjectKey] with [UniqueKey] guarantees that
  /// every sheet instance has an isolated state and layout.
  final contentKey = GlobalObjectKey(UniqueKey());

  @override
  Widget build(BuildContext context) {
    // The actual child widget built from the user's builder callback.
    final content = Material(
      key: contentKey,
      child: widget.builder(context),
    );

    // Screen size used for responsive constraints.
    final size = MediaQuery.sizeOf(context);

    // Determine which layout type should be used.
    final type = widget.typeBuilder?.call(context) ??
        ResponsiveSheetUtils.defaultType(context);

    switch (type) {
      // ───────────────────────── SIDE SHEET ─────────────────────────
      case ResponsiveSheetType.side:
        // Default style and customizable override.
        final defaultSideStyle = ResponsiveSheetStyle(margin: 96);
        final style =
            widget.styleBuilder?.call(context, type) ?? defaultSideStyle;

        // Only round the left side corners.
        final borderRadius = BorderRadius.only(
          topLeft: style.borderRadius?.topLeft ?? Radius.zero,
          bottomLeft: style.borderRadius?.bottomLeft ?? Radius.zero,
        );
        final margin = style.margin;

        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height,
                maxHeight: size.height,
                maxWidth: size.width - margin,
              ),
              child: content,
            ),
          ),
        );

      // ───────────────────────── DIALOG ─────────────────────────
      case ResponsiveSheetType.dialog:
        // Default style and customizable override.
        final defaultDialogStyle = ResponsiveSheetStyle(margin: 164);
        final style =
            widget.styleBuilder?.call(context, type) ?? defaultDialogStyle;

        final borderRadius = style.borderRadius;
        final margin = style.margin;

        return Center(
          child: Material(
            elevation: 12,
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width - margin,
                maxHeight: size.height - margin,
              ),
              child: content,
            ),
          ),
        );

      // ───────────────────────── BOTTOM SHEET ─────────────────────────
      case ResponsiveSheetType.sheet:
        // Default style and customizable override.
        final defaultSheetStyle = ResponsiveSheetStyle(margin: 212);
        final style =
            widget.styleBuilder?.call(context, type) ?? defaultSheetStyle;

        // Round top corners only.
        final borderRadius = BorderRadius.only(
          topLeft: style.borderRadius?.topLeft ?? Radius.zero,
          topRight: style.borderRadius?.topRight ?? Radius.zero,
        );
        final margin = style.margin;

        return Align(
          alignment: Alignment.bottomCenter,
          child: BottomSheet(
            enableDrag: true,
            animationController: widget.animationController,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            onClosing: () => Navigator.of(context).maybePop(),
            builder: (_) => SafeArea(
              top: false,
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: borderRadius,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: size.width,
                    maxWidth: size.width,
                    maxHeight: size.height - margin,
                  ),
                  child: content,
                ),
              ),
            ),
          ),
        );
    }
  }
}