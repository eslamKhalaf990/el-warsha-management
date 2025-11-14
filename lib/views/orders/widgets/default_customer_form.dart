// import 'package:flutter/material.dart';
// import 'package:warsha_app/utils/const_values.dart';
//
//
// class DefaultCustomerForm extends StatelessWidget {
//   const DefaultCustomerForm(
//       {super.key,
//       required this.title,
//       required this.icon,
//       required this.controller,
//       this.onChange});
//   final String title;
//   final TextEditingController controller;
//   final Function(String)? onChange;
//   final IconData? icon;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       onChanged: onChange,
//       cursorColor: Theme.of(context)
//           .colorScheme
//           .tertiary
//           .withAlpha(Constants.OPACITY_05),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Theme.of(context).colorScheme.surfaceTint,
//         enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.transparent,
//             ),
//             borderRadius: Constants.BORDER_RADIUS_15),
//         errorStyle: TextStyle(color: Colors.red.shade300),
//         prefixIcon: icon != null
//             ? Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Icon(
//                   icon,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//               )
//             : null,
//         border: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.transparent),
//             borderRadius: Constants.BORDER_RADIUS_15),
//         focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Colors.transparent,
//             ),
//             borderRadius: Constants.BORDER_RADIUS_15),
//         labelText: title,
//         labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
//       ),
//     );
//   }
// }
