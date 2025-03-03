import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/address_model/address_model.dart';
import 'package:laiza/data/models/common_model/common_model.dart';
import 'package:laiza/data/repositories/address_repository/address_repository.dart';
import 'package:laiza/presentation/address_screen/bloc/address_bloc.dart';
import 'package:laiza/widgets/custom_popup_menu_button.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: AppColor.offWhite,
        title: Text(
          'Delivery Address',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressInitial) {
              context.read<AddressBloc>().add(FetchAddressEvent());
            } else if (state is AddressLoading) {
              return const SizedBox.shrink();
            } else if (state is AddressError) {
              return Center(child: Text(state.message));
            } else if (state is AddressLoaded) {
              return Column(
                children: [
                  SizedBox(height: 29.v),
                  Column(
                    children: List.generate(
                        state.address.length,
                        (index) => Padding(
                              padding: EdgeInsets.only(bottom: 8.v),
                              child: buildAddressItem(
                                  state.address[index], context),
                            )),
                  ),
                  SizedBox(height: 26.v),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.addAddressScreen);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 24.h,
                          height: 24.v,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.h),
                              border: Border.all(color: Colors.black)),
                          child: const Text('+'),
                        ),
                        SizedBox(width: 12.h),
                        Text(
                          'Add new address',
                          style: textTheme.titleMedium,
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      // bottomSheet: Padding(
      //   padding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 16.h),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Text(
      //             'Total',
      //             style: textTheme.bodySmall,
      //           ),
      //           Text(
      //             '₹ 2,799',
      //             style: textTheme.titleMedium,
      //           )
      //         ],
      //       ),
      //       CustomElevatedButton(
      //           width: 160.h,
      //           leftIcon: CustomImageView(
      //             imagePath: ImageConstant.checkOut,
      //           ),
      //           onPressed: () {
      //             Navigator.of(context).pushNamed(AppRoutes.orderPlacedScreen);
      //           },
      //           text: 'Pay Now'),
      //     ],
      //   ),
      // ),
    );
  }

  Container buildAddressItem(Address address, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          border: Border.all(
              color: address.makeDefaultAddress == 0
                  ? Colors.grey
                  : Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 80.h),
                padding: EdgeInsets.all(2.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12.h)),
                child: Text(
                  address.addressType ?? '',
                  style: textTheme.titleSmall!.copyWith(color: Colors.black),
                ),
              ),
              CustomPopupMenuButton(
                  menuItems: const [
                    PopupMenuItem(
                      value: 1,
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text('Delete'),
                    ),
                  ],
                  onItemSelected: (val) async {
                    if (val == 1) {
                      Navigator.of(context).pushNamed(
                          AppRoutes.addAddressScreen,
                          arguments: address);
                    } else {
                      CommonModel model = await context
                          .read<AddressRepository>()
                          .deleteAddress(address.id ?? 0);
                      context.showSnackBar(model.message ?? "");
                      context.read<AddressBloc>().add(FetchAddressEvent());
                    }
                  })
            ],
          ),
          SizedBox(height: 15.v),
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.shippingIcon,
              ),
              SizedBox(width: 8.h),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping Address',
                      style: textTheme.titleMedium,
                    ),
                    // CustomImageView(
                    //   onTap: () {
                    //     Navigator.of(context).pushNamed(
                    //         AppRoutes.addAddressScreen,
                    //         arguments: address);
                    //   },
                    //   imagePath: ImageConstant.editIcon,
                    // )
                    // SizedBox(height: 4.v),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15.v),
          SizedBox(
            width: SizeUtils.width - 100.h,
            child: Text(
              '${address.houseNo}, ${address.areaStreet},${address.landmark},${address.city},${address.state},${address.pinCode}',
              style: textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
