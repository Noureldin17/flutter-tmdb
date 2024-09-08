import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import './utils/colors.dart' as colors;
import './utils/pages.dart' as pages;
import 'authentication/presentation/bloc/authentication_bloc.dart';
import 'core/dependency_injection/dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<AuthenticationBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieMagic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'MovieMagic'),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppRouter router = AppRouter();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    BlocProvider.of<AuthenticationBloc>(context).add(CheckLoginStatesEvent());
    super.initState();
  }

  String getNextRoute() {
    String nextRoute = pages.onBoardingPage;
    AuthenticationState state =
        BlocProvider.of<AuthenticationBloc>(context).state;
    if (state is LoginStatesCheckedState) {
      LoginStatesCheckedState loginStatesCheckedState = state;
      if (loginStatesCheckedState.isOnBoard) {
        if (loginStatesCheckedState.keepSignedIn) {
          nextRoute = pages.appMainPage;
        } else {
          nextRoute = pages.welcomePage;
        }
      }
    } else {
      nextRoute = pages.onBoardingPage;
    }

    return nextRoute;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenerateRoute,
      home: Sizer(
        builder: (context, orientation, deviceType) => AnimatedSplashScreen(
            splashIconSize: 200.sp,
            animationDuration: const Duration(milliseconds: 500),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: colors.primaryDark,
            splash: splashScreen(),
            nextRoute: getNextRoute(),
            nextScreen: Container()),
      ),
    );
  }
}

Widget splashScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
                  colors: [colors.primaryBlue, colors.primaryPurple])
              .createShader(bounds),
          child: Image.asset(
            'assets/logo/cinema.png',
            width: 100.sp,
            height: 100.sp,
            color: colors.primaryPurple,
          )),
      Padding(padding: EdgeInsets.all(10.sp)),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: "Movie",
          style: GoogleFonts.righteous(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w200,
          ),
        ),
        TextSpan(
          text: "Magic",
          style: GoogleFonts.righteous(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        )
      ]))
    ],
  );
}
