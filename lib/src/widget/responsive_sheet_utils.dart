import 'package:flutter/widgets.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_type.dart';
import 'package:responsive_sheet/src/widget/responsive_sheet_style.dart';

typedef ResponsiveSheetTypeBuilder =
    ResponsiveSheetType Function(BuildContext context);

typedef ResponsiveSheetStyleBuilder =
    ResponsiveSheetStyle Function(
      BuildContext context,
      ResponsiveSheetType type,
    );

extension ResponsiveSheetTypeExt on ResponsiveSheetType {
  T when<T>({required T side, required T dialog, required T sheet}) {
    switch (this) {
      case ResponsiveSheetType.side:
        return side;
      case ResponsiveSheetType.dialog:
        return dialog;
      case ResponsiveSheetType.sheet:
        return sheet;
    }
  }

  Alignment get alignment {
    switch (this) {
      case ResponsiveSheetType.side:
        return Alignment.centerRight;
      case ResponsiveSheetType.dialog:
        return Alignment.center;
      case ResponsiveSheetType.sheet:
        return Alignment.bottomCenter;
    }
  }

  Offset get initialOffset {
    switch (this) {
      case ResponsiveSheetType.side:
        return const Offset(1, 0);
      case ResponsiveSheetType.dialog:
        return const Offset(0, 0);
      case ResponsiveSheetType.sheet:
        return const Offset(0, 1);
    }
  }
}

class ResponsiveSheetUtils {
  ResponsiveSheetUtils._();

  static ResponsiveSheetType defaultType(BuildContext context) {
    const maxMobile = 600;
    const maxTablet = 1024;

    final width = MediaQuery.of(context).size.width;

    bool isMobileSize = width < maxMobile;
    bool isTabletSize = width >= maxMobile && width <= maxTablet;
    bool isDesktopSize = width > maxTablet;

    if (isDesktopSize) return ResponsiveSheetType.side;
    if (isTabletSize) return ResponsiveSheetType.dialog;
    if (isMobileSize) return ResponsiveSheetType.sheet;

    return ResponsiveSheetType.side;
  }
}
