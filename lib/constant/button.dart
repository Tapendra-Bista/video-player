  import 'package:flutter/material.dart';

IconButton button(BuildContext context,IconData icons,String tooltip, Function() onPressed) {
    return IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            tooltip: tooltip,
            onPressed:onPressed,
            icon: Icon(
              icons,
              size: Theme.of(context).iconTheme.size,
              color: Theme.of(context).iconTheme.color,
            ));
  }