import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkDestination {
  const LinkDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<LinkDestination> destinations = <LinkDestination>[
  LinkDestination(
      'Explore',
      Icon(Icons.explore_outlined),
      Icon(
        Icons.explore,
        color: Colors.white,
      )),
  LinkDestination('Live Chat', Icon(Icons.chat_bubble_outline),
      Icon(Icons.chat_bubble, color: Colors.white)),
  LinkDestination('Gallery', Icon(Icons.image_outlined),
      Icon(Icons.image, color: Colors.white)),
  LinkDestination('Wish List', FaIcon(FontAwesomeIcons.heart),
      FaIcon(FontAwesomeIcons.solidHeart, color: Colors.white)),
  LinkDestination('E-Magazine', Icon(Icons.chrome_reader_mode_outlined),
      Icon(Icons.chrome_reader_mode, color: Colors.white)),
];
