import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/cubit/app_cubit/app_cubit.dart';
import 'package:user_app/cubit/bloc_observer.dart';
import 'package:user_app/cubit/drivers_cubit/drivers_cubit.dart';
import 'package:user_app/cubit/google_map/google_map_cubit.dart';
import 'package:user_app/cubit/login_cubit/login_cubit.dart';
import 'package:user_app/cubit/register/register_cubit_cubit.dart';
import 'package:user_app/view/pages/splashScreen.dart';
import 'core/dioHelper.dart';
import 'data/services/localDataLayer.dart';
import 'utils/app_theme.dart';
import 'view/routes/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Shared.initSharedPref();
  final token = await Shared.prefGetString(key: "token");

  BlocOverrides.runZoned(
    () => runApp(MyApp(token: token)),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  String? token;

  MyApp({required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubitCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getAppTheme(),
        // initialRoute: historyPage,
        // onGenerateRoute: AppRoute.generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
