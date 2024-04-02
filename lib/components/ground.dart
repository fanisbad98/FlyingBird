import 'package:bird/game/assets.dart';
import 'package:bird/game/bird_game.dart';
import 'package:bird/game/configure.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';

class Ground extends ParallaxComponent<BirdGame> with HasGameRef<BirdGame>{
  Ground();


  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(Assets.ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);

    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - Config.groundHeight),
        size: Vector2(gameRef.size.x, Config.groundHeight),
      ),
    );
  }
  @override
  void update(double dt){
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}