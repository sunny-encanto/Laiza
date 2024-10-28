import 'package:laiza/core/app_export.dart';

import '../../../../widgets/post_card_widget.dart';

class CreateCollectionScreen extends StatelessWidget {
  const CreateCollectionScreen({super.key});

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
        builder: (context, state) {
          if (state is CreateCollectionInitial) {
            context.read<CreateCollectionBloc>().add(CollectionFetchEvent());
          } else if (state is CreateCollectionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                hintText: 'Add Title',
              ),
            ),
            CustomElevatedButton(width: 108.h, height: 36.v, text: 'Done')
          ],
        ),
      ),
    );
  }
}
