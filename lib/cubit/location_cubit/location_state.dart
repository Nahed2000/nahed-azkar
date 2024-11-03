abstract class LocationState {}

class LocationInitialState extends LocationState {}

class LocationLoadingState extends LocationState {}

class ChangePrayerList extends LocationState {}

class EmptyPryerList extends LocationState {}

class ChangeCalculationParameters extends LocationState {}

class ChangeMyCoordinates extends LocationState {}

class SuccessfullyGetLocationState extends LocationState {}

class FailedLocationState extends LocationState {}
