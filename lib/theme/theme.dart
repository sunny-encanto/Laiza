import '../core/app_export.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarHeight: 48.h,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black)),
    textTheme: GoogleFonts.interTextTheme().copyWith(
        titleLarge: TextStyle(
            fontSize: 24.fSize,
            fontWeight: FontWeight.w500,
            color: AppColor.primary),
        titleMedium: TextStyle(
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            color: AppColor.primary),
        bodySmall:
            TextStyle(fontSize: 14.0.fSize, color: AppColor.secondaryTextColor),
        bodyMedium: TextStyle(
          fontSize: 12.0.fSize,
          color: AppColor.primary,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 12.0.fSize,
          color: AppColor.primary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
            fontSize: 14.fSize,
            fontWeight: FontWeight.w600,
            color: Colors.white)),
    useMaterial3: false,
  );
}
