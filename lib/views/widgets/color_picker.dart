import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemeColorPicker extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorSelected;

  const ThemeColorPicker({
    required this.initialColor,
    required this.onColorSelected,
    super.key,
  });

  @override
  State<ThemeColorPicker> createState() => _ThemeColorPickerState();
}

class _ThemeColorPickerState extends State<ThemeColorPicker> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.initialColor;
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Scegli un colore'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) => setState(() => currentColor = color),
            enableAlpha: false,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onColorSelected(currentColor);
              Navigator.of(context).pop();
            },
            child: const Text('Conferma'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pickColor(context),
      child: const Text('Scegli colore tema'),
    );
  }
}