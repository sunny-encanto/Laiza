// ignore_for_file: use_build_context_synchronously

import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/date_time_utils.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/models/live_stream_model.dart/live_stream_model.dart';

class ScheduleStreamScreen extends StatelessWidget {
  ScheduleStreamScreen({super.key});

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productLinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule a stream',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Schedule Your Live Stream',
                          style: textTheme.titleMedium),
                    ),
                    BlocBuilder<ScheduleStreamBloc, ScheduleStreamState>(
                      builder: (context, state) {
                        return CustomOutlineButton(
                            isLoading: state is ScheduleStreamLoading,
                            onPressed: () async {
                              LiveStreamModel liveStreamModel = LiveStreamModel(
                                liveId: PrefUtils.getId(),
                                userId: PrefUtils.getId(),
                                userName: PrefUtils.getUserName(),
                                userProfile: PrefUtils.getUserProfile(),
                                viewCount: 1,
                              );
                              context
                                  .read<ScheduleStreamBloc>()
                                  .add(GoLiveButtonTapEvent(liveStreamModel));
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.livePage, arguments: {
                                'live_id': PrefUtils.getId(),
                                'is_host': true,
                              });
                            },
                            width: 127.h,
                            height: 36.v,
                            text: 'Go Live');
                      },
                    )
                  ],
                ),
                SizedBox(height: 24.v),
                Text(
                  'Stream Title',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: _titleController,
                  hintText: 'Eg. Winter Fashion Essentials',
                  validator: (value) {
                    return validateField(value: value!, title: 'title');
                  },
                ),
                SizedBox(height: 20.v),
                Text(
                  'Description',
                  style: textTheme.titleMedium,
                ),
                CustomTextFormField(
                  controller: _descriptionController,
                  validator: (value) {
                    return validateField(value: value!, title: 'description');
                  },
                  maxLines: 12,
                  hintText:
                      'Provide a brief description of what the stream will be about, focusing on products or themes to be showcased.',
                ),
                SizedBox(height: 20.v),
                Text('Select Date', style: textTheme.titleMedium),
                SizedBox(height: 8.v),
                BlocBuilder<ScheduleStreamBloc, ScheduleStreamState>(
                  buildWhen: (previous, current) =>
                      current is DatePickerSelected,
                  builder: (context, state) {
                    if (state is DatePickerSelected) {
                      _dateController.text = state.selectedDate.format();
                    }
                    return CustomTextFormField(
                      controller: _dateController,
                      readOnly: true,
                      hintText: 'DD/MM/YEAR',
                      suffix: Padding(
                        padding: EdgeInsets.all(12.0.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.calenderIcon,
                        ),
                      ),
                      validator: (value) {
                        return validateField(value: value!, title: 'date');
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          context
                              .read<ScheduleStreamBloc>()
                              .add(SelectDateEvent(pickedDate));
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 20.v),
                Text('Select Time', style: textTheme.titleMedium),
                SizedBox(height: 8.v),
                BlocBuilder<ScheduleStreamBloc, ScheduleStreamState>(
                  buildWhen: (previous, current) =>
                      current is TimePickerSelected,
                  builder: (context, state) {
                    if (state is TimePickerSelected) {
                      _timeController.text = state.pickedTime.format(context);
                    }
                    return CustomTextFormField(
                      controller: _timeController,
                      readOnly: true,
                      hintText: 'HH/MM',
                      suffix: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.h, vertical: 18.v),
                        child: Text(
                          _timeController.text.contains('PM') ? 'PM' : 'AM',
                          style:
                              TextStyle(fontSize: 20.fSize, color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        return validateField(value: value!, title: 'time');
                      },
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          context
                              .read<ScheduleStreamBloc>()
                              .add(SelectTimeEvent(pickedTime));
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 20.v),
                // Text('Product link', style: textTheme.titleMedium),
                // SizedBox(height: 8.v),
                // CustomTextFormField(
                //   controller: _productLinkController,
                //   hintText: 'Paste the link of the product (optional)',
                // ),
                SizedBox(height: 100.v)
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: BlocConsumer<ScheduleStreamBloc, ScheduleStreamState>(
          listener: (context, state) {
            if (state is ScheduleStreamError) {
              context.showSnackBar(state.message);
            } else if (state is ScheduleStreamSuccess) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is ScheduleStreamLoading,
              text: 'Schedule Now',
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  FocusScope.of(context).unfocus();
                  context
                      .read<ScheduleStreamBloc>()
                      .add(ScheduleNowRequestEvent(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        date: _dateController.text,
                        time: _timeController.text,
                        productIds: [],
                      ));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
