import 'package:get_it/get_it.dart';
import 'package:home_work/blocs/auth_bloc/auth_bloc_cubit.dart';
import 'package:home_work/blocs/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:home_work/blocs/forward_sheet_bloc/forward_sheet_bloc.dart';
import 'package:home_work/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:home_work/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:home_work/blocs/search_screen_bloc/search_screen_cubit.dart';
import 'package:home_work/blocs/settings_screen_bloc/settings_cubit.dart';
import 'package:home_work/core/chat_repository.dart';
import 'package:home_work/core/data_storage.dart';
import 'package:home_work/core/message_repository.dart';
import 'package:home_work/core/shared_pref.dart';
import 'package:home_work/data/data_storage_impl.dart';
import 'package:home_work/data/data_storage_repository_impl.dart';
import 'package:home_work/widgets/shared_pref_impl.dart';

void setUpGetIt() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<SharedPref>(SharedPrefImpl());

  getIt.registerSingleton<DataStorage>(DataStorageImpl.instance);

  getIt.registerSingleton<MessageRepository>(
    DataStorageRepositoryImpl(
      getIt<DataStorage>(),
    ),
  );

  getIt.registerSingleton<ChatRepository>(
    DataStorageRepositoryImpl(
      getIt<DataStorage>(),
    ),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      pref: getIt<SharedPref>(),
    ),
  );

  getIt.registerFactoryParam<ChatScreenCubit, int, void>(
    (chatId, _) => ChatScreenCubit(
      chatId: chatId,
      repository: getIt<MessageRepository>(),
      pref: getIt<SharedPref>(),
    ),
  );

  getIt.registerFactoryParam<ForwardSheetCubit, int, void>(
    (chatId, _) => ForwardSheetCubit(
      chatId: chatId,
      messageRepository: getIt<MessageRepository>(),
      chatRepository: getIt<ChatRepository>(),
    ),
  );

  getIt.registerFactory<HomeScreenCubit>(
    () => HomeScreenCubit(
      repository: getIt<ChatRepository>(),
    ),
  );

  getIt.registerFactoryParam<ImagePickerCubit, int, void>(
    (chatId, _) => ImagePickerCubit(
      chatId: chatId,
      repository: getIt<MessageRepository>(),
    ),
  );

  getIt.registerFactory<SearchScreenCubit>(
    () => SearchScreenCubit(
      repository: getIt<MessageRepository>(),
    ),
  );

  getIt.registerFactory<SettingsScreenCubit>(
    () => SettingsScreenCubit(
      pref: getIt<SharedPref>(),
    ),
  );
}
