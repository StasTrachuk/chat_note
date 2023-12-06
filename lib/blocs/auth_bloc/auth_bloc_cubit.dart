import 'package:bloc/bloc.dart';
import 'package:home_work/core/shared_pref.dart';
import 'package:local_auth/local_auth.dart';

part 'auth_bloc_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SharedPref pref;
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAuthSettingEnabled = false;
  bool _isAuthComplete = false;
  List availableBiometrics = [];

  AuthCubit({required this.pref}) : super(AuthInitial()) {
    authenticate();
  }

  void authenticate() async {
    emit(AuthLoading());

    try {
      _isAuthSettingEnabled = await pref.getAuthSetting();

      if (_isAuthSettingEnabled) {
        //biometrics supports or not
        bool canCheckBiometrics = await _auth.canCheckBiometrics;

        availableBiometrics = await _auth.getAvailableBiometrics();

        if (availableBiometrics.isEmpty) {
          throw Exception("No available biometric methods.");
        }

        if (canCheckBiometrics &&
            _isAuthSettingEnabled &&
            availableBiometrics.isNotEmpty) {
          _isAuthComplete = await _startBioAuth();

          emit(
            AuthLoaded(
              isAuthComplete: _isAuthComplete,
              isBiometricsAvailable: canCheckBiometrics,
            ),
          );
        }
      } else {
        emit(
          AuthLoaded(
            isAuthComplete: true,
            isBiometricsAvailable: false,
          ),
        );
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<bool> _startBioAuth() async {
    return await _auth.authenticate(
      localizedReason: 'Face ID',
      options: const AuthenticationOptions(
        biometricOnly: true,
        useErrorDialogs: false,
        stickyAuth: true,
      ),
    );
  }
}
