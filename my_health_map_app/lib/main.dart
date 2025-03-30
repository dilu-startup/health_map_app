import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_pages.dart';
import 'core/themes/app_themes.dart';
import 'presentation/bindings/auth_binding.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Demo',
      initialBinding: AuthBinding(),
      initialRoute: Routes.LOGIN,
      getPages: AppPages.pages,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.system,
    );
  }
}