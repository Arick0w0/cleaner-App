import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/offer/domain/usecases/get_prices.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/price/price_event.dart';
import 'package:mae_ban/feature/offer/presentation/blocs/price/price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  final GetPrices getPrices;

  PriceBloc(this.getPrices) : super(PriceInitial()) {
    on<FetchPrices>(_onFetchPrices);
  }

  void _onFetchPrices(FetchPrices event, Emitter<PriceState> emit) async {
    emit(PriceLoading());
    try {
      final prices = await getPrices();
      emit(PriceLoaded(prices));
    } catch (e) {
      emit(PriceError('Failed to fetch prices'));
    }
  }
}
