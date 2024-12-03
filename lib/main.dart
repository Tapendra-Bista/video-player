import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_select/select_bloc.dart';
import 'package:video/bloc/bloc_for_sort/sort_bloc.dart';
import 'package:video/bloc/bloc_for_switch/bloc.dart';
import 'package:video/bloc/selected_video/selected_video_bloc.dart';
import 'package:video/bloc/videos_and_folders/bloc.dart';
import 'package:video/routes/routes.dart';
import 'package:video/theme/theme.dart';
import 'package:video/videos/videos.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: Platform.isWindows
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTheme theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SelectedVideoBloc()),
        BlocProvider(create: (_) => SelectBloc()),
        BlocProvider(create: (_) => SortBloc()),
        BlocProvider(create: (_) => VFBloc()),
        BlocProvider(create: (_) => SwitchBloc())
      ],
      child: MaterialApp(
          title: Strings.appName,
          routes: routes,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          home: const Videos(
            initialIndex: 0,
          )),
    );
  }
}
