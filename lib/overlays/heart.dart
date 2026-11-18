import 'package:ember_quest/ember_quest.dart';
import 'package:flame/components.dart';

enum HeartState {
  available,
  unavailable,
}//end of HeartState

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameReference<EmberQuestGame> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });//end of constructor

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite(
      'heart.png',
      srcSize: Vector2.all(32),
    );

    final unavailableSprite = await game.loadSprite(
      'heart_half.png',
      srcSize: Vector2.all(32),
    );

    sprites = {
      HeartState.available: availableSprite,
      HeartState.unavailable: unavailableSprite,
    };//end of sprites

    current = HeartState.available;
  }//end of onLoad

  @override
  void update(double dt) {
    if (game.health < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    super.update(dt);
  }//end of update
}//end of HeartHealthComponent