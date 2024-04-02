import 'package:flutter/painting.dart';
import 'package:bird/components/backround.dart';
import 'package:bird/components/bird.dart';
import 'package:bird/components/ground.dart';
import 'package:bird/components/pipe_group.dart';
import 'package:bird/game/configure.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BirdGame extends FlameGame with TapDetector, HasCollisionDetection{
   
  BirdGame();

  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score; 
  @override 
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore(){
    return TextComponent(
      position: Vector2(size.x / 2, size.y /2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Game'),         
        ),
      );
  }

  @override
  void onTap() {
    bird.fly();
  }


  @override
  void update (double dt){
    super.update (dt);
    interval.update(dt);


    score.text = 'Score: ${bird.score}';
  }
}