abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeChangeCurrentIndex extends HomeState {}

class ChangeCurrentPosition extends HomeState {}

class ChangeMyCoordinates extends HomeState {}

class ChangeCalculationParameters extends HomeState {}

class ChangePrayerList extends HomeState {}

class ChangeCountTasbih extends HomeState {}

class RestartCountTasbih extends HomeState {}

class ChangeItemTasbih extends HomeState {}

class ChangeSound extends HomeState {}

class ChangeTextSize extends HomeState {}

class EmptyPryerList extends HomeState {}

class LoadingGetCurrentPosition extends HomeState {}

class ChangeTheme extends HomeState {}

class ChangeColorApp extends HomeState {}

class ReadAzkarState extends HomeState {}

class DeleteAzkarState extends HomeState {}

class UpdateAzkarState extends HomeState {}

class CreateAzkarState extends HomeState {}

class LoadingAzkarState extends HomeState {}

class RunRadiosState extends HomeState {}

class StopRadioState extends HomeState {}

class ChangeRadioState extends HomeState {}

class GetSearchOfAya extends HomeState {
  final List result;

  GetSearchOfAya({required this.result});
}

class RunAudioOfAyaLoading extends HomeState {}

class GetAudioOfAya extends HomeState {}

class ChangeAyaIndex extends HomeState {}

class ChangeAllNotification extends HomeState {}

class HourlyNotificationItem extends HomeState {}
