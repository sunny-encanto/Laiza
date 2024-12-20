import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laiza/data/repositories/category_repository/category_repository.dart';
import 'package:laiza/data/repositories/post_repository/post_repository.dart';
import 'package:laiza/data/repositories/region_repository/region_repository.dart';
import 'package:laiza/data/repositories/user_repository/user_repository.dart';
import 'package:laiza/firebase_options.dart';
import 'package:laiza/localization/language_cubit.dart';

import 'core/app_export.dart';
import 'core/network/connectivity_cubit.dart';
import 'core/utils/pref_utils.dart';
import 'data/models/user/user_model.dart';
import 'data/repositories/auth_repository/auth_repository.dart';
import 'data/repositories/cart_repository/cart_repository.dart';
import 'data/repositories/wishlist_repository/wishlist_repository.dart';
import 'data/services/firebase_messaging_service.dart';
import 'data/services/notification_service.dart';
import 'localization/app_localization.dart';
import 'theme/theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefUtils.init();
  await NotificationService.initialize();
  await FirebaseMessagingService.initialize();
  await FirebaseMessagingService.handleInitialMessage();
  await FirebaseMessagingService.onBackgroundMessage();
  await FirebaseMessagingService.generateToken();
  await getFromCompleteStatus();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
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
