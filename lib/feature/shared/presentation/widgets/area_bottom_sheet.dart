// area_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_event.dart';
import 'package:mae_ban/feature/shared/data/models/area_model.dart';

class AreaBottomSheet extends StatelessWidget {
  final List<Area> areas;

  AreaBottomSheet(
      {required this.areas, required TextEditingController areaController});

  @override
  Widget build(BuildContext context) {
    final selectedArea =
        context.select((SelectionBloc bloc) => bloc.state.selectedArea);
    return ListView.builder(
      itemCount: areas.length,
      itemBuilder: (context, index) {
        final area = areas[index];
        final isSelected = selectedArea != null && selectedArea == area;
        return ListTile(
          title: Text(area.area),
          trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
          onTap: () {
            context.read<SelectionBloc>().add(SelectArea(area));
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }
}
