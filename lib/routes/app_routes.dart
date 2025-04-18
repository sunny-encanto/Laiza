import 'package:flutter/cupertino.dart';
import 'package:laiza/data/blocs/city_bloc/city_bloc.dart';
import 'package:laiza/data/blocs/collection_bloc/collection_bloc.dart';
import 'package:laiza/data/blocs/country_bloc/country_bloc.dart';
import 'package:laiza/data/blocs/influencer_profile_bloc/influencer_profile_bloc.dart';
import 'package:laiza/data/blocs/state_bloc/state_bloc.dart';
import 'package:laiza/data/models/address_model/address_model.dart';
import 'package:laiza/data/repositories/address_repository/address_repository.dart';
import 'package:laiza/data/repositories/collection_repository/collection_repository.dart';
import 'package:laiza/data/repositories/comments_repository/comments_repository.dart';
import 'package:laiza/data/repositories/connections_repository/connections_repository.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';
import 'package:laiza/data/repositories/help_center_repository/help_center_repository.dart';
import 'package:laiza/data/repositories/live_stream_repository/live_stream_repository.dart';
import 'package:laiza/data/repositories/notification_repository/notification_repository.dart';
import 'package:laiza/data/repositories/order_repository/order_repository.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/data/repositories/rating_repository/rating_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/presentation/add_review/bloc/add_rating_bloc.dart';
import 'package:laiza/presentation/address_screen/bloc/address_bloc.dart';
import 'package:laiza/presentation/creator/ui/all_creator_screen.dart';
import 'package:laiza/presentation/influencer/earnings/cubit/earning_cubit.dart';
import 'package:laiza/presentation/my_order/bloc/my_order_bloc.dart';
import 'package:laiza/presentation/order_summary/cubit/order_summary_cubit.dart';
import 'package:laiza/presentation/privacy_policy/ui/bloc/privacy_policy_bloc.dart';

import '../core/app_export.dart';
import '../presentation/add_review/ui/add_rating.dart';
import '../presentation/address_screen/ui/address_screen.dart';
import '../presentation/auth/change_password/ui/create_password.dart';
import '../presentation/auth/settings_page/ui/settings_page.dart';
import '../presentation/influencer/order_management/bloc/influencer_orders_bloc.dart';
import '../presentation/order_summary/ui/order_summary.dart';
import '../presentation/report_user/ui/report_user_screen.dart';
import '../presentation/search/ui/influencer_search_screen.dart';
import '../presentation/user_edit_porfile/ui/user_edit_profile.dart';

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

  static const String addressScreen = '/address_screen';

  static const String influencerProfileScreen = '/influencer_profile_screen';

  static const String collectionViewScreen = '/collection_view_screen';

  static const String allTrendingScreen = '/all_trending_screen';

  static const String followingScreen = '/following_screen';

  static const String addAddressScreen = '/add_address_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String createPasswordScreen = '/create_password_screen';

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

  static const String createCollectionScreen = '/create_collection_screen';

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

  static const String settingScreen = '/setting_Screen';

  static const String addRatingScreen = '/add_rating_Screen';

  static const String editUserProfileScreen = '/user_edit_profile_screen';

  static const String reportUserScreen = '/report_user_screen';

  static const String orderSummary = '/order_summary_screen';

  static const String allCreatorsScreen = '/all_creators_screen';

  static const String influencerSearchScreen = '/influencer_search_screen';

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

      case addressScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      AddressBloc(context.read<AddressRepository>()),
                  child: const AddressScreen(),
                ));

      case influencerProfileScreen:
        String id = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      InfluencerProfileBloc(context.read<UserRepository>()),
                  child: InfluencerProfileScreen(id: id),
                ));

      case collectionViewScreen:
        int id = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    CollectionBloc(context.read<CollectionRepository>()),
                child: CollectionViewScreen(id: id)));

      case allTrendingScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllTrendingScreen());

      case followingScreen:
        return CupertinoPageRoute(
            builder: (context) => const FollowingScreen());

      case addAddressScreen:
        Address? address = settings.arguments as Address?;
        return CupertinoPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) =>
                            AddAddressBloc(context.read<AddressRepository>())),
                    BlocProvider(
                        create: (context) =>
                            CountryBloc(context.read<RegionRepository>())),
                    BlocProvider(
                        create: (context) =>
                            StateBloc(context.read<RegionRepository>())),
                    BlocProvider(
                        create: (context) =>
                            CityBloc(context.read<RegionRepository>())),
                  ],
                  child: AddAddressScreen(address: address),
                ));

      case forgotPasswordScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ForgotPasswordBloc(context.read<AuthRepository>()),
                  child: ForgotPasswordScreen(),
                ));

      case createPasswordScreen:
        String email = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ChangePasswordBloc(context.read<AuthRepository>()),
                  child: CreatePasswordScreen(email: email),
                ));

      case changePasswordScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ChangePasswordBloc(context.read<AuthRepository>()),
                  child: ChangePasswordScreen(),
                ));
      case orderTrackScreen:
        return CupertinoPageRoute(
            builder: (context) => const OrderTrackScreen());

      case myOrderScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      MyOrderBloc(context.read<OrderRepository>()),
                  child: const MyOrderScreen(),
                ));

      case orderPlacedScreen:
        return CupertinoPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case notificationsScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      NotificationsBloc(context.read<NotificationRepository>()),
                  child: const NotificationsScreen(),
                ));

      case searchScreen:
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
                  create: (context) =>
                      SearchBloc(context.read<UserRepository>()),
                  child: const SearchScreen(),
                ));
      case influencerSearchScreen:
        return CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
                  create: (context) =>
                      SearchBloc(context.read<UserRepository>()),
                  child: const InfluencerSearchScreen(),
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
            builder: (context) => BlocProvider(
                create: (context) =>
                    PrivacyPolicyBloc(context.read<HelpCenterRepository>()),
                child: const PrivacyPolicyScreen()));

      case helpCentreScreen:
        return CupertinoPageRoute(builder: (context) => HelpCentreScreen());

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

      case createCollectionScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CreateCollectionBloc(
                      context.read<CollectionRepository>()),
                  child: CreateCollectionScreen(),
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
                  create: (context) =>
                      ScheduleStreamBloc(context.read<LiveStreamRepository>()),
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
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      EarningCubit(context.read<OrderRepository>()),
                  child: EarningsScreen(),
                ));

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

      case settingScreen:
        return CupertinoPageRoute(builder: (context) => const SettingPage());

      case orderSummary:
        final Map<String, dynamic> data =
            settings.arguments as Map<String, dynamic>;

        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => OrderSummaryCubit(),
                child: OrderSummary(items: data['items'])));

      case reportUserScreen:
        final String id = settings.arguments as String;
        return CupertinoPageRoute(
            builder: (context) => ReportUserScreen(reportedUserId: id));

      case editUserProfileScreen:
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    EditProfileBloc(context.read<UserRepository>()),
                child: UserEditProfileScreen()));

      case addRatingScreen:
        final int id = settings.arguments as int;
        return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) =>
                    AddRatingBloc(context.read<RatingRepository>()),
                child: AddRatingScreen(productId: id)));

      case allCreatorsScreen:
        return CupertinoPageRoute(
            builder: (context) => const AllCreatorScreen());
      default:
        return null;
    }
  }
}
