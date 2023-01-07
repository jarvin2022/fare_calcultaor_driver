import 'package:fair_calculator_driver/packages.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {Key? key,
      this.controller,
      this.hint,
      this.label,
      this.textInputType,
      this.prefixIcon,
      this.obscureState,
      this.enabled})
      : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String? hint;
  final String? label;
  final IconData? prefixIcon;
  final RxBool? obscureState;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureState?.value ?? false,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(prefixIcon),
          label: TextWidget(title: label),
          border: const OutlineInputBorder(),
          suffixIcon: obscureState == null
              ? null
              : IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    obscureState?.toggle();
                  },
                  icon: Obx(
                    () => Icon(obscureState!.isTrue
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )),
          enabled: enabled ?? true,
          focusColor: Colors.green[400]),
    );
  }
}
