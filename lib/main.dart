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

  await NotificationService.initialize();
  await FirebaseMessagingService.initialize();
  await PrefUtils.init();
  await FirebaseMessagingService.generateToken();
  await FirebaseMessagingService.handleInitialMessage();
  await FirebaseMessagingService.onBackgroundMessage();

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
                initialRoute: AppRoutes.influencerFormScreen,
              );
            },
          ),
        ),
      );
    });
  }
}
