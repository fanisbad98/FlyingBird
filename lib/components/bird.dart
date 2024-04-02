import 'package:bird/game/assets.dart';
import 'package:bird/game/bird_game.dart';
import 'package:bird/game/bird_movement.dart';
import 'package:bird/game/configure.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';


class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<BirdGame>, CollisionCallbacks{
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdmidflap);
    final birdUpFlap = await gameRef.loadSprite (Assets.birdupflap);
    final birdDownFlap =  await gameRef.loadSprite(Assets.birddownflap);

    gameRef.bird;

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y/2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.down: birdDownFlap,
      BirdMovement.up: birdUpFlap,
    };

    add(CircleHitbox());

  }

  @override
  void update (double dt){
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if(position.y <1){
      gameOver();
    }
  }


  void fly() {
    add(
      MoveByEffect(
        Vector2(0, -Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );

    FlameAudio.play(Assets.flying);
    current = BirdMovement.up;   
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, 
    PositionComponent other,
  ){
    super.onCollisionStart(intersectionPoints, other);

    gameOver();
  }



  void reset(){
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }



  void gameOver() {
    FlameAudio.play(Assets.collision);
    game.isHit = true;
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }
  
}