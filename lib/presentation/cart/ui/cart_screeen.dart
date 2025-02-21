import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/cart_model/cart_model.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          'My Cart',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.isLoading!) {
            context.read<CartBloc>().add(FetchCartEvent());
            return const LoadingListPage();
          } else if (state.items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CustomImageView(
                    width: 200.h,
                    height: 200.v,
                    fit: BoxFit.fill,
                    imagePath: ImageConstant.emptyCart,
                  ),
                ),
                SizedBox(height: 12.v),
                Text(
                  'Empty Cart',
                  style: textTheme.titleLarge!.copyWith(fontSize: 20.fSize),
                )
              ],
            );
          }
          return ListView.builder(
            itemCount: state.items.length,
            padding: EdgeInsets.only(
                left: 20.h, top: 20.v, right: 20.h, bottom: 100.v),
            itemBuilder: (context, index) =>
                _buildCartItem(state.items[index], context),
          );
        },
      ),
      bottomSheet: BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Visibility(
            visible: state.items.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.v),
              child: Row(
                children: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return Checkbox(
                        activeColor: AppColor.primary,
                        value: state.items.every((item) => item.isSelected),
                        onChanged: (value) {
                          if (state.items.every((item) => item.isSelected)) {
                            for (var item in state.items) {
                              context
                                  .read<CartBloc>()
                                  .add(ToggleSelection(item.id));
                            }
                          } else {
                            for (var item in state.items) {
                              if (item.isSelected == false) {
                                context
                                    .read<CartBloc>()
                                    .add(ToggleSelection(item.id));
                              }
                            }
                          }
                        },
                      );
                    },
                  ),
                  Text(
                    'Select All',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(width: 15.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total',
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        '₹${state.totalPrice.toStringAsFixed(2)}',
                        style: textTheme.titleMedium,
                      )
                    ],
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                      width: 160.h,
                      leftIcon: CustomImageView(
                        imagePath: ImageConstant.checkOut,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.orderSummary);
                        // List<CartModel> selectedItems = state.items
                        //     .where((item) => item.isSelected)
                        //     .toList();
                        // if (selectedItems.isEmpty) {
                        //   context
                        //       .showSnackBar('No items selected for checkout.');
                        // } else {
                        //   print('length=>${selectedItems.length}');
                        //   context
                        //       .read<OrderRepository>()
                        //       .crateOrder(selectedItems);
                        //   Navigator.of(context)
                        //       .pushNamed(AppRoutes.checkOutScreen);
                        // }
                      },
                      text: 'Check Out'),
                  SizedBox(width: 3.v),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell _buildCartItem(CartModel item, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.productDetailScreen, arguments: item.id);
      },
      child: SizedBox(
        width: SizeUtils.width,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.v),
          child: Row(
            children: [
              Stack(
                children: [
                  CustomImageView(
                    width: 135.h,
                    height: 135.v,
                    fit: BoxFit.fill,
                    radius: BorderRadius.only(
                        topLeft: Radius.circular(12.h),
                        bottomLeft: Radius.circular(12.h)),
                    imagePath: item.url,
                  ),
                  Checkbox(
                    activeColor: AppColor.primary,
                    value: item.isSelected,
                    onChanged: (value) {
                      context.read<CartBloc>().add(ToggleSelection(item.id));
                    },
                  )
                ],
              ),
              SizedBox(width: 5.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.bodySmall,
                    ),
                    SizedBox(height: 8.v),
                    Row(
                      children: [
                        Text(
                          '₹${item.price}',
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(width: 15.h),
                        // Text(
                        //   '₹${item.}',
                        //   style: textTheme.titleMedium,
                        // ),
                      ],
                    ),
                    SizedBox(height: 12.v),
                    Row(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(DecreaseQuantity(item.id));
                              },
                              child: Container(
                                width: 24.h,
                                height: 24.v,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.h),
                                    border: Border.all(color: Colors.grey)),
                                child: const Text('-'),
                              ),
                            ),
                            SizedBox(width: 4.v),
                            Text(item.quantity.toString()),
                            SizedBox(width: 4.v),
                            InkWell(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(IncreaseQuantity(item.id));
                              },
                              child: Container(
                                width: 24.h,
                                height: 24.v,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.h),
                                    border: Border.all(color: Colors.grey)),
                                child: const Text('+'),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            context.read<CartBloc>().add(RemoveItem(item.id));
                          },
                          child: Text(
                            'Remove',
                            style: textTheme.bodySmall!
                                .copyWith(color: AppColor.redColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
