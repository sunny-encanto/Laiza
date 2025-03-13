import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/live/ui/live_screen.dart';

import '../../creator/ui/creator_screen.dart';
import '../../profile/ui/profile_screen.dart';
import '../../reels/ui/reel_screen.dart';

// ignore: must_be_immutable
class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarState>(
      listener: (BuildContext context, BottomBarState state) {
        _selectedIndex = state.selectedIndex;
      },
      builder: (BuildContext context, BottomBarState state) {
        return Scaffold(
          body: _getBodyWidget(state.selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(
                fontSize: 12.0.fSize,
                color: AppColor.primary,
                fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                fontSize: 12.0.fSize,
                color: AppColor.primary,
                fontWeight: FontWeight.w500),
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildIcon(ImageConstant.reelIcon, _selectedIndex == 0),
                label: 'Pops',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon(ImageConstant.liveIcon, _selectedIndex == 1),
                label: 'Live',
              ),
              BottomNavigationBarItem(
                icon:
                    _buildIcon(ImageConstant.discoverIcon, _selectedIndex == 2),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon:
                    _buildIcon(ImageConstant.creatorsIcon, _selectedIndex == 3),
                label: 'Creators',
              ),
              BottomNavigationBarItem(
                icon:
                    _buildIcon(ImageConstant.profileIcon, _selectedIndex == 4),
                label: 'Profile',
              ),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: AppColor.primary,
            onTap: (int index) {
              context.read<BottomBarCubit>().selectTab(index);
            },
          ),
        );
      },
    );
  }

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return const ReelScreen();
      case 1:
        return const LiveScreen();
      case 2:
        return const DiscoverScreen();
      case 3:
        return const CreatorScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const Center(child: Text('No Page Found'));
    }
  }

  // Build custom icon with background color and radius on selection
  Widget _buildIcon(String imagePath, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 64.h,
      padding: EdgeInsets.all(5.h),
      margin: EdgeInsets.only(bottom: 3.v),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? AppColor.primary : Colors.transparent,
      ),
      child: CustomImageView(
        imagePath: imagePath,
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}

// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key});

//   @override
//   _BottomBarState createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   int _selectedIndex = 0;

//   // List of widgets to display for each tab
//   final List<Widget> _pages = <Widget>[
//     const ReelScreen(),
//     const LiveScreen(),
//     const DiscoverScreen(),
//     const CreatorScreen(),
//     const ProfileScreen()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<BottomBarCubit, BottomBarState>(
//       listener: (BuildContext context, BottomBarState state) {
//         _selectedIndex = state.selectedIndex;
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: _pages[state.selectedIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             selectedLabelStyle: TextStyle(
//                 fontSize: 12.0.fSize,
//                 color: AppColor.primary,
//                 fontWeight: FontWeight.w500),
//             unselectedLabelStyle: TextStyle(
//                 fontSize: 12.0.fSize,
//                 color: AppColor.primary,
//                 fontWeight: FontWeight.w500),
//             showUnselectedLabels: true,
//             type: BottomNavigationBarType.fixed,
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: _buildIcon(ImageConstant.reelIcon, 0),
//                 label: 'Reels',
//               ),
//               BottomNavigationBarItem(
//                 icon: _buildIcon(ImageConstant.liveIcon, 1),
//                 label: 'Live',
//               ),
//               BottomNavigationBarItem(
//                 icon: _buildIcon(ImageConstant.discoverIcon, 2),
//                 label: 'Discover',
//               ),
//               BottomNavigationBarItem(
//                 icon: _buildIcon(ImageConstant.creatorsIcon, 3),
//                 label: 'Creators',
//               ),
//               BottomNavigationBarItem(
//                 icon: _buildIcon(ImageConstant.profileIcon, 4),
//                 label: 'Profile',
//               ),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: AppColor.primary,
//             onTap: (index) {
//               context.read<BottomBarCubit>().selectTab(index);
//             },
//           ),
//         );
//       },
//     );
//   }

//   // Build custom icon with background color and radius on selection
//   Widget _buildIcon(String imagePath, int index) {
//     bool isSelected = _selectedIndex == index;
//     return Container(
//       width: 64.h,
//       padding: EdgeInsets.all(5.h),
//       margin: EdgeInsets.only(bottom: 3.v),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: isSelected ? AppColor.primary : Colors.transparent,
//       ),
//       child: CustomImageView(
//         imagePath: imagePath,
//         color: isSelected ? Colors.white : Colors.black,
//       ),
//     );
//   }
// }
