import 'package:bird/game/bird_game.dart';
import 'package:flutter/material.dart';
import 'package:bird/game/assets.dart';


class GameOVerScreen extends StatelessWidget {
  final BirdGame game;

  const GameOVerScreen({Key? key,required this.game}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${game.bird.score}',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: 'Game',
                ),
            ),
            Image.asset(Assets.gameOver),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Restart',
              style: TextStyle(fontSize:20),
              ),
            ),
          ],
        ),
      ),  
    );
  }

  void onRestart(){
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}