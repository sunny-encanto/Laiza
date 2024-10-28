import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seller_info_event.dart';
part 'seller_info_state.dart';

class SellerInfoBloc extends Bloc<SellerInfoEvent, SellerInfoState> {
  SellerInfoBloc() : super(SellerInfoInitial()) {
    on<SellerInfoEvent>((event, emit) {});
  }
}
