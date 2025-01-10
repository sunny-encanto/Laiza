import 'package:fluttertoast/fluttertoast.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/comment_reply_model/reply.dart';

import '../../../data/models/comments_model/comment.dart';

class CommentsScreen extends StatelessWidget {
  final int reelId;

  CommentsScreen({super.key, required this.reelId});

  final TextEditingController commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _commentId = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'Comments',
              style: textTheme.titleMedium,
            )),
        body: Padding(
          padding: EdgeInsets.only(bottom: 60.h),
          child: BlocConsumer<CommentsBloc, CommentsState>(
            listener: (context, state) {
              if (state is CommentDeletedState) {
                context.showSnackBar(state.message);
                context.read<CommentsBloc>().add(CommentLoadEvent(reelId));
              } else if (state is CommentsErrorState) {
                context.showSnackBar(state.message);
              }
            },
            buildWhen: (previous, current) => (current is CommentsLoaded ||
                current is CommentsLoading ||
                current is CommentsInitial),
            builder: (context, state) {
              if (state is CommentsInitial) {
                context.read<CommentsBloc>().add(CommentLoadEvent(reelId));
              } else if (state is CommentsLoading) {
                return const Center(
                  child: SizedBox.shrink(),
                );
              } else if (state is CommentsErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CommentsLoaded) {
                //TODO: Need to uncomment for fetch Replies
                // context.read<CommentsBloc>().add(CommentReplyLoadEvent(reelId));
                return ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) =>
                      _buildComment(state.comments[index], index, context),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.all(8.0.h),
          child: CustomTextFormField(
            focusNode: _focusNode,
            controller: commentController,
            hintText: 'type here',
            suffix: IconButton(
                onPressed: () {
                  if (commentController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Can't add empty comment");
                  } else {
                    FocusScope.of(context).unfocus();
                    if (_commentId == 0) {
                      context.read<CommentsBloc>().add(AddCommentEvent(
                          reelId: reelId, comment: commentController.text));
                      commentController.clear();
                    } else {
                      context.read<CommentsBloc>().add(AddCommentReplyEvent(
                          commentId: _commentId,
                          reply: commentController.text));
                      _commentId = 0;
                      commentController.clear();
                    }
                  }
                },
                icon: Icon(
                  Icons.send,
                  color: AppColor.primary,
                )),
          ),
        ),
      ),
    );
  }

  _buildComment(Comment item, int index, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.grey.shade100,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.grey.shade100,
              onLongPress: () {
                FocusScope.of(context).unfocus();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (bottomContext) => _buildDeleteUi(context, item));
              },
              key: ValueKey(item.id),
              contentPadding: const EdgeInsets.all(0),
              leading: CustomImageView(
                height: 50.h,
                width: 50.h,
                radius: BorderRadius.circular(50.h),
                imagePath: imagesList[0],
                fit: BoxFit.fill,
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
                            size: 20.h,
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
                item.comment,
                style: textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.comment,
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 5.v),
                  InkWell(
                      onTap: () {
                        if (!_focusNode.hasFocus) {
                          _focusNode.requestFocus();
                        }
                        _commentId = item.id;
                      },
                      child: Text(
                        'Reply',
                        style: textTheme.bodySmall,
                      )),
                ],
              ),
            ),
            BlocBuilder<CommentsBloc, CommentsState>(
              buildWhen: (previous, current) => current is CommentsReplyLoaded,
              builder: (context, state) {
                if (state is CommentsErrorState) {
                  return Center(child: Text(state.message));
                } else if (state is CommentsReplyLoaded) {
                  return ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.comments[index].replies.length,
                    itemBuilder: (context, replyIndex) {
                      Reply reply = state.comments[index].replies[replyIndex];
                      return Padding(
                        padding: EdgeInsets.only(left: 30.h),
                        child: ListTile(
                          minLeadingWidth: 25.h,
                          onTap: () {},
                          contentPadding: const EdgeInsets.all(0),
                          leading: CustomImageView(
                              height: 35.h,
                              width: 35.h,
                              radius: BorderRadius.circular(25.h),
                              imagePath: imagesList[0],
                              fit: BoxFit.fill
                              //reply.user.profileImg,
                              ),
                          trailing: Column(
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite_border_sharp,
                                    size: 20.h,
                                  )),
                              Text(
                                '12',
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                          title: Text(
                            reply.user.name ?? '',
                            style: textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reply.reply,
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
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }

  _buildDeleteUi(BuildContext context, Comment comment) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(SizeUtils.width, 50.v)),
              onPressed: () {
                Navigator.of(context).pop();
                _focusNode.requestFocus();
                commentController.text = comment.comment;
              },
              icon: const Icon(Icons.edit, color: Colors.black),
              label: const Text('Edit', style: TextStyle(color: Colors.black)),
            ),
            Divider(color: AppColor.primary),
            TextButton.icon(
              style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(SizeUtils.width, 50.v)),
              onPressed: () {
                context
                    .read<CommentsBloc>()
                    .add(DeleteCommentEvent(comment.id));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
