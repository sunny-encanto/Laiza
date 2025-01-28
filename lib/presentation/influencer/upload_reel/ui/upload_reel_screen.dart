import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/models/selectionPopupModel/selection_popup_model.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/presentation/user/video_player/ui/video_player.dart';
import 'package:laiza/widgets/custom_drop_down.dart';

import '../../../../data/blocs/category_bloc/category_bloc.dart';
import '../../../../data/blocs/product_bloc/product_bloc.dart';
import '../../../../data/models/category_model/Category.dart';
import '../../../../data/models/reels_model/reel.dart';
import '../../../../widgets/custom_searchable_dropdown.dart';

class UploadReelScreen extends StatelessWidget {
  final String? mediaPath;
  final Reel? reel;

  UploadReelScreen({super.key, this.mediaPath, this.reel});

  SelectionPopupModel? selectedCategory;
  SelectionPopupModel? selectedProduct;
  final tittleController = TextEditingController();
  final desController = TextEditingController();
  final productController = TextEditingController();
  final hashTagController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String coverImage = '';
  String reelPath = '';

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    if (reel != null) {
      tittleController.text = reel?.reelTitle ?? '';
      desController.text = reel?.reelDescription ?? '';
      hashTagController.text = reel?.reelHashtag ?? '';
      coverImage = reel?.reelCoverPath ?? '';
    }
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
                      current is ReelSelectedState,
                  builder: (context, state) {
                    if (state is ReelSelectedState) {
                      reelPath = state.path;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayerFromFile(path: reelPath),

                          // CustomImageView(
                          //   onTap: () {},
                          //   height: 470.v,
                          //   width: SizeUtils.width,
                          //   fit: BoxFit.fill,
                          //   radius: BorderRadius.only(
                          //       bottomRight: Radius.circular(12.h),
                          //       bottomLeft: Radius.circular(12.h)),
                          //   imagePath: state.path,
                          // ),
                          // const PlayButton(isVisible: true)
                        ],
                      );
                    }

                    if (reelPath.isNotEmpty) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayerFromFile(
                            path: reelPath,
                          ),
                          // CustomImageView(
                          //   onTap: () {},
                          //   height: 470.v,
                          //   width: SizeUtils.width,
                          //   fit: BoxFit.fill,
                          //   radius: BorderRadius.only(
                          //       bottomRight: Radius.circular(12.h),
                          //       bottomLeft: Radius.circular(12.h)),
                          //   imagePath: coverImage,
                          // ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: 20.v),
                if (reel == null)
                  InkWell(
                    onTap: () {
                      context.read<UploadReelBloc>().add(AddReelEvent());
                    },
                    child: BlocBuilder<UploadReelBloc, UploadReelState>(
                      buildWhen: (previous, current) =>
                          current is UploadReelCoverPhotoSelectedSate,
                      builder: (context, state) {
                        return Row(
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
                                imagePath: ImageConstant.uploadReel,
                              ),
                            ),
                            SizedBox(width: 32.h),
                            Text(
                              'Add Your POP',
                              style: textTheme.titleLarge!
                                  .copyWith(fontSize: 16.fSize),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                SizedBox(height: 20.v),
                BlocBuilder<UploadReelBloc, UploadReelState>(
                  buildWhen: (previous, current) =>
                      current is UploadReelCoverPhotoSelectedSate,
                  builder: (context, state) {
                    if (state is UploadReelCoverPhotoSelectedSate) {
                      coverImage = state.imagePath;
                      return InkWell(
                        onTap: () {
                          context
                              .read<UploadReelBloc>()
                              .add(AddCoverPhotoEvent());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 92.h,
                              width: 92.h,
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.h),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: CustomImageView(
                                height: 32.h,
                                width: 32.h,
                                imagePath: coverImage,
                              ),
                            ),
                            SizedBox(width: 32.h),
                            Text(
                              'Choose Cover Photo',
                              style: textTheme.titleLarge!
                                  .copyWith(fontSize: 16.fSize),
                            )
                          ],
                        ),
                      );
                    }

                    if (coverImage.isNotEmpty) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<UploadReelBloc>()
                              .add(AddCoverPhotoEvent());
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 92.h,
                              width: 92.h,
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.h),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: CustomImageView(
                                height: 92.h,
                                width: 92.h,
                                imagePath: coverImage,
                              ),
                            ),
                            SizedBox(width: 32.h),
                            Text(
                              'Choose Cover Photo',
                              style: textTheme.titleLarge!
                                  .copyWith(fontSize: 16.fSize),
                            )
                          ],
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        context
                            .read<UploadReelBloc>()
                            .add(AddCoverPhotoEvent());
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
                            style: textTheme.titleLarge!
                                .copyWith(fontSize: 16.fSize),
                          )
                        ],
                      ),
                    );
                  },
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
                  'Product',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                BlocProvider(
                  create: (context) =>
                      ProductBloc(context.read<ProductRepository>()),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductInitial) {
                        context.read<ProductBloc>().add(LoadProducts());
                        return const SizedBox.shrink();
                      } else if (state is ProductLoading) {
                        return const SizedBox.shrink();
                      } else if (state is ProductLoaded) {
                        if (reel != null) {
                          Product product = state.products
                              .where((item) => item.id == reel?.productId)
                              .first;
                          selectedProduct = SelectionPopupModel(
                              title: product.productName, value: product.id);
                          productController.text = selectedProduct?.title ?? '';
                        }
                        return SearchableDropdown(
                          controller: productController,
                          items: state.products
                              .map((Product product) => SelectionPopupModel(
                                  value: product.id.toInt(),
                                  title: product.productName))
                              .toList(),
                          hint: 'Select Product',
                          onChanged: (value) {
                            selectedProduct = value;
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
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
                        if (reel != null) {
                          Category category = state.category
                              .where((item) => item.id == reel?.catId)
                              .first;
                          selectedCategory = SelectionPopupModel(
                              title: category.name ?? '', value: category.id);
                        }
                        return CustomDropDown(
                          value: selectedCategory,
                          hintText: 'Select Category',
                          items: state.category
                              .map((Category category) => SelectionPopupModel(
                                  value: category.id!.toInt(),
                                  title: category.name ?? ''))
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
              Navigator.of(context).pop();
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
                    if (reel != null) {
                      Reel newReel = reel!;
                      newReel.catId = selectedCategory?.value;
                      newReel.reelCoverPath = coverImage;
                      newReel.reelTitle = tittleController.text;
                      newReel.reelDescription = desController.text;
                      newReel.reelHashtag = hashTagController.text;
                      context
                          .read<UploadReelBloc>()
                          .add(UpdateReelRequestEvent(newReel));
                    } else {
                      context
                          .read<UploadReelBloc>()
                          .add(UploadReelSubmitRequestEvent(
                            reelPath: reelPath,
                            reelTitle: tittleController.text,
                            productId: selectedProduct?.value ?? 0,
                            reelDes: desController.text,
                            categoryId: selectedCategory?.value ?? 0,
                            coverPath: coverImage,
                            hashTag: hashTagController.text,
                          ));
                    }
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
