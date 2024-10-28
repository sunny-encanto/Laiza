import 'package:laiza/presentation/influencer/chats/bloc/chats_bloc.dart';
import 'package:laiza/presentation/influencer/discover_connections/bloc/discover_connections_bloc.dart';
import 'package:laiza/presentation/influencer/edit_profile/ui/edit_profile.dart';
import 'package:laiza/presentation/influencer/home/bloc/home_bloc.dart';
import 'package:laiza/presentation/influencer/home/ui/home.dart';
import 'package:laiza/presentation/influencer/influencer_my_profile/bloc/influencer_my_profile_bloc.dart';
import 'package:laiza/presentation/influencer/influencer_my_profile/ui/influencer_my_profile.dart';
import 'package:laiza/presentation/influencer/schedule_stream/bloc/schedule_stream_bloc.dart';
import 'package:laiza/presentation/influencer/seller_info/bloc/seller_info_bloc.dart';

import '../core/app_export.dart';
import '../presentation/auth/login_with_phone/log_In_with_phone.dart';
import '../presentation/auth/otp_screen/otp_screen.dart';
import '../presentation/influencer/chat_box/ui/chat_box_ui.dart';
import '../presentation/influencer/chat_box/ui/image_message_widget/image_message_widget.dart';
import '../presentation/influencer/chats/ui/chats.dart';
import '../presentation/influencer/connections_request/bloc/connection_request_bloc.dart';
import '../presentation/influencer/connections_request/ui/connections_request.dart';
import '../presentation/influencer/dashboard/ui/dashboard.dart';
import '../presentation/influencer/discover_connections/ui/discover_connections.dart';
import '../presentation/influencer/edit_profile/bloc/edit_profile_bloc.dart';
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

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // User Screens
      case splashScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SplashBloc()..add(SplashStarted()),
                  child: const SplashScreen(),
                ));
      case introScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());

      case selectRoleScreen:
        return MaterialPageRoute(
            builder: (context) => const SelectRoleScreen());

      case signInScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LoginBloc(),
                  child: LoginScreen(),
                ));

      case logInWithPhoneScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LoginBloc(),
                  child: LogInWithPhoneScreen(),
                ));

      case otpScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LoginBloc(),
                  child: OtpScreen(),
                ));

      case signUpScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SignUpBloc(),
                  child: SignUpScreen(),
                ));

      case sellerFormScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SellerFormBloc(),
                  child: SellerFormScreen(),
                ));

      case influencerFormScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InfluencerFormBloc(),
                  child: InfluencerFormScreen(),
                ));

      case successScreen:
        return MaterialPageRoute(builder: (context) => const SuccessScreen());

      case bottomBarScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BottomBarCubit(),
                  child: BottomBar(),
                ));

      case productDetailScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ProductDetailBloc(),
                  child: ProductDetailScreen(),
                ));

      case cartScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CartBloc(),
                  child: const CartScreen(),
                ));

      case checkOutScreen:
        return MaterialPageRoute(builder: (context) => const CheckOutScreen());

      case influencerProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const InfluencerProfileScreen());

      case collectionViewScreen:
        return MaterialPageRoute(
            builder: (context) => const CollectionViewScreen());

      case allTrendingScreen:
        return MaterialPageRoute(
            builder: (context) => const AllTrendingScreen());

      case followingScreen:
        return MaterialPageRoute(builder: (context) => const FollowingScreen());

      case addAddressScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => AddAddressBloc(),
                  child: AddAddressScreen(),
                ));

      case forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ForgotPasswordBloc(),
                  child: ForgotPasswordScreen(),
                ));

      case changePasswordScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ChangePasswordBloc(),
                  child: ChangePasswordScreen(),
                ));

      case orderTrackScreen:
        return MaterialPageRoute(
            builder: (context) => const OrderTrackScreen());

      case myOrderScreen:
        return MaterialPageRoute(builder: (context) => const MyOrderScreen());

      case orderPlacedScreen:
        return MaterialPageRoute(
            builder: (context) => const OrderPlacedScreen());

      case notificationsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => NotificationsBloc(),
                  child: const NotificationsScreen(),
                ));

      case searchScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SearchBloc(),
                  child: SearchScreen(),
                ));

      case filterScreen:
        return MaterialPageRoute(builder: (context) => const FilterScreen());

      case allOngoingStreamsScreen:
        return MaterialPageRoute(
            builder: (context) => const AllOngoingStreamsScreen());

      case allFavInfluencerScreen:
        return MaterialPageRoute(
            builder: (context) => const AllFavInfluencerScreen());

      case privacyPolicyScreen:
        return MaterialPageRoute(
            builder: (context) => const PrivacyPolicyScreen());

      case helpCentreScreen:
        return MaterialPageRoute(
            builder: (context) => const HelpCentreScreen());

      case wishlistScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => WishlistBloc(),
                  child: const WishlistScreen(),
                ));

      case commentsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CommentsBloc(),
                  child: const CommentsScreen(),
                ));
      case viewImageWidget:
        final String url = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ViewImageWidget(
                  url: url,
                ));

      // Influencer  Screen
      case connectionsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConnectionsBloc(),
                  child: ConnectionsScreen(),
                ));

      case createConnectionsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CreateCollectionBloc(),
                  child: const CreateCollectionScreen(),
                ));

      case influenceProfileSetupScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InfluenceProfileSetupBloc(),
                  child: InfluenceProfileSetupScreen(),
                ));

      case followersScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => FollowersBloc(),
                  child: FollowersScreen(),
                ));

      case uploadReelScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => UploadReelBloc(),
                  child: const UploadReelScreen(),
                ));

      case homeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => HomeBloc(),
                  child: const HomeScreen(),
                ));

      case scheduleStreamScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ScheduleStreamBloc(),
                  child: ScheduleStreamScreen(),
                ));

      case sellerInfoScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SellerInfoBloc(),
                  child: SellerInfoScreen(),
                ));

      case influencerMyProfile:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => InfluencerMyProfileBloc(),
                  child: const InfluencerMyProfileScreen(),
                ));

      case dashboardScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());

      case connectionsRequestScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ConnectionRequestBloc(),
                  child: const ConnectionsRequestScreen(),
                ));

      case chatsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ChatsBloc(),
                  child: const ChatsScreen(),
                ));
      case discoverConnectionsScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => DiscoverConnectionsBloc(),
                  child: DiscoverConnectionsScreen(),
                ));
      case chatBoxScreen:
        String id = settings.arguments as String;
        return MaterialPageRoute(builder: (context) => ChatBoxScreen(id: id));

      case editProfileScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => EditProfileBloc(),
                  child: EditProfileScreen(),
                ));
      default:
        return null;
    }
  }
}
