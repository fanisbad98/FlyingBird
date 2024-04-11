import 'package:bird/game/bird_game.dart';
import 'package:bird/screens/main_menu_screen.dart';
import 'package:bird/screens/game_over_sceen.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  final game = BirdGame();

  // Initialize the banner ad object
  final bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Replace with your Ad Unit ID
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (ad, error) {
        print('Failed to load banner ad: $error');
      },
    ),
  );

  // Load the banner ad
  await bannerAd.load();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
              initialActiveOverlays: const [MainMenuScreen.id],
              overlayBuilderMap: {
                'mainMenu': (context, _) => MainMenuScreen(game: game),
                'gameOver': (context, _) => GameOverScreen(game: game),
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                width: bannerAd.size.width.toDouble(),
                height: bannerAd.size.height.toDouble(),
                child: AdWidget(ad: bannerAd),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}