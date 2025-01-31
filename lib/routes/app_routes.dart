import 'package:flutter/cupertino.dart';
import 'package:laiza/data/repositories/comments_repository/comments_repository.dart';
import 'package:laiza/data/repositories/connections_repository/connections_repository.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';

import '../core/app_export.dart';
import '../presentation/influencer/order_management/bloc/influencer_orders_bloc.dart';

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

  static const String imageViewScreen = '/imageView_Screen';

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
                    authType: data['authType'],
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
                  create: (context) =>
                      ProductDetailBloc(context.read<ProductRepository>()),
                  child: ProductDetailScreen(id: id),
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
        String id = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (context) => InfluencerProfileScreen(id: id));

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
        int id = settings.arguments as int;
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
                  create: (context) =>
                      CommentsBloc(context.read<CommentsRepository>()),
                  child: CommentsScreen(reelId: id),
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
                  create: (context) =>
                      ConnectionsBloc(context.read<ConnectionsRepository>()),
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
                  create: (context) =>
                      FollowersBloc(context.read<FollowersRepository>()),
                  child: FollowersScreen(),
                ));

      case uploadReelScreen:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      UploadReelBloc(context.read<ReelRepository>()),
                  child: UploadReelScreen(
                    mediaPath: data['path'],
                    reel: data['reel'],
                  ),
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
                  child: InfluencerMyProfileScreen(),
                ));

      case dashboardScreen:
        return CupertinoPageRoute(
            builder: (context) => const DashboardScreen());

      case connectionsRequestScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConnectionRequestBloc(
                      context.read<ConnectionsRepository>()),
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
                  create: (context) =>
                      DiscoverConnectionsBloc(context.read<UserRepository>()),
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
            builder: (context) => BlocProvider(
                  create: (context) => InfluencerOrdersBloc(),
                  child: const OrderManagementScreen(),
                ));
      default:
        return null;
    }
  }
}
