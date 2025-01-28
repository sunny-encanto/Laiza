part of 'influencer_orders_bloc.dart';

sealed class InfluencerOrdersEvent extends Equatable {
  const InfluencerOrdersEvent();

  @override
  List<Object?> get props => [];
}

class FetchInfluencerOrdersEvent extends InfluencerOrdersEvent {}
