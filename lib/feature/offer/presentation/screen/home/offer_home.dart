import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/widgets/search_bar.dart';
import 'package:mae_ban/feature/offer/domain/entities/service_type.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/service_type/service_type_bloc.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/advert_card.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/cleaner_card.dart';
import 'package:mae_ban/feature/offer/presentation/widgets/service_card.dart';
import 'package:mae_ban/feature/offer/data/models/dummy_data.dart';

class OfferHomePage extends StatefulWidget {
  const OfferHomePage({Key? key}) : super(key: key);

  @override
  State<OfferHomePage> createState() => _OfferHomePageState();
}

class _OfferHomePageState extends State<OfferHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ServiceTypeBloc>().add(FetchServiceTypes());
  }

  void _handleCardTap(BuildContext context, ServiceType service, int index) {
    if (index == 0) {
      context.go('/service-form', extra: {'service': service});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service will be coming soon!')),
      );
    }
  }

  Future<void> _refreshServices() async {
    await Future.delayed(
        Duration(milliseconds: 2000)); // เพิ่มความล่าช้า 2 วินาที
    context.read<ServiceTypeBloc>().add(FetchServiceTypes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MColors.primary,
        title: SearchBars(
          onTap: () {
            print("object");
          },
        ),
      ),
      body: RefreshIndicator(
        color: MColors.accent,
        onRefresh: _refreshServices,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ServiceTypeBloc, ServiceTypeState>(
            builder: (context, state) {
              if (state is ServiceTypeLoading) {
                return const Loader();
              } else if (state is ServiceTypeLoaded) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          AdvertCard(image: MTexts.ab01),
                          Gap(10),
                          AdvertCard(image: MTexts.ab01),
                          Gap(10),
                          AdvertCard(image: MTexts.ab01),
                        ],
                      ),
                    ),
                    const Gap(MSize.defaultSpace - 5),
                    Text(
                      MTexts.popularService,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(MSize.defaultSpace - 5),
                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.serviceTypes.length,
                        itemBuilder: (context, index) {
                          final service = state.serviceTypes[index];
                          return Row(
                            children: [
                              CardService(
                                image: service.imageType,
                                title: service.serviceType,
                                onTap: () =>
                                    _handleCardTap(context, service, index),
                              ),
                              if (index != state.serviceTypes.length - 1)
                                const Gap(16),
                            ],
                          );
                        },
                      ),
                    ),
                    const Gap(MSize.defaultSpace - 5),
                    Text(
                      'ແມ່ບ້ານຍອດນິຍົມ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(MSize.defaultSpace - 5),
                    SizedBox(
                      height: 270,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cleaners.length,
                        itemBuilder: (context, index) {
                          final cleaner = cleaners[index];
                          return Row(
                            children: [
                              CleanerCard(
                                name: cleaner.name,
                                imageProfile: cleaner.imageProfile,
                                image: cleaner.image,
                                // onTap: () {
                                //   print('object');
                                // },
                              ),
                              if (index != cleaners.length - 1)
                                const Gap(MSize.spaceBtwItems),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is ServiceTypeError) {
                return Center(
                  child: Text('Failed to load services: ${state.message}'),
                );
              } else {
                return const Center(
                  child: Text('No services available'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
