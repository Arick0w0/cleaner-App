import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/choose/choose_cubit.dart';
import 'package:mae_ban/feature/offer/presentation/cubits/choose/choose_state.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/cleaner_card.dart';

class ChoosePage extends StatefulWidget {
  final String postJobId;
  final String billCode;

  const ChoosePage({Key? key, required this.postJobId, required this.billCode})
      : super(key: key);

  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  @override
  void initState() {
    super.initState();
    context.read<ChooseCubit>().loadCleaners(widget.postJobId);
  }

  void _showConfirmationDialog(String hunterUsername) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              SizedBox(
                width: 50,
                child: Image.asset(
                  MTexts.warning,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(10),
              Text(
                'ທ່ານຕ້ອງການເລືອກແມ່ບ້ານຄົນນີ້ແທ້ບໍ່?',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: MColors.grey),
              ),
            ],
          ),
          content: Text(
            'ເລືອກແລ້ວຈະບໍສາມາຍົກເລີກໄດ້?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MColors.orange,
                ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: MColors.accent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'ຍົກເລີກ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: MColors.accent),
                    ),
                  ),
                ),
                const Gap(10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    context
                        .read<ChooseCubit>()
                        .chooseCleanerForJob(widget.billCode, hunterUsername);
                  },
                  child: Container(
                    width: 100,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: MColors.accent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'ຕົກລົງ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຜູ້ໃຫ້ບໍລິການ'),
      ),
      body: BlocListener<ChooseCubit, ChooseState>(
        listener: (context, state) {
          if (state is ChooseCleanerChosen) {
            context.go('/home-job-offer', extra: {
              'initialTabIndex': 1, // Initial tab is "Booking"
              'initialActivityTabIndex': 0,
            });
          } else if (state is ChooseError) {
            _showErrorSnackBar(state.message);
          }
        },
        child: RefreshIndicator(
          onRefresh: () =>
              context.read<ChooseCubit>().loadCleaners(widget.postJobId),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: BlocBuilder<ChooseCubit, ChooseState>(
              builder: (context, state) {
                if (state is ChooseLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChooseLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.cleaners.length,
                    itemBuilder: (context, index) {
                      final cleaner = state.cleaners[index];
                      return GestureDetector(
                        onTap: () =>
                            _showConfirmationDialog(cleaner['username']),
                        child: CleanerCard(
                          name:
                              '${cleaner['first_name']} ${cleaner['last_name']}',
                          imageProfile: cleaner['image_profile'] ?? '',
                          image: cleaner['cover_image'] ?? '',
                        ),
                      );
                    },
                  );
                } else if (state is ChooseNoData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo/gost.gif'),
                        Text(
                          'ບໍ່ມີຂໍ້ມູນ',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  );
                } else if (state is ChooseError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
