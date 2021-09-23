import 'package:get/get.dart';
import 'package:productivity_app/ui/chart/chart_binding.dart';
import 'package:productivity_app/ui/chart/chart_screen.dart';
import 'package:productivity_app/ui/detail_work/detail_work_binding.dart';
import 'package:productivity_app/ui/detail_work/detail_work_screen.dart';
import 'package:productivity_app/ui/form/form_data_work_binding.dart';
import 'package:productivity_app/ui/form/form_data_work_screen.dart';
import 'package:productivity_app/ui/form/form_result/form_result_binding.dart';
import 'package:productivity_app/ui/form/form_result/form_result_screen.dart';
import 'package:productivity_app/ui/home/home_binding.dart';
import 'package:productivity_app/ui/home/home_screen.dart';
import 'package:productivity_app/ui/login/login_binding.dart';
import 'package:productivity_app/ui/login/login_screen.dart';
import 'package:productivity_app/ui/lur/lur_binding.dart';
import 'package:productivity_app/ui/lur/lur_screen.dart';
import 'package:productivity_app/ui/project/project_binding.dart';
import 'package:productivity_app/ui/project/project_screen.dart';
import 'package:productivity_app/ui/recapitulation/recapitulation_binding.dart';
import 'package:productivity_app/ui/recapitulation/recapitulation_screen.dart';
import 'package:productivity_app/ui/register/register_binding.dart';
import 'package:productivity_app/ui/register/register_screen.dart';
import 'package:productivity_app/ui/splash/splash_binding.dart';
import 'package:productivity_app/ui/splash/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      binding: SplashBinding(),
      page: () => SplashPage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      binding: LoginBinding(),
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.REGISTER,
      binding: RegisterBinding(),
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.HOME,
      binding: HomeBinding(),
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.PROJECT,
      binding: ProjectBinding(),
      page: () => ProjectPage(),
    ),
    GetPage(
      name: Routes.DATA_WORK,
      binding: FormDataWorkBinding(),
      page: () => FormDataWorkPage(),
    ),
    GetPage(
      name: Routes.DATA_WORK_RESULT,
      binding: FormResultBinding(),
      page: () => FormResultPage(),
    ),
    GetPage(
      name: Routes.WORK_DETAIL,
      binding: DetailWorkBinding(),
      page: () => DetailWorkPage(),
    ),
    GetPage(
      name: Routes.WORK_RECAP,
      binding: RecapitulationBinding(),
      page: () => RecapitulationPage(),
    ),
    GetPage(
      name: Routes.WORK_LUR,
      binding: LurBinding(),
      page: () => LurPage(),
    ),
    GetPage(
      name: Routes.WORK_CHART,
      binding: ChartBinding(),
      page: () => ChartPage(),
    ),
  ];
}
