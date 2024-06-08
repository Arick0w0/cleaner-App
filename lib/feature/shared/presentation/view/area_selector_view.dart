import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_state.dart';
import 'package:mae_ban/feature/shared/presentation/page/area_selector.dart';

class AreaSelectorView extends StatelessWidget {
  final TextEditingController areaController;

  const AreaSelectorView({
    super.key,
    required this.areaController,
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
              AreaSelectionField(
                areaController: areaController,
                areas: state.areas ?? [],
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
