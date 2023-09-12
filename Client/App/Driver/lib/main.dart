import 'package:driver/global/languages/base_language.dart';
import 'package:driver/global/models/chat/chat_model.dart';
import 'package:driver/global/models/language/language_model.dart';
import 'package:driver/global/services/bloc/auth/auth_bloc.dart';
import 'package:driver/global/services/bloc/auth/auth_event.dart';
import 'package:driver/global/services/bloc/auth/auth_state.dart';
import 'package:driver/global/services/general/auth/database_auth_provider.dart';
import 'package:driver/global/services/general/socket/socket_booking_service.dart';
import 'package:driver/global/themes/app_theme.dart';
import 'package:driver/global/utils/helpers/loading/loading_screen.dart';
import 'package:driver/modules/authentication/login/login_view.dart';
import 'package:driver/modules/authentication/register/register_view.dart';
import 'package:driver/modules/home/home_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

List<LanguageModel> localeLanguageList = [];
late FlutterSecureStorage secureStorage;
late BaseLanguage language;
late final BookingSocket bookingSocket;
late final ChatModel chat;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void main() async {
  secureStorage = const FlutterSecureStorage();
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  bookingSocket = BookingSocket();
  chat = ChatModel();
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider(
          create: (context) => AuthBloc(DatabaseAuthProvider()),
          child: Scaffold(
            key: scaffoldKey,
            body: const HomePage(),
          )),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthInitialEvent());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: 'Please wait...',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthInitial:
            return const LoginView();
          case AuthLoggedInState:
            return const HomeBuilder();
          case AuthRegisteredState:
            return const RegisterView();
          default:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}
