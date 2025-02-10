import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';

import '../../../../widgets/post_card_widget.dart';

class CreateCollectionScreen extends StatelessWidget {
  CreateCollectionScreen({super.key});

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Collection',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: BlocBuilder<CreateCollectionBloc, CreateCollectionState>(
        buildWhen: (previous, current) => (current is CreateCollectionLoading ||
            current is CreateCollectionError ||
            current is CreateCollectionLoaded),
        builder: (context, state) {
          if (state is CreateCollectionInitial) {
            context.read<CreateCollectionBloc>().add(CollectionFetchEvent());
          } else if (state is CreateCollectionLoading) {
            return const LoadingGridScreen();
          } else if (state is CreateCollectionLoaded) {
            return GridView.builder(
                padding: EdgeInsets.all(20.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 185.h / 261.v,
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.v,
                    crossAxisSpacing: 16.h),
                itemCount: state.collection.length,
                itemBuilder: (context, index) => Stack(
                      children: [
                        PostCardWidget(post: state.collection[index]),
                        Checkbox(
                            activeColor: AppColor.primary,
                            value: state.collection[index].isSelected,
                            onChanged: (value) {
                              context.read<CreateCollectionBloc>().add(
                                  CollectionSelectEvent(
                                      state.collection[index].id));
                            })
                      ],
                    ));
          }
          return const SizedBox.shrink();
        },
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
        child: Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: titleController,
                hintText: 'Add Title',
              ),
            ),
            BlocConsumer<CreateCollectionBloc, CreateCollectionState>(
              listener: (context, state) {
                if (state is CreateCollectionSuccess) {
                  context.showSnackBar(state.message);
                  Navigator.of(context).pop();
                } else if (state is CreateCollectionRequestError) {
                  context.showSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  isLoading: state is CreateCollectionRequestLoading,
                  width: 108.h,
                  height: 36.v,
                  text: 'Done',
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      context.showSnackBar('Please enter title');
                    } else {
                      context
                          .read<CreateCollectionBloc>()
                          .add(CollectionSubmitEvent(titleController.text));
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
