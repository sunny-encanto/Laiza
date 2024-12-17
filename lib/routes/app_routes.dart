import 'package:flutter/cupertino.dart';
import 'package:laiza/data/blocs/profile_api_bloc/profile_api_bloc.dart';
import 'package:laiza/data/repositories/auth_repository/auth_repository.dart';
import 'package:laiza/data/repositories/cart_repository/cart_repository.dart';
import 'package:laiza/data/repositories/user_repository/user_repository.dart';
import 'package:laiza/data/repositories/wishlist_repository/wishlist_repository.dart';
import 'package:laiza/presentation/auth/otp_screen/bloc/otp_screen_bloc.dart';
import 'package:laiza/presentation/influencer/chats/bloc/chats_bloc.dart';
import 'package:laiza/presentation/influencer/discover_connections/bloc/discover_connections_bloc.dart';
import 'package:laiza/presentation/influencer/edit_profile/ui/edit_profile.dart';
import 'package:laiza/presentation/influencer/home/bloc/home_bloc.dart';
import 'package:laiza/presentation/influencer/home/ui/home.dart';
import 'package:laiza/presentation/influencer/influencer_my_profile/bloc/influencer_my_profile_bloc.dart';
import 'package:laiza/presentation/influencer/influencer_my_profile/ui/influencer_my_profile.dart';
import 'package:laiza/presentation/influencer/schedule_stream/bloc/schedule_stream_bloc.dart';
import 'package:laiza/presentation/influencer/seller_info/bloc/seller_info_bloc.dart';
import 'package:laiza/presentation/live_page/ui/live_page.dart';

