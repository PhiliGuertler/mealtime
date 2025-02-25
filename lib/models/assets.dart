enum ImageAssets {
  // App
  appLogo(value: 'assets/app/logo.png'),
  appLogoForeground(value: 'assets/app/logo_foreground.png'),
  appLogoSplash(value: 'assets/app/logo_splash.png'),
  // Images
  calendar(value: 'assets/iamges/calendar.jpg'),
  ingredients(value: 'assets/images/ingredients.jpg'),
  intolerance(value: 'assets/images/intolerance.jpg'),
  recipe(value: 'assets/images/recipe.jpg'),
  search(value: 'assets/images/search.jpg'),
  settings(value: 'assets/images/settings.jpg'),
  ;

  final String value;

  const ImageAssets({required this.value});
}
