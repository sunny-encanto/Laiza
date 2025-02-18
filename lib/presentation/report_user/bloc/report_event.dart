import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitReport extends ReportEvent {
  final String reportedUserId;
  final String reason;
  final String comments;

  SubmitReport({
    required this.reportedUserId,
    required this.reason,
    required this.comments,
  });

  @override
  List<Object?> get props => [reportedUserId, reason, comments];
}
