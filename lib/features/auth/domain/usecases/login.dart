import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';

/// Signs in with a WhatsApp number and app password.
class Login {
  const Login(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({required PhoneNumber phone, required String appPassword}) async {
    if (phone.isBlank) {
      return const Err(ValidationFailure('Enter your WhatsApp number.', field: 'whatsapp_number'));
    }
    if (appPassword.isEmpty) {
      return const Err(ValidationFailure('Enter your app password.', field: 'app_password'));
    }
    return await _repository.login(phone: phone, appPassword: appPassword);
  }
}
