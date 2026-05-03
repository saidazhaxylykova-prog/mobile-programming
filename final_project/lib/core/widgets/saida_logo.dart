import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class SaidaLogo extends StatelessWidget {
  final double fontSize;
  const SaidaLogo({super.key, this.fontSize = 36});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => AppColors.gradientPink.createShader(rect),
      child: Text(
        'SaidaGram',
        style: GoogleFonts.pacifico(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
