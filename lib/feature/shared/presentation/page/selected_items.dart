// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mae_ban/feature/shared/presentation/bloc/selection_bloc.dart';
// import 'package:mae_ban/feature/shared/presentation/bloc/selection_state.dart';

// class SelectedServiceTypes extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectionBloc, SelectionState>(
//       builder: (context, selectionState) {
//         if (selectionState.selectedServiceTypes.isNotEmpty) {
//           return Column(
//             children: selectionState.selectedServiceTypes
//                 .map((serviceType) => Text(serviceType.serviceType))
//                 .toList(),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }

// class SelectedProvince extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectionBloc, SelectionState>(
//       builder: (context, selectionState) {
//         if (selectionState.selectedProvince != null) {
//           return Text(
//               'Selected Province: ${selectionState.selectedProvince!.name}');
//         }
//         return Container();
//       },
//     );
//   }
// }

// class SelectedArea extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectionBloc, SelectionState>(
//       builder: (context, selectionState) {
//         if (selectionState.selectedArea != null) {
//           return Text('Selected Area: ${selectionState.selectedArea!.area}');
//         }
//         return Container();
//       },
//     );
//   }
// }
