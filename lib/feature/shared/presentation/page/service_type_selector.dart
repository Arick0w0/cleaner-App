import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_state.dart';
import 'package:mae_ban/feature/shared/presentation/widgets/service_type_bottom_sheet.dart';

class ServiceTypeSelectionField extends StatelessWidget {
  final TextEditingController serviceTypeController;
  final List<ServiceTypeModel> serviceTypes;

  ServiceTypeSelectionField(
      {required this.serviceTypeController, required this.serviceTypes});

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
              child: ServiceTypeBottomSheet(serviceTypes: serviceTypes),
            );
          },
        ).then((_) {
          final selectedServiceTypes = selectionBloc.state.selectedServiceTypes;
          if (selectedServiceTypes.isNotEmpty) {
            serviceTypeController.text =
                selectedServiceTypes.map((e) => e.serviceType).join(', ');
            // You can add any additional logic for service type selection here
          }
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
            // labelText: 'ກະລຸນາເລືອກປະເພດທໍາຄວາມສະອາດ',
            // border: OutlineInputBorder(),
            ),
        child: BlocBuilder<SelectionBloc, SelectionState>(
          builder: (context, selectionState) {
            String serviceTypeDropdownValue = serviceTypeController.text;
            if (selectionState.selectedServiceTypes.isNotEmpty) {
              serviceTypeDropdownValue = selectionState.selectedServiceTypes
                  .map((e) => e.serviceType)
                  .join(', ');
            }
            return Row(
              children: [
                Icon(Icons.cleaning_services_outlined,
                    color: MColors.secondary),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    serviceTypeDropdownValue.isEmpty
                        ? 'ກະລຸນາເລືອກປະເພດທໍາຄວາມສະອາດ'
                        : serviceTypeDropdownValue,
                    style: TextStyle(
                        color: serviceTypeDropdownValue.isEmpty
                            ? Colors.grey
                            : MColors.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
