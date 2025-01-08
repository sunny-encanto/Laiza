import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:laiza/widgets/custom_drop_down.dart';

import '../../../../data/blocs/category_bloc/category_bloc.dart';
import '../../../../data/models/category_model/Category.dart';

class UploadReelScreen extends StatelessWidget {
  final String mediaPath;

  UploadReelScreen({super.key, required this.mediaPath});

  SelectionPopupModel? selectedCategory;
  final tittleController = TextEditingController();
  final desController = TextEditingController();
  final hashTagController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String coverImage = '';

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UploadReelBloc, UploadReelState>(
                  buildWhen: (previous, current) =>
                      current is UploadReelCoverPhotoSelectedSate,
                  builder: (context, state) {
                    if (state is UploadReelCoverPhotoSelectedSate) {
                      coverImage = state.imagePath;
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
                        style:
                            textTheme.titleLarge!.copyWith(fontSize: 16.fSize),
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
                  controller: tittleController,
                  hintText: 'Eg. Summer Collection Sneak Peek',
                  validator: (String? value) {
                    return validateField(
                        value: value ?? '', title: 'product title');
                  },
                ),
                SizedBox(height: 20.v),
                Text(
                  'Description',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  maxLines: 12,
                  controller: desController,
                  hintText:
                      "A brief description of the reel's content, products featured, or promotional message.",
                  validator: (String? value) {
                    return validateField(
                        value: value ?? '', title: 'product description');
                  },
                ),
                SizedBox(height: 20.v),
                SizedBox(height: 20.v),
                Text(
                  'Hashtag',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  maxLines: 5,
                  controller: hashTagController,
                  hintText: "#Laiza",
                  validator: (String? value) {
                    return validateField(value: value ?? '', title: 'hashtag');
                  },
                ),
                SizedBox(height: 20.v),
                Text(
                  'Category',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                BlocProvider(
                  create: (context) =>
                      CategoryBloc(context.read<CategoryRepository>()),
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryInitial) {
                        context.read<CategoryBloc>().add(CategoryLoadEvent());
                        return const SizedBox.shrink();
                      } else if (state is CategoryLoading) {
                        return const SizedBox.shrink();
                      } else if (state is CategoryLoaded) {
                        return CustomDropDown(
                          value: selectedCategory,
                          hintText: 'Select Category',
                          items: state.category
                              .map((Category category) => SelectionPopupModel(
                                  value: category.id!.toInt(),
                                  title: category.categoryName ?? ''))
                              .toList(),
                          validator: (SelectionPopupModel? value) {
                            return validateField(
                                value: value?.title ?? '',
                                title: 'product category');
                          },
                          onChanged: (SelectionPopupModel? val) {
                            selectedCategory = val;
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.v),
                // Text(
                //   'Product link',
                //   style: textTheme.titleMedium,
                // ),
                // SizedBox(height: 8.v),
                // BlocBuilder<UploadReelBloc, UploadReelState>(
                //   buildWhen: (previous, current) =>
                //       current is UploadReelInitial,
                //   builder: (context, state) {
                //     if (state is UploadReelInitial) {
                //       return ListView.builder(
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: state.controllers.length,
                //         itemBuilder: (context, index) => Padding(
                //           padding: EdgeInsets.only(bottom: 8.v),
                //           child: CustomTextFormField(
                //             controller: state.controllers[index],
                //             hintText: 'Product ${index + 1}',
                //           ),
                //         ),
                //       );
                //     }
                //     return const SizedBox.shrink();
                //   },
                // ),
                // SizedBox(height: 8.v),
                // CustomOutlineButton(
                //   buttonStyle: OutlinedButton.styleFrom(
                //       side: const BorderSide(color: Colors.black),
                //       elevation: 0,
                //       backgroundColor: Colors.white),
                //   text: 'Add More',
                //   onPressed: () {
                //     context
                //         .read<UploadReelBloc>()
                //         .add(AddMoreProductLinkEvent());
                //   },
                // ),
                SizedBox(height: 88.v),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: BlocConsumer<UploadReelBloc, UploadReelState>(
          listener: (context, state) {
            if (state is UploadReelErrorState) {
              context.showSnackBar(state.message);
            } else if (state is UploadReelSuccessState) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is UploadReelLoadingSate,
              text: 'Upload',
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                } else {
                  if (coverImage.isEmpty) {
                    context.showSnackBar('Please select cover image');
                  } else {
                    context
                        .read<UploadReelBloc>()
                        .add(UploadReelSubmitRequestEvent(
                          reelPath: mediaPath,
                          reelTitle: tittleController.text,
                          productId: 2,
                          reelDes: desController.text,
                          categoryId: selectedCategory?.value ?? 0,
                          coverPath: coverImage,
                          hashTag: hashTagController.text,
                        ));
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
