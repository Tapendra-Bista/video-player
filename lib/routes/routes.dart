  import 'package:flutter/material.dart';
import 'package:video/select/select.dart';
import 'package:video/settings/settings.dart';

Map<String, WidgetBuilder> get routes {
    return {
      Settings.settingsName : (_)=> const Settings(),
      Select.selectName :(_)=> const Select(),

    };
  }