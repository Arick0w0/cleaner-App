import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/shared/data/models/area_model.dart';

import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_state.dart';
import 'package:mae_ban/feature/shared/presentation/widgets/area_bottom_sheet.dart';

class AreaSelectionField extends StatelessWidget {
  final TextEditingController areaController;
  final List<Area> areas;

  const AreaSelectionField({
    super.key,
    required this.areaController,
    required this.areas,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final selectionBloc = BlocProvider.of<SelectionBloc>(context);
        if (selectionBloc.state.selectedProvince == null) {
          // Show snackbar if no province is selected
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('ກະລຸນາເລືອກແຂວງ'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BlocProvider.value(
                value: selectionBloc,
                child: AreaBottomSheet(
                  areas: areas,
                  areaController: areaController,
                ),
              );
            },
          ).then((_) {
            final selectedArea = selectionBloc.state.selectedArea;
            if (selectedArea != null) {
              areaController.text = selectedArea.area;
            }
          });
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: MTexts.district,
          border: OutlineInputBorder(),
        ),
        child: BlocBuilder<SelectionBloc, SelectionState>(
          builder: (context, selectionState) {
            String areaDropdownValue = areaController.text;
            if (selectionState.selectedArea != null) {
              areaDropdownValue = selectionState.selectedArea!.area;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.map, color: MColors.secondary),
                    const Gap(10),
                    Text(
                      areaDropdownValue.isEmpty
                          ? 'ກະລຸນາເລືອກເມືອງ'
                          : areaDropdownValue,
                      style: TextStyle(
                        color: areaDropdownValue.isEmpty
                            ? Colors.grey
                            : MColors.secondary,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_drop_down, color: MColors.secondary),
              ],
            );
          },
        ),
      ),
    );
  }
}
