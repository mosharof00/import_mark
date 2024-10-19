enum AppFlavor { user, admin }

class AppConfig {
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
  if (AppConfig.appFlavor == AppFlavor.user) {
    return 'user';
  }
  if (AppConfig.appFlavor == AppFlavor.admin) {
    return 'admin';
  }
  return '';
}

bool isStudent() {
  return AppConfig.appFlavor == AppFlavor.user;
}

bool isTeacher() {
  return AppConfig.appFlavor == AppFlavor.admin;
}
