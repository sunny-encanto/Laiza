import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/comments_model/comments_model.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Comments',
            style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
          )),
      body: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if (state is CommentsInitial) {
            context.read<CommentsBloc>().add(CommentLoadEvent());
          } else if (state is CommentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommentsErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CommentsLoaded) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              itemCount: state.comments.length,
              itemBuilder: (context, index) =>
                  _buildComment(state.comments[index], context),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Column _buildComment(CommentModel item, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        ListTile(
          key: ValueKey(item.id),
          contentPadding: const EdgeInsets.all(0),
          leading: CustomImageView(
            height: 50.h,
            width: 50.h,
            radius: BorderRadius.circular(50.h),
            imagePath: item.profile,
          ),
          trailing: BlocBuilder<CommentsBloc, CommentsState>(
            builder: (context, state) {
              return Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        context
                            .read<CommentsBloc>()
                            .add(CommentLikeUnLikeEvent(item.id));
                      },
                      child: Icon(
                        item.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border_sharp,
                        color: item.isLiked ? Colors.red : Colors.grey,
                      )),
                  Text(
                    item.commentCount.toString(),
                    style: textTheme.bodySmall,
                  ),
                ],
              );
            },
          ),
          title: Text(
            item.name,
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.comment,
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 5.v),
              Text(
                'Reply',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 50.h),
          child: ListTile(
            minLeadingWidth: 25.h,
            onTap: () {},
            contentPadding: const EdgeInsets.all(0),
            leading: CustomImageView(
              height: 35.h,
              width: 35.h,
              radius: BorderRadius.circular(25.h),
              imagePath: item.profile,
            ),
            trailing: Column(
              children: [
                InkWell(
                    onTap: () {},
                    child: const Icon(Icons.favorite_border_sharp)),
                Text(
                  '12',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            title: Text(
              item.name,
              style:
                  textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.comment,
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 5.v),
                Text(
                  'Reply',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
