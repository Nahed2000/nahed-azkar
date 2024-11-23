abstract class PrayerTimeState {}

class PrayerTimeInitialState extends PrayerTimeState {}

class PrayerTimeLoadingState extends PrayerTimeState {}

class ChangePrayerList extends PrayerTimeState {}

class EmptyPryerList extends PrayerTimeState {}

class ChangeCalculationParameters extends PrayerTimeState {}

class ChangeMyCoordinates extends PrayerTimeState {}

class SuccessfullyGetPrayerTimeState extends PrayerTimeState {}

class FailedPrayerTimeState extends PrayerTimeState {}

class StartTimerPrayerTimeState extends PrayerTimeState {}

class StopPrayerTimeState extends PrayerTimeState {}
