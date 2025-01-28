import 'package:firebase_core/firebase_core.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';
import 'package:laiza/data/repositories/product_repository/product_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/data/services/notification_service.dart';

import 'core/app_export.dart';
import 'core/network/connectivity_cubit.dart';
import 'core/utils/pref_utils.dart';
import 'data/models/user/user_model.dart';
import 'data/repositories/comments_repository/comments_repository.dart';
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
    DeepLinkService.handleDynamicLinks();
    // DeepLinkService.handleIncomingLinks();
  }

  @override
  void dispose() {
    super.dispose();
    DeepLinkService.dispose();
    // DeepLinkService.linkSubscription?.cancel();
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
