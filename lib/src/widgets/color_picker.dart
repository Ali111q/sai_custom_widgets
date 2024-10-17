// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'dart:io';
// import 'package:get/get.dart'; // for platform detection

// typedef ColorPickerBuilder = Widget Function(
//   BuildContext context,
//   Color selectedColor,
//   VoidCallback showPicker,
// );

// class ColorPickerButton extends StatefulWidget {
//   final Color initialColor;
//   final ValueChanged<Color> onColorChanged;

//   // Original constructor (unchanged)
//   const ColorPickerButton({
//     super.key,
//     required this.initialColor,
//     required this.onColorChanged,
//   });

//   // Builder constructor (new)
//   static Widget builder({
//     required Color initialColor,
//     required ValueChanged<Color> onColorChanged,
//     required ColorPickerBuilder builder,
//   }) {
//     return _ColorPickerBuilder(
//       initialColor: initialColor,
//       onColorChanged: onColorChanged,
//       builder: builder,
//     );
//   }

//   @override
//   _ColorPickerButtonState createState() => _ColorPickerButtonState();
// }

// class _ColorPickerButtonState extends State<ColorPickerButton> {
//   late Color selectedColor;

//   @override
//   void initState() {
//     super.initState();
//     selectedColor = widget.initialColor;
//   }

//   void _showColorPicker(BuildContext context) {
//     if (Platform.isIOS) {
//       _showCupertinoColorPicker(context);
//     } else {
//       _showMaterialColorPicker(context);
//     }
//   }

//   // Material Color Picker (Android)
//   void _showMaterialColorPicker(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Pick a color',
//             style: Theme.of(context).textTheme.labelLarge,
//           ),
//           content: SingleChildScrollView(
//             child: BlockPicker(
//               pickerColor: selectedColor,
//               onColorChanged: (Color color) {
//                 setState(() {
//                   selectedColor = color;
//                   widget.onColorChanged(selectedColor);
//                 });
//               },
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Done'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Cupertino Color Picker (iOS)
//   void _showCupertinoColorPicker(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoActionSheet(
//           actions: [
//             Container(
//               height: 200,
//               color: context.theme.colorScheme.surface,
//               child: CupertinoPicker(
//                 backgroundColor: context.theme.colorScheme.surface,
//                 itemExtent: 32.0,
//                 onSelectedItemChanged: (int index) {
//                   List<Color> colors = [
//                     Colors.red,
//                     Colors.green,
//                     Colors.blue,
//                     Colors.yellow,
//                   ];
//                   setState(() {
//                     selectedColor = colors[index];
//                     widget.onColorChanged(selectedColor);
//                   });
//                 },
//                 children: [
//                   Text(
//                     'Red',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Green',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Blue',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Yellow',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: context.theme.colorScheme.primary,
//               ),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showColorPicker(context),
//       child: Container(
//         height: 50,
//         width: 50,
//         decoration: BoxDecoration(
//           color: selectedColor,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Custom widget to handle the builder functionality
// class _ColorPickerBuilder extends StatefulWidget {
//   final Color initialColor;
//   final ValueChanged<Color> onColorChanged;
//   final ColorPickerBuilder builder;

//   const _ColorPickerBuilder({
//     required this.initialColor,
//     required this.onColorChanged,
//     required this.builder,
//   });

//   @override
//   __ColorPickerBuilderState createState() => __ColorPickerBuilderState();
// }

// class __ColorPickerBuilderState extends State<_ColorPickerBuilder> {
//   late Color selectedColor;

//   @override
//   void initState() {
//     super.initState();
//     selectedColor = widget.initialColor;
//   }

//   void _showColorPicker(BuildContext context) {
//     if (Platform.isIOS) {
//       _showCupertinoColorPicker(context);
//     } else {
//       _showMaterialColorPicker(context);
//     }
//   }

//   // Material Color Picker (Android)
//   void _showMaterialColorPicker(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Pick a color',
//             style: Theme.of(context).textTheme.labelLarge,
//           ),
//           content: SingleChildScrollView(
//             child: BlockPicker(
//               pickerColor: selectedColor,
//               onColorChanged: (Color color) {
//                 setState(() {
//                   selectedColor = color;
//                   widget.onColorChanged(selectedColor);
//                 });
//               },
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Done'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Cupertino Color Picker (iOS)
//   void _showCupertinoColorPicker(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoActionSheet(
//           actions: [
//             Container(
//               height: 200,
//               color: context.theme.colorScheme.surface,
//               child: CupertinoPicker(
//                 backgroundColor: context.theme.colorScheme.surface,
//                 itemExtent: 32.0,
//                 onSelectedItemChanged: (int index) {
//                   List<Color> colors = [
//                     Colors.red,
//                     Colors.green,
//                     Colors.blue,
//                     Colors.yellow,
//                   ];
//                   setState(() {
//                     selectedColor = colors[index];
//                     widget.onColorChanged(selectedColor);
//                   });
//                 },
//                 children: [
//                   Text(
//                     'Red',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Green',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Blue',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     'Yellow',
//                     style: TextStyle(
//                       color: context.theme.colorScheme.onSurface,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: context.theme.colorScheme.primary,
//               ),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(
//       context,
//       selectedColor,
//       () => _showColorPicker(context),
//     );
//   }
// }
