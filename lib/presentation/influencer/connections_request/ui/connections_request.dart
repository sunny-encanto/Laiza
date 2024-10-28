import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/connection_request_model/connection_request_model.dart';

import '../../../empty_pages/empty_request/empty_request.dart';
import '../bloc/connection_request_bloc.dart';

class ConnectionsRequestScreen extends StatelessWidget {
  const ConnectionsRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connections Request',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: BlocBuilder<ConnectionRequestBloc, ConnectionRequestState>(
        builder: (context, state) {
          if (state is ConnectionRequestInitial) {
            context
                .read<ConnectionRequestBloc>()
                .add(ConnectionRequestLoadEvent());
          } else if (state is ConnectionRequestLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ConnectionRequestError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ConnectionRequestLoaded) {
            return state.requestList.isEmpty
                ? const EmptyRequestScreen()
                : ListView.builder(
                    itemCount: state.requestList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.v, vertical: 10.v),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomImageView(
                                radius: BorderRadius.circular(100.h),
                                width: 50.v,
                                height: 50.v,
                                fit: BoxFit.fill,
                                imagePath:
                                    'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
                              ),
                              SizedBox(width: 4.v),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Krithika Thapar',
                                    style: textTheme.titleMedium,
                                  ),
                                  SizedBox(height: 4.v),
                                  Row(
                                    children: [
                                      Text(
                                        'Product Category- ',
                                        style: textTheme.bodySmall!
                                            .copyWith(fontSize: 12.fSize),
                                      ),
                                      Text(
                                        'Cosmetics',
                                        style: textTheme.titleMedium!
                                            .copyWith(fontSize: 12.fSize),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Visibility(
                                visible:
                                    state.requestList[index].requestStatus ==
                                        ConnectionRequestStatus.pending.name,
                                replacement: CustomImageView(
                                  imagePath: ImageConstant.chatIcon,
                                ),
                                child: Row(
                                  children: [
                                    CustomImageView(
                                      onTap: () {
                                        context.read<ConnectionRequestBloc>().add(
                                            ConnectionRequestChangeStatusEvent(
                                                id: state.requestList[index].id,
                                                status: ConnectionRequestStatus
                                                    .accepted.name));
                                      },
                                      imagePath: ImageConstant.accept,
                                    ),
                                    SizedBox(width: 12.h),
                                    CustomImageView(
                                      onTap: () {
                                        context.read<ConnectionRequestBloc>().add(
                                            ConnectionRequestChangeStatusEvent(
                                                id: state.requestList[index].id,
                                                status: ConnectionRequestStatus
                                                    .rejected.name));
                                      },
                                      imagePath: ImageConstant.reject,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8.v),
                          Visibility(
                            visible: state.requestList[index].requestStatus ==
                                ConnectionRequestStatus.pending.name,
                            child: Text(
                              state.requestList[index].description,
                              style: textTheme.bodySmall!
                                  .copyWith(fontSize: 12.fSize),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
