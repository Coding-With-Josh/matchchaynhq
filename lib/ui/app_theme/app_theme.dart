import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchchayn/ui/constants/app_colors.dart';

class AppTheme {
  static ColorScheme appColorScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9700FF),
      onPrimary: Colors.white,
      secondary: Color(0xffB95AFB),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color(0xFF0A0A1A),
      onSurface: Colors.white,
    );
  }

  static TextTheme appTextTheme() {
    return TextTheme(
      //in use
      headlineSmall: GoogleFonts.spectral(
        fontWeight: FontWeight.w400,
        fontSize: 25,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 30,
      ),
      titleMedium: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w500,
        fontSize: 28,
      ),
      bodyLarge: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      labelLarge: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      bodyMedium: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      labelMedium: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w500,
        fontSize: 10,
      ),
      bodySmall: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),

      // other styles
      titleSmall: GoogleFonts.spaceGrotesk(),
      headlineLarge: GoogleFonts.spectral(),
      headlineMedium: GoogleFonts.spectral(),
      displayLarge: GoogleFonts.spectral(),
      displayMedium: GoogleFonts.spectral(),
      displaySmall: GoogleFonts.spectral(),

      // Spectral
      // Space Grotesk
    );
  }

  static BoxDecoration primaryGradientBox() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[AppColors.primaryColor, AppColors.secondaryColor],
        // tileMode: TileMode.mirror,
      ),
    );
  }

  static LinearGradient primaryLinearGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[AppColors.primaryColor, AppColors.secondaryColor],
      // tileMode: TileMode.mirror,
    );
  }

  static BoxDecoration surfaceGradientBox() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.backgroundDarkColor, // #9700FF
          AppColors.backgroundLightColor, // #B95AFB
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  static LinearGradient surfaceGradient() {
    return LinearGradient(
      colors: [
        AppColors.backgroundDarkColor, // #9700FF
        AppColors.backgroundLightColor, // #B95AFB
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static SliderThemeData sliderTheme() {
    return SliderThemeData(
      trackHeight: 2,
      //trackGap: 30,
      //padding: EdgeInsets.zero,
      //circular thumb shape, with 10 diamter
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
      activeTrackColor: AppColors.secondaryColor,
      inactiveTrackColor: AppColors.whiteColor,
      thumbColor: AppColors.whiteColor,
      valueIndicatorColor: AppColors.primaryColor,
      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
      // rangeTrackShape: RoundedRectRangeSliderTrackShape(),
      //  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
    );
  }
}
