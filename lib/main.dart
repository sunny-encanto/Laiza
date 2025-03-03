import 'package:firebase_core/firebase_core.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';
import 'package:laiza/data/repositories/help_center_repository/help_center_repository.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/data/services/notification_service.dart';

import 'core/app_export.dart';
import 'core/network/connectivity_cubit.dart';
import 'core/utils/pref_utils.dart';
import 'data/models/user/user_model.dart';
import 'data/repositories/address_repository/address_repository.dart';
import 'data/repositories/advertisement_repository/advertisement_repository.dart';
import 'data/repositories/collection_repository/collection_repository.dart';
import 'data/repositories/comments_repository/comments_repository.dart';
import 'data/repositories/connections_repository/connections_repository.dart';
import 'data/repositories/coupon_repository/coupon_repository.dart';
import 'data/repositories/live_stream_repository/live_stream_repository.dart';
import 'data/repositories/order_repository/order_repository.dart';
import 'data/repositories/rating_repository/rating_repository.dart';
import 'data/services/deeplink_service.dart';
import 'data/services/firebase_messaging_service.dart';
import 'localization/app_localization.dart';
import 'theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PrefUtils.init();
  await NotificationService.initialize();
  await FirebaseMessagingService.initialize();
  await FirebaseMessagingService.handleInitialMessage();
  await FirebaseMessagingService.onBackgroundMessage();
  await FirebaseMessagingService.generateToken();
  await getFromCompleteStatus();
  Logger.init(LogMode.debug);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    DeepLinkService.handleIncomingLinks();
  }

  @override
  void dispose() {
    super.dispose();
    DeepLinkService.linkSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (BuildContext context) => PostRepository()),
          RepositoryProvider(
              create: (BuildContext context) => CartRepository()),
          RepositoryProvider(
              create: (BuildContext context) => WishlistRepository()),
          RepositoryProvider(
              create: (BuildContext context) => AuthRepository()),
          RepositoryProvider(
              create: (BuildContext context) => UserRepository()),
          RepositoryProvider(
              create: (BuildContext context) => CategoryRepository()),
          RepositoryProvider(
              create: (BuildContext context) => RegionRepository()),
          RepositoryProvider(
              create: (BuildContext context) => FollowersRepository()),
          RepositoryProvider(
              create: (BuildContext context) => ReelRepository()),
          RepositoryProvider(
              create: (BuildContext context) => CommentsRepository()),
          RepositoryProvider(
              create: (BuildContext context) => ProductRepository()),
          RepositoryProvider(
              create: (BuildContext context) => ConnectionsRepository()),
          RepositoryProvider(
              create: (BuildContext context) => HelpCenterRepository()),
          RepositoryProvider(
              create: (BuildContext context) => AdvertisementRepository()),
          RepositoryProvider(
              create: (BuildContext context) => LiveStreamRepository()),
          RepositoryProvider(
              create: (BuildContext context) => CollectionRepository()),
          RepositoryProvider(
              create: (BuildContext context) => RatingRepository()),
          RepositoryProvider(
              create: (BuildContext context) => OrderRepository()),
          RepositoryProvider(
              create: (BuildContext context) => AddressRepository()),
          RepositoryProvider(
              create: (BuildContext context) => CouponRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => LanguageCubit()),
            BlocProvider(
                create: (BuildContext context) =>
                    ConnectivityCubit(Connectivity())),
          ],
          child: BlocBuilder<LanguageCubit, Locale>(
            builder: (BuildContext context, Locale locale) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                locale: locale,
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('es'), // Spanish
                  Locale('fr'), // French
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                title: 'Laiza',
                theme: AppTheme.theme,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                initialRoute: AppRoutes.splashScreen,
              );
            },
          ),
        ),
      );
    });
  }
}

Future<void> getFromCompleteStatus() async {
  if (PrefUtils.getId().isNotEmpty) {
    UserRepository userRepository = UserRepository();
    UserModel userModel = await userRepository.getUserProfile();
    bool isFormComplete = (userModel.isProfileComplete ?? 0) == 1;
    bool isUserApprove = (userModel.isApprove ?? 0) == 1;
    PrefUtils.setIsFormComplete(isFormComplete);
    PrefUtils.setIsApproved(isUserApprove);
  }
}

// Custom Error Widget
class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.orange,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                "Oops! Something went wrong 😅",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Don't worry, we're on it! Here's what happened: $errorMessage",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to recover or restart the app
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: const Text("Try Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
