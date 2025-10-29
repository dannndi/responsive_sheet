import 'package:flutter/material.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_utils.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_layout.dart';

class ResponsiveSheetRoute<T> extends PopupRoute<T> {
  ResponsiveSheetRoute({
    required this.builder,
    this.typeBuilder,
    this.styleBuilder,
    this.barrierDismissible = true,
    this.barrierColor = Colors.black54,
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  /// The builder function that provides the content widget for the sheet.
  final ResponsiveSheetBuilder builder;

  /// Determines which layout type (sheet, dialog, or side sheet) to render.
  /// If null, defaults to [ResponsiveSheetUtils.defaultType].
  final ResponsiveSheetTypeBuilder? typeBuilder;

  /// Optional style configuration for customizing margins, radius, etc.
  final ResponsiveSheetStyleBuilder? styleBuilder;

  /// Whether the route can be dismissed by tapping outside the sheet.
  @override
  final bool barrierDismissible;

  /// The background color of the barrier behind the sheet.
  @override
  final Color barrierColor;

  /// The semantics label for accessibility when dismissing the sheet.
  @override
  final String? barrierLabel = 'Dismiss';

  /// Duration of the entrance and exit animation.
  @override
  final Duration transitionDuration;

  /// Makes this route non-opaque so the background remains visible.
  @override
  bool get opaque => false;

  /// Controls how the sheet appears and disappears with animation.
  ///
  /// Each sheet type defines a unique initial offset,
  /// provided by [ResponsiveSheetType.initialOffset].
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final type =
        typeBuilder?.call(context) ?? ResponsiveSheetUtils.defaultType(context);

    final offsetTween = Tween<Offset>(
      begin: type.initialOffset,
      end: Offset.zero,
    );

    return SlideTransition(
      position: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ).drive(offsetTween),
      child: child,
    );
  }

  /// Creates an animation controller suitable for bottom sheets.
  ///
  /// This controller allows the sheet to be draggable and interactive.
  late final AnimationController _animationController =
      BottomSheet.createAnimationController(
        navigator!,
        sheetAnimationStyle: AnimationStyle(
          duration: transitionDuration,
          reverseDuration: transitionDuration,
        ),
      );

  @override
  AnimationController createAnimationController() => _animationController;

  /// Builds the main page content of the route, wrapped in a
  /// [ResponsiveSheetLayout] to handle adaptive presentation.
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return ResponsiveSheetLayout(
      animationController: _animationController,
      typeBuilder: typeBuilder,
      builder: builder,
      styleBuilder: styleBuilder,
    );
  }
}
