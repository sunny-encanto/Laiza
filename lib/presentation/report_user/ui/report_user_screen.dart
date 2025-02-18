import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:laiza/presentation/report_user/bloc/report_event.dart';
import 'package:laiza/presentation/report_user/bloc/report_user_state.dart';
import 'package:laiza/widgets/custom_drop_down.dart';

import '../bloc/report_bloc.dart';

class ReportUserScreen extends StatelessWidget {
  final String reportedUserId;

  ReportUserScreen({super.key, required this.reportedUserId});

  final _formKey = GlobalKey<FormState>();
  SelectionPopupModel? _selectedReason;
  final _commentsController = TextEditingController();

  final List<SelectionPopupModel> _reportReasons = <SelectionPopupModel>[
    SelectionPopupModel(title: 'Spam', value: 1),
    SelectionPopupModel(title: 'Abusive Content', value: 2),
    SelectionPopupModel(title: 'Fake Profile', value: 3),
    SelectionPopupModel(title: 'Other', value: 4),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Report User",
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(16.0), child: _buildFrom(textTheme)),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10.h),
        child: BlocProvider(
          create: (_) => ReportBloc(),
          child: BlocConsumer<ReportBloc, ReportState>(
            listener: (context, state) {
              if (state is ReportSuccess) {
                context.showSnackBar("Report submitted successfully!");
                Navigator.pop(context);
              } else if (state is ReportFailure) {
                context.showSnackBar(state.message);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is ReportLoading,
                text: 'Submit',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<ReportBloc>().add(
                          SubmitReport(
                            reportedUserId: reportedUserId,
                            reason: _selectedReason?.title ?? '',
                            comments: _commentsController.text.trim(),
                          ),
                        );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _buildFrom(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select a reason for reporting:",
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        CustomDropDown(
          value: _selectedReason,
          items: _reportReasons,
          hintText: 'Select Reason',
          onChanged: (val) {
            _selectedReason = val;
          },
          validator: (value) {
            if (value == null) {
              return "please select reason";
            } else {
              return null;
            }
          },
        ),
        const SizedBox(height: 16),
        Text(
          "Additional Comments (optional):",
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: _commentsController,
          hintText: "Enter your comments here...",
          maxLines: 8,
        ),
      ],
    );
  }
}
