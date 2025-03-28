import 'package:fl_chart/fl_chart.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/influencer/earnings/cubit/earning_cubit.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../../../../data/models/influencer_order_model/influencer_order_model.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments & Earnings Page',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<EarningCubit, EarningState>(
            builder: (context, state) {
              if (state is EarningInitial) {
                context.read<EarningCubit>().fetchInfluencerProduct('2025');
                return const LoadingListPage();
              } else if (state is EarningLoading) {
                return const LoadingListPage();
              } else if (state is EarningError) {
                return Center(child: Text(state.message));
              } else if (state is EarningLoaded) {
                InfluencerOrderModel influencerOrderModel =
                    state.influencerOrder;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeUtils.width,
                      height: 199.v,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6.h),
                        color: AppColor.offWhite,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Earnings',
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            '₹2,799',
                            style: textTheme.titleMedium!.copyWith(
                              color: AppColor.greenColor,
                              fontSize: 32.fSize,
                            ),
                          ),
                          SizedBox(height: 20.v),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5.v,
                                width: 5.h,
                                decoration: BoxDecoration(
                                    color: AppColor.redColor,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(width: 5.h),
                              Text(
                                'Pending Amount- ₹4258',
                                style: textTheme.titleMedium!
                                    .copyWith(color: AppColor.redColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.v),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5.v,
                                width: 5.h,
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                              ),
                              SizedBox(width: 5.h),
                              Text(
                                'Pending Amount- ₹4258',
                                style: textTheme.bodySmall!
                                    .copyWith(fontSize: 14.fSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36.v),
                    Text(
                      'Monthly Earnings Breakdown',
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 24.v),
                    SizedBox(
                      height: 31.v,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(right: 4.h),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: index == 0
                                ? BoxDecoration(
                                    color: AppColor.offWhite,
                                    borderRadius: BorderRadius.circular(48.h))
                                : null,
                            width: 60.h,
                            child: Text(
                              'Jan',
                              style: textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.v),
                    _buildRevenueChart(state.influencerOrder.graph),
                    SizedBox(height: 36.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Transactions',
                          style: textTheme.titleMedium,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.recentTransactionsScreen);
                          },
                          child: Text(
                            'View All',
                            style: textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.v),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.influencerOrder.influencerOrder.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        InfluencerOrder influencerOrder =
                            state.influencerOrder.influencerOrder[index];
                        return _buildItem(influencerOrder, context);
                      },
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  SizedBox _buildItem(InfluencerOrder influencerOrder, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: SizeUtils.width,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.v),
        child: Row(
          children: [
            CustomImageView(
              width: 135.h,
              height: 135.v,
              fit: BoxFit.fill,
              radius: BorderRadius.only(
                  topLeft: Radius.circular(12.h),
                  bottomLeft: Radius.circular(12.h)),
              imagePath: influencerOrder.product.productImage,
            ),
            SizedBox(width: 5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    influencerOrder.product.productName,
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.v),
                  Row(
                    children: [
                      Text(
                        'Deal Amount-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        "₹${influencerOrder.amount}",
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.v),
                  Row(
                    children: [
                      Text(
                        'Payment Status-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        influencerOrder.status,
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.greenColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.v),
                  Row(
                    children: [
                      Text(
                        'Seller-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        influencerOrder.name,
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.primary),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildRevenueChart(List<Graph> graph) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.offWhite, borderRadius: BorderRadius.circular(12.h)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      graph.length,
                      (index) => FlSpot(index.toDouble(),
                          graph[index].totalAmount.toDouble()),
                    ),
                    // spots: [
                    //   const FlSpot(0, 1),
                    //   const FlSpot(1, 1.5),
                    //   const FlSpot(2, 1.4),
                    //   const FlSpot(3, 2.2),
                    //   const FlSpot(4, 2.8),
                    //   const FlSpot(5, 3),
                    //   const FlSpot(6, 3.5),
                    //   const FlSpot(7, 3.3),
                    //   const FlSpot(8, 4),
                    // ],
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Colors.black, Colors.black],
                    ),
                    dotData: const FlDotData(show: false),
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.v),
            child: const Text(
              'Total Revenue- ₹24000',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
