part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class ChangeAppLocaleState extends SettingsState {}
final class LogoutState extends SettingsState {}
final class ChangeAppThemeState extends SettingsState {}
final class GetCurrentTheme extends SettingsState {}
final class GetCurrentLocale extends SettingsState {}
