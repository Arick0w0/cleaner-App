import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_event.dart';
import 'package:mae_ban/feature/shared/data/models/province_model.dart';

class ProvinceBottomSheet extends StatelessWidget {
  final List<Province> provinces;

  const ProvinceBottomSheet({
    super.key,
    required this.provinces,
  });

  @override
  Widget build(BuildContext context) {
    final selectedProvince =
        context.select((SelectionBloc bloc) => bloc.state.selectedProvince);
    return ListView.builder(
      itemCount: provinces.length,
      itemBuilder: (context, index) {
        final province = provinces[index];
        final isSelected =
            selectedProvince != null && selectedProvince == province;
        return ListTile(
          title: Text(province.name),
          trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
          onTap: () {
            context.read<SelectionBloc>().add(SelectProvince(province));
            Navigator.pop(context); // Close the bottom sheet
          },
        );
      },
    );
  }
}
