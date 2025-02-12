import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/reels_model/reel.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';

import '../../../../data/blocs/collection_bloc/collection_bloc.dart';
import '../../../../data/repositories/collection_repository/collection_repository.dart';
import '../../../../widgets/custom_popup_menu_button.dart';
import '../../../../widgets/play_button.dart';
import '../post_view/post_view.dart';

class CollectionViewScreen extends StatelessWidget {
  final int id;

  const CollectionViewScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => CollectionBloc(context.read<CollectionRepository>()),
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          if (state is CollectionInitial) {
            context.read<CollectionBloc>().add(FetchCollectionDetails(id));
          } else if (state is CollectionLoading) {
            return const Material(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: LoadingGridScreen(),
              ),
            );
          } else if (state is CollectionError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CollectionLoaded) {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                  // will come from previous screen
                  title: Text(
                    state.collection[0].title,
                    style: textTheme.titleMedium,
                  ),
                  actions: [
                    CustomPopupMenuButton(
                      menuItems: [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            'Delete Collection',
                            style: textTheme.titleMedium,
                          ),
                        ),
                      ],
                      onItemSelected: (value) {
                        if (value == 0) {
                          context
                              .read<CollectionBloc>()
                              .add(DeleteCollection(id));
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
                // will Show based on previous screen
                body: GridView.builder(
                    padding: EdgeInsets.all(16.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 185.h / 261.v,
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.v,
                        crossAxisSpacing: 8.h),
                    itemCount: state.collection[0].reels.length,
                    itemBuilder: (context, index) {
                      Reel reel = state.collection[0].reels[index];
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageView(
                            height: 261.v,
                            width: 185.h,
                            fit: BoxFit.fill,
                            radius: BorderRadius.circular(6.h),
                            imagePath: reel.reelCoverPath,
                          ),
                          PlayButton(
                            isVisible: true,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    VideoReelPageOtherInfluencer(
                                  reels: state.collection[0].reels,
                                  initialIndex: index,
                                ),
                              ));
                            },
                          )
                        ],
                      );
                    }));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
