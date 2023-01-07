import 'package:fair_calculator_driver/packages.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      this.title,
      this.label,
      this.fontSized,
      this.fontWeight,
      this.color,
      this.textAlign,this.wordSpacing})
      : super(key: key);

  final String? title;
  final String? label;
  final double? fontSized;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double? wordSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'Unknown',
      style: GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: fontSized ?? 12,
        fontWeight: fontWeight ?? FontWeight.w400,
          letterSpacing: wordSpacing ?? 0
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
