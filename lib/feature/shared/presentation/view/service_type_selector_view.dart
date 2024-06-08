import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_state.dart';
import 'package:mae_ban/feature/shared/presentation/page/service_type_selector.dart';
import 'package:mae_ban/core/constants/size.dart';

class ServiceTypeSelectorView extends StatelessWidget {
  final TextEditingController serviceTypeController;

  const ServiceTypeSelectorView({
    super.key,
    required this.serviceTypeController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DataLoaded) {
          return Column(
            children: [
              ServiceTypeSelectionField(
                serviceTypes: state.serviceTypes,
                serviceTypeController: serviceTypeController,
              ),
              const Gap(MSize.spaceBtwItems),
            ],
          );
        } else if (state is DataError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}
