import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:laiza/widgets/custom_drop_down.dart';

class UploadReelScreen extends StatelessWidget {
  const UploadReelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UploadReelBloc, UploadReelState>(
                buildWhen: (previous, current) =>
                    current is UploadReelCoverPhotoSelectedSate,
                builder: (context, state) {
                  if (state is UploadReelCoverPhotoSelectedSate) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          onTap: () {},
                          height: 470.v,
                          width: SizeUtils.width,
                          fit: BoxFit.fill,
                          radius: BorderRadius.only(
                              bottomRight: Radius.circular(12.h),
                              bottomLeft: Radius.circular(12.h)),
                          imagePath: state.imagePath,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(10.h),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 30.h,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 20.v),
              InkWell(
                onTap: () {
                  context.read<UploadReelBloc>().add(AddCoverPhotoEvent());
                },
                child: Row(
                  children: [
                    Container(
                      height: 92.h,
                      width: 92.h,
                      padding: EdgeInsets.all(30.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.h),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: CustomImageView(
                        height: 32.h,
                        width: 32.h,
                        imagePath: ImageConstant.uploadIcon,
                      ),
                    ),
                    SizedBox(width: 32.h),
                    Text(
                      'Choose Cover Photo',
                      style: textTheme.titleLarge!.copyWith(fontSize: 16.fSize),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.v),
              Text(
                'Add a Title',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              CustomTextFormField(
                hintText: 'Eg. Summer Collection Sneak Peek',
              ),
              SizedBox(height: 20.v),
              Text(
                'Description',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              CustomTextFormField(
                maxLines: 12,
                hintText:
                    "A brief description of the reel's content, products featured, or promotional message.",
              ),
              SizedBox(height: 20.v),
              Text(
                'Select Category',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              CustomDropDown(
                hintText: "Fashion, beauty, electronics",
                items: [SelectionPopupModel(title: 'Fashion')],
              ),
              SizedBox(height: 20.v),
              Text(
                'Product link',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              BlocBuilder<UploadReelBloc, UploadReelState>(
                buildWhen: (previous, current) => current is UploadReelInitial,
                builder: (context, state) {
                  if (state is UploadReelInitial) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.controllers.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 8.v),
                        child: CustomTextFormField(
                          controller: state.controllers[index],
                          hintText: 'Product ${index + 1}',
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 8.v),
              CustomOutlineButton(
                buttonStyle: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    elevation: 0,
                    backgroundColor: Colors.white),
                text: 'Add More',
                onPressed: () {
                  context.read<UploadReelBloc>().add(AddMoreProductLinkEvent());
                },
              ),
              SizedBox(height: 88.v),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: BlocBuilder<UploadReelBloc, UploadReelState>(
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is UploadReelLoadingSate,
              text: 'Upload',
              onPressed: () {
                context
                    .read<UploadReelBloc>()
                    .add(UploadReelSubmitRequestEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
