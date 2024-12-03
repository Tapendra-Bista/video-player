import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_sort/sort_bloc.dart';
import 'package:video/bloc/bloc_for_sort/sort_event.dart';
import 'package:video/bloc/bloc_for_sort/sort_state.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortBloc, SortState>(builder: (context, state) {
      if (state is InitialSortState) {
        return Builder(builder: (BuildContext secondContext) {
          return GestureDetector(
            onTap: () {
              showMenu(
                initialValue: state.sortBy,
                context: secondContext,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem(
                    onTap: () async{

                      secondContext
                          .read<SortBloc>()
                          .add(SortWayChangedEvent(Strings.defaultStringValue));

                      Navigator.pop(context);
                    },
                    value: Strings.defaultStringValue,
                    child: Text(
                      Strings.defaultString,
                      style: TextStyle(
                          color: Theme.of(secondContext).iconTheme.color),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      secondContext
                          .read<SortBloc>()
                          .add(SortWayChangedEvent(Strings.nameStringValue));
                      Navigator.pop(context);
                    },
                    value: Strings.nameStringValue,
                    child: Text(
                    Strings.nameString,
                      style: TextStyle(
                          color: Theme.of(secondContext).iconTheme.color),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      secondContext
                          .read<SortBloc>()
                          .add(SortWayChangedEvent(Strings.sizeStringValue));
                      Navigator.pop(context);
                    },
                    value: Strings.sizeStringValue,
                    child: Text(
                      Strings.sizeString,
                      style: TextStyle(
                          color: Theme.of(secondContext).iconTheme.color),
                    ),
                  ),
                ],
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.sort_outlined,
                size: Theme.of(secondContext).iconTheme.size,
                color: Theme.of(secondContext).iconTheme.color,
              ),
              title: Text(
                Strings.sortString,
                style:
                    TextStyle(color: Theme.of(secondContext).iconTheme.color),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Theme.of(secondContext).iconTheme.color,
              ),
            ),
          );
        });
      } else if (state is SortWayChangedState) {
        return Builder(builder: (BuildContext secondContext) {
          return GestureDetector(
            onTap: () {
              showMenu(
                initialValue: state.sortBy,
                context: secondContext,
                position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem(
                    onTap: () {
                      secondContext
                          .read<SortBloc>()
                          .add(SortWayChangedEvent(Strings.defaultStringValue));
                      Navigator.pop(context);
                    },
                    value:Strings.defaultStringValue,
                    child: Text(
                      Strings.defaultString,
                      style: TextStyle(
                          color: Theme.of(secondContext).iconTheme.color),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      secondContext
                          .read<SortBloc>()
                          .add(SortWayChangedEvent(Strings.nameStringValue));
                      Navigator.pop(context);
                    },
                    value: Strings.nameStringValue,
                    child: Text(
                      Strings.nameString,
                      style: TextStyle(
                          color: Theme.of(secondContext).iconTheme.color),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      secondContext
                          .read<SortBloc>()
                          .add(SortWayChangedEvent(Strings.sizeStringValue));
                      Navigator.pop(context);
                    },
                    value: Strings.sizeStringValue,
                    child: Text(
                      Strings.sizeString,
                      style: TextStyle(
                          color: Theme.of(secondContext).iconTheme.color),
                    ),
                  ),
                ],
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.sort_outlined,
                size: Theme.of(secondContext).iconTheme.size,
                color: Theme.of(secondContext).iconTheme.color,
              ),
              title: Text(
                Strings.sortString,
                style:
                    TextStyle(color: Theme.of(secondContext).iconTheme.color),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Theme.of(secondContext).iconTheme.color,
              ),
            ),
          );
        });
      }
      return const SizedBox();
    });
  }
}
