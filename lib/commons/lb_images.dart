class LbImages {

  LbImages._();

  static const splash1 = 'assets/images/splash/splash1.jfif';
  static const splash2 = 'assets/images/splash/splash2.jfif';
  static const splash3 = 'assets/images/splash/splash3.jfif';
  static const splash4 = 'assets/images/splash/splash4.jfif';
  static const splash5 = 'assets/images/splash/splash5.jfif';

}

extension LbImagesUtil on LbImages {

  static const List<String> splashImages = [
    LbImages.splash1,
    LbImages.splash2,
    LbImages.splash3,
    LbImages.splash4,
    LbImages.splash5,
  ];

}