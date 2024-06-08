import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/shared/data/models/service_type_model.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/selecttion/selection_event.dart';

class ServiceTypeBottomSheet extends StatefulWidget {
  final List<ServiceTypeModel> serviceTypes;

  ServiceTypeBottomSheet({
    required this.serviceTypes,
  });

  @override
  _ServiceTypeBottomSheetState createState() => _ServiceTypeBottomSheetState();
}

class _ServiceTypeBottomSheetState extends State<ServiceTypeBottomSheet> {
  List<ServiceTypeModel> _selectedServiceTypes = [];

  @override
  void initState() {
    super.initState();
    final selectedState = context.read<SelectionBloc>().state;
    _selectedServiceTypes = List.from(selectedState.selectedServiceTypes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.serviceTypes.length,
            itemBuilder: (context, index) {
              final serviceType = widget.serviceTypes[index];
              final isSelected = _selectedServiceTypes.contains(serviceType);
              return CheckboxListTile(
                title: Text(serviceType.serviceType),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedServiceTypes.add(serviceType);
                    } else {
                      _selectedServiceTypes.remove(serviceType);
                    }
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context
                .read<SelectionBloc>()
                .add(SelectServiceTypes(_selectedServiceTypes));
            Navigator.pop(context); // Close the bottom sheet
          },
          child: Text('ຢືນຢັນ'),
        ),
      ],
    );
  }
}
