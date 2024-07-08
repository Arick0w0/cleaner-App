import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/offer/domain/usecases/generate_bill.dart';

import 'billing_state.dart';

// Billing Cubit
class BillingCubit extends Cubit<BillingState> {
  final GenerateBill generateBill;

  BillingCubit(this.generateBill) : super(BillingInitial());

  Future<void> executeGenerateBill(BillingParams params) async {
    emit(BillingLoading());
    try {
      final result = await generateBill.execute(params);
      final billCode = result['data']['your_bill_code'];
      print('Billing Success with bill code: $billCode'); // Debug log
      emit(BillingSuccess(billCode: billCode));
    } catch (e) {
      print('Billing Failure with error: $e'); // Debug log
      emit(BillingFailure(error: e.toString()));
    }
  }
}
