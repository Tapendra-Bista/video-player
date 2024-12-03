import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/videos_and_folders/bloc.dart';
import 'package:video/bloc/videos_and_folders/state.dart';
import 'package:video/settings/settings.dart';
import 'package:video/sort/menu.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VFBloc, VFState>(builder: (context, state) {
      if (state is VFOnState) {
        if (state.indexValue == 0) {
          return PopupMenuButton(
            tooltip: Strings.tooltipMore,
            onSelected: (value) {
              if (value == Strings.settingsStringsValue) {
                Navigator.pushNamed(context, Settings.settingsName);
              }
            },
            color: Theme.of(context).popupMenuTheme.color,
            iconColor: Theme.of(context).iconTheme.color,
            shape: Theme.of(context).popupMenuTheme.shape,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: Strings.sortStringsValue,
                child: Menu(),
              ),
              PopupMenuItem(
                value: Strings.settingsStringsValue,
                child: ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    size: Theme.of(context).iconTheme.size,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    Strings.settingsStrings,
                    style: TextStyle(color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
            ],
          );
        } else if (state.indexValue == 1) {
          return PopupMenuButton(
               tooltip: Strings.tooltipMore,
            onSelected: (value) {
              if (value == Strings.settingsStringsValue) {
                Navigator.pushNamed(context, Settings.settingsName);
              }
            },
            color: Theme.of(context).popupMenuTheme.color,
            iconColor: Theme.of(context).iconTheme.color,
            shape: Theme.of(context).popupMenuTheme.shape,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: Strings.settingsStringsValue,
                child: ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    size: Theme.of(context).iconTheme.size,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    Strings.settingsStrings,
                    style: TextStyle(color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ),
            ],
          );
        }
      } else if (state is InitialState) {
        return PopupMenuButton(
             tooltip: Strings.tooltipMore,
          onSelected: (value) {
            if (value == Strings.settingsStringsValue) {
              Navigator.pushNamed(context, Settings.settingsName);
            }
          },
          color: Theme.of(context).popupMenuTheme.color,
          iconColor: Theme.of(context).iconTheme.color,
          shape: Theme.of(context).popupMenuTheme.shape,
          itemBuilder: (_) => [
            const PopupMenuItem(
              enabled: true,
              value: Strings.sortStringsValue,
              child: Menu(),
            ),
            PopupMenuItem(
              value: Strings.settingsStringsValue,
              child: ListTile(
                leading: Icon(
                  Icons.settings_outlined,
                  size: Theme.of(context).iconTheme.size,
                  color: Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  Strings.settingsStrings,
                  style: TextStyle(color: Theme.of(context).iconTheme.color),
                ),
              ),
            ),
          ],
        );
      }

      return const SizedBox();
    });
  }
}
