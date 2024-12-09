enum AppFlavor { user, admin }

class AppConfiguration {
  static AppFlavor appFlavor = AppFlavor.user;
}

AppFlavor getAppFlavor(String appType) {
  switch (appType) {
    case 'user':
      return AppFlavor.user;
    case 'admin':
      return AppFlavor.admin;
    default:
      return AppFlavor.user;
  }
}

String getAppFlavorName() {
  if (AppConfiguration.appFlavor == AppFlavor.user) {
    return 'user';
  }
  if (AppConfiguration.appFlavor == AppFlavor.admin) {
    return 'admin';
  }
  return '';
}

bool isStudent() {
  return AppConfiguration.appFlavor == AppFlavor.user;
}

bool isTeacher() {
  return AppConfiguration.appFlavor == AppFlavor.admin;
}
