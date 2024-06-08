import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_bloc.dart';
import 'package:mae_ban/feature/shared/presentation/bloc/getdata/data_state.dart';
import 'package:mae_ban/feature/shared/presentation/page/province_selector.dart';
import 'package:mae_ban/core/constants/size.dart';

class ProvinceSelectorView extends StatelessWidget {
  final TextEditingController provinceController;
  const ProvinceSelectorView({
    super.key,
    required this.provinceController,
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
              ProvinceSelectionField(
                  provinces: state.provinces,
                  provinceController: provinceController),
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
