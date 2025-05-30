


import 'package:flame/components.dart';
import 'package:flutter_game_test/card_game/card_game.dart';
import 'package:flutter_game_test/card_game/compnents/card.dart';

import '../utils/pile.dart';

// class Waste extends PositionComponent {
//   @override
//   bool get debugMode => true;
// }




class WastePile extends PositionComponent implements Pile {
  WastePile({super.position}) : super(size: CardGame.cardSize);

  final List<Card> _cards = [];
  final Vector2 _fanOffset = Vector2(CardGame.cardWidth * 0.2, 0);

  //#region Pile API

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  @override
  bool canAcceptCard(Card card) => false;

  @override
  void removeCard(Card card) {
    assert(canMoveCard(card));
    _cards.removeLast();
    _fanOutTopCards();
  }

  @override
  void returnCard(Card card) {
    card.priority = _cards.indexOf(card);
    _fanOutTopCards();
  }

  @override
  void acquireCard(Card card) {
    assert(card.isFaceUp);
    card.pile = this;
    card.position = position;
    card.priority = _cards.length;
    _cards.add(card);
    _fanOutTopCards();
  }

  //#endregion

  List<Card> removeAllCards() {
    final cards = _cards.toList();
    _cards.clear();
    return cards;
  }

  void _fanOutTopCards() {
    final n = _cards.length;
    for (var i = 0; i < n; i++) {
      _cards[i].position = position;
    }
    if (n == 2) {
      _cards[1].position.add(_fanOffset);
    } else if (n >= 3) {
      _cards[n - 2].position.add(_fanOffset);
      _cards[n - 1].position.addScaled(_fanOffset, 2);
    }
  }
}