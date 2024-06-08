import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/shared/data/models/province_model.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_event.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_state.dart';
import 'package:mae_ban/feature/shared/presentation/widgets/province_bottom_sheet.dart';

class ProvinceSelectionField extends StatelessWidget {
  final List<Province> provinces;
  final TextEditingController provinceController;

  ProvinceSelectionField(
      {required this.provinces, required this.provinceController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final selectionBloc = BlocProvider.of<SelectionBloc>(context);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BlocProvider.value(
              value: selectionBloc,
              child: ProvinceBottomSheet(provinces: provinces),
            );
          },
        ).then((_) {
          // Fetch areas for selected province
          final selectedProvince = selectionBloc.state.selectedProvince;
          if (selectedProvince != null) {
            provinceController.text = selectedProvince.name;
            context
                .read<DataBloc>()
                .add(FetchAreasByProvince(selectedProvince.codeName));
          }
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
            // labelText: 'Select Province',
            // border: OutlineInputBorder(),
            ),
        child: BlocBuilder<SelectionBloc, SelectionState>(
          builder: (context, selectionState) {
            String provinceDropdownValue = provinceController.text;
            if (selectionState.selectedProvince != null) {
              provinceDropdownValue = selectionState.selectedProvince!.name;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_city, color: MColors.secondary),
                    SizedBox(width: 10),
                    Text(
                      provinceDropdownValue.isEmpty
                          ? 'ກະລຸນາເລືອກແຂວງ'
                          : provinceDropdownValue,
                      style: TextStyle(
                        color: provinceDropdownValue.isEmpty
                            ? Colors.grey
                            : MColors.secondary,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down, color: MColors.secondary),
              ],
            );
          },
        ),
      ),
    );
  }
}