import '../core/app_export.dart';
import '../presentation/all_products/ui/all_products.dart';
import '../presentation/auth/login_with_phone/login_with_phone.dart';
import '../presentation/auth/otp_screen/otp_screen.dart';
import '../presentation/influencer/chat_box/ui/chat_box_ui.dart';
import '../presentation/influencer/chat_box/ui/image_message_widget/image_message_widget.dart';
import '../presentation/influencer/chats/ui/chats.dart';
import '../presentation/influencer/connections_request/bloc/connection_request_bloc.dart';
import '../presentation/influencer/connections_request/ui/connections_request.dart';
import '../presentation/influencer/dashboard/ui/dashboard.dart';
import '../presentation/influencer/discover_connections/ui/discover_connections.dart';
import '../presentation/influencer/earnings/ui/earnings_screen.dart';
import '../presentation/influencer/edit_profile/bloc/edit_profile_bloc.dart';
import '../presentation/influencer/order_management/ui/order_management.dart';
import '../presentation/influencer/recent_transactions/ui/recent_transactions.dart';
import '../presentation/influencer/return_product/ui/return_product.dart';
import '../presentation/influencer/schedule_stream/ui/schedule_stream.dart';
import '../presentation/influencer/seller_info/ui/seller_info.dart';
import '../presentation/notifications/bloc/notifications_bloc.dart';
import '../presentation/select_role/ui/select_role.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String selectRoleScreen = '/select_role_screen';

  static const String introScreen = '/intro_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String logInWithPhoneScreen = '/log_in_with_phone_screen';

  static const String otpScreen = '/otp_screen';

  static const String sellerFormScreen = '/seller_form_screen';

  static const String influencerFormScreen = '/influencer_form_screen';

  static const String successScreen = '/success_screen';

  static const String bottomBarScreen = '/bottom_bar_screen';

  static const String productDetailScreen = '/product_detail_screen';

  static const String cartScreen = '/cart_screen';

  static const String checkOutScreen = '/check_out_screen';

  static const String influencerProfileScreen = '/influencer_profile_screen';

  static const String collectionViewScreen = '/collection_view_screen';

  static const String allTrendingScreen = '/all_trending_screen';

  static const String followingScreen = '/following_screen';

  static const String addAddressScreen = '/add_address_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String myOrderScreen = '/my_order_screen';

  static const String orderTrackScreen = '/order_track_screen';

  static const String orderPlacedScreen = '/order_placed_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String searchScreen = '/search_screen';

  static const String filterScreen = '/filter_screen';

  static const String allOngoingStreamsScreen = '/all_ongoing_streams_screen';

  static const String allFavInfluencerScreen = '/all_fav_influencer_screen';

  static const String privacyPolicyScreen = '/privacy_policy_screen';

  static const String helpCentreScreen = '/help_centre_screen';

  static const String wishlistScreen = '/wishlist_screen';

  static const String connectionsScreen = '/connections_screen';

  static const String commentsScreen = '/comments_screen';

  static const String createConnectionsScreen = '/create_connections_screen';

  static const String influenceProfileSetupScreen =
      '/influence_profile_setup_screen';

  static const String followersScreen = '/followers_screen';

  static const String uploadReelScreen = '/uploadReel_screen';

  static const String homeScreen = '/home_screen';

  static const String scheduleStreamScreen = '/schedule_stream_screen';

  static const String sellerInfoScreen = '/seller_info_screen';

  static const String influencerMyProfile = '/influence_my_profile_screen';

  static const String dashboardScreen = '/dashboard_screen';

  static const String connectionsRequestScreen = '/connections_request_screen';

  static const String chatsScreen = '/chats_screen';

  static const String discoverConnectionsScreen =
      '/discover_connections_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String chatBoxScreen = '/chatBox_screen';

  static const String viewImageWidget = '/viewImageWidget';

  static const String livePage = '/live_page';

  static const String allProductsScreen = '/all_products_screen';

  static const String earningsScreen = '/earnings_screen';

  static const String recentTransactionsScreen = '/recent_transactions_screen';

  static const String returnProductScreen = '/Return_product_screen';

  static const String orderManagementScreen = '/orderManagement_screen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // User Screens
      case splashScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SplashBloc()..add(SplashStarted()),
                  child: const SplashScreen(),
                ));
      case introScreen:
        return CupertinoPageRoute(builder: (context) => const IntroScreen());

      case selectRoleScreen:
        return CupertinoPageRoute(
            builder: (context) => const SelectRoleScreen());

      case signInScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      LoginBloc(context.read<AuthRepository>()),
                  child: LoginScreen(),
                ));

      case logInWithPhoneScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      LoginBloc(context.read<AuthRepository>()),
                  child: LogInWithPhoneScreen(),
                ));

      case otpScreen:
        var data = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      OtpScreenBloc(context.read<AuthRepository>()),
                  child: OtpScreen(
                    userId: data['id'],
                    routeName: data['routeName'],
                    email: data['email'],
                  ),
                ));

      case signUpScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      SignUpBloc(context.read<AuthRepository>()),
                  child: SignUpScreen(),
                ));

      case sellerFormScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SellerFormBloc(),
                  child: SellerFormScreen(),
                ));

      case influencerFormScreen:
        return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (BuildContext context) =>
                            InfluencerFormBloc(context.read<UserRepository>())),
                    BlocProvider(
                        create: (BuildContext context) =>
                            ProfileApiBloc(context.read<UserRepository>())),
                  ],
                  child: InfluencerFormScreen(),
                ));

      case successScreen:
        return CupertinoPageRoute(builder: (context) => const SuccessScreen());

      case bottomBarScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BottomBarCubit(),
                  child: BottomBar(),
                ));

      case productDetailScreen:
        int id = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProductDetailBloc(),
                  child: ProductDetailScreen(
                    id: id,
                  ),
                ));

      case cartScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CartBloc(context.read<CartRepository>()),
                  child: const CartScreen(),
                ));

      case checkOutScreen:
        return CupertinoPageRoute(builder: (context) => const CheckOutScreen());

      case influencerProfileScreen:
        return CupertinoPageRoute(
            builder: (context) => const InfluencerProfileScreen());

      case collectionViewScreen:
        return CupertinoPageRoute(
            builder: (context) => const CollectionViewScreen());

      case allTrendingScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllTrendingScreen());

      case followingScreen:
        return CupertinoPageRoute(
            builder: (context) => const FollowingScreen());

      case addAddressScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AddAddressBloc(),
                  child: AddAddressScreen(),
                ));

      case forgotPasswordScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ForgotPasswordBloc(context.read<AuthRepository>()),
                  child: ForgotPasswordScreen(),
                ));

      case changePasswordScreen:
        String email = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ChangePasswordBloc(context.read<AuthRepository>()),
                  child: ChangePasswordScreen(
                    email: email,
                  ),
                ));

      case orderTrackScreen:
        return CupertinoPageRoute(
            builder: (context) => const OrderTrackScreen());

      case myOrderScreen:
        return CupertinoPageRoute(builder: (context) => const MyOrderScreen());

      case orderPlacedScreen:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case notificationsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => NotificationsBloc(),
                  child: const NotificationsScreen(),
                ));

      case searchScreen:
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
                  create: (context) => SearchBloc(),
                  child: SearchScreen(),
                ));

      case filterScreen:
        return CupertinoPageRoute(builder: (context) => const FilterScreen());

      case allOngoingStreamsScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllOngoingStreamsScreen());

      case allFavInfluencerScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllFavInfluencerScreen());

      case privacyPolicyScreen:
        return CupertinoPageRoute(
            builder: (context) => const PrivacyPolicyScreen());

      case helpCentreScreen:
        return CupertinoPageRoute(
            builder: (context) => const HelpCentreScreen());

      case wishlistScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      WishlistBloc(context.read<WishlistRepository>()),
                  child: const WishlistScreen(),
                ));

      case commentsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CommentsBloc(),
                  child: const CommentsScreen(),
                ));
      case viewImageWidget:
        final String url = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (context) => ViewImageWidget(
                  url: url,
                ));

      // Influencer  Screen
      case connectionsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConnectionsBloc(),
                  child: ConnectionsScreen(),
                ));

      case createConnectionsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CreateCollectionBloc(),
                  child: const CreateCollectionScreen(),
                ));

      case influenceProfileSetupScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InfluenceProfileSetupBloc(),
                  child: InfluenceProfileSetupScreen(),
                ));

      case followersScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => FollowersBloc(),
                  child: FollowersScreen(),
                ));

      case uploadReelScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => UploadReelBloc(),
                  child: const UploadReelScreen(),
                ));

      case homeScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => HomeBloc(),
                  child: const HomeScreen(),
                ));

      case scheduleStreamScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ScheduleStreamBloc(),
                  child: ScheduleStreamScreen(),
                ));

      case sellerInfoScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SellerInfoBloc(),
                  child: SellerInfoScreen(),
                ));

      case influencerMyProfile:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InfluencerMyProfileBloc(),
                  child: const InfluencerMyProfileScreen(),
                ));

      case dashboardScreen:
        return CupertinoPageRoute(
            builder: (context) => const DashboardScreen());

      case connectionsRequestScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConnectionRequestBloc(),
                  child: const ConnectionsRequestScreen(),
                ));

      case chatsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ChatsBloc(),
                  child: const ChatsScreen(),
                ));

      case discoverConnectionsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DiscoverConnectionsBloc(),
                  child: DiscoverConnectionsScreen(),
                ));

      case chatBoxScreen:
        String id = settings.arguments as String;
        return CupertinoPageRoute(builder: (context) => ChatBoxScreen(id: id));

      case editProfileScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      EditProfileBloc(context.read<UserRepository>()),
                  child: EditProfileScreen(),
                ));

      case livePage:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
            builder: (context) => LivePage(
                  liveID: data['live_id'],
                  isHost: data['is_host'],
                ));

      case allProductsScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllProductsScreen());

      case earningsScreen:
        return CupertinoPageRoute(builder: (context) => const EarningsScreen());

      case recentTransactionsScreen:
        return CupertinoPageRoute(
            builder: (context) => const RecentTransactionsScreen());

      case returnProductScreen:
        return CupertinoPageRoute(
            builder: (context) => const ReturnProductScreen());

      case orderManagementScreen:
        return CupertinoPageRoute(
            builder: (context) => const OrderManagementScreen());
      default:
        return null;
    }
  }
}
