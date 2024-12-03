import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video/app_strings/strings.dart';
import 'package:video/bloc/bloc_for_switch/bloc.dart';
import 'package:video/bloc/bloc_for_switch/event.dart';
import 'package:video/bloc/bloc_for_switch/state.dart';
import 'package:video/constant/button.dart';
import 'package:video/constant/divider.dart';

class Settings extends StatelessWidget {
  static const settingsName = Strings.settingsRouteStrings;
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leadingWidth: double.maxFinite,
        leading: Row(children: [
          button(context, Icons.arrow_back_ios_outlined, Strings.backString,
              () {
            Navigator.pop(context);
          }),
          Text(
            Strings.settingsStrings,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appDivider(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SwitchBloc, SwitchState>(builder: (context, state) {
                  if (state is SwitchOnState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Text(Strings.autoplayString,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 18)),
                          trailing: SizedBox(
                            height: 4,
                            width: 60,
                            child: Switch(
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.white,
                                activeColor: Colors.red,
                                value: state.forAutoplay,
                                onChanged: (value) {
                                  context
                                      .read<SwitchBloc>()
                                      .add(SwitchOnEvent(value,state.forLooping));
                                }),
                          ),
                        ),
                         ListTile(
                      leading: Text(Strings.loopValue,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontSize: 18)),
                      trailing: SizedBox(
                        height: 4,
                        width: 60,
                        child: Switch(
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.white,
                            activeColor: Colors.red,
                            value: state.forLooping,
                            onChanged: (value) {
                              context
                                  .read<SwitchBloc>()
                                  .add(SwitchOnEvent(state.forAutoplay,value));
                            }),
                      ),
                    )
                      ],
                    );
                  } else if (state is InitialState) {
                    
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Text(Strings.autoplayString,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 18)),
                          trailing: SizedBox(
                            height: 4,
                            width: 60,
                            child: Switch(
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.white,
                                activeColor: Colors.red,
                                value: state.forAutoplay,
                                onChanged: (value) {
                                  context
                                      .read<SwitchBloc>()
                                      .add(SwitchOnEvent(value,state.forLooping));
                                }),
                          ),
                        ),
                         ListTile(
                      leading: Text(Strings.loopValue,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontSize: 18)),
                      trailing: SizedBox(
                        height: 4,
                        width: 60,
                        child: Switch(
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.white,
                            activeColor: Colors.red,
                            value: state.forLooping,
                            onChanged: (value) {
                              context
                                  .read<SwitchBloc>()
                                  .add(SwitchOnEvent(state.forAutoplay,value));
                            }),
                      ),
                    )
                      ],
                    );
                  }

                  return const SizedBox();
                }),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).popupMenuTheme.color,
                        content: Center(
                          child: Text(Strings.noUpdateString,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 12)),
                        )));
                  },
                  child: ListTile(
                    title: Text(Strings.updatesString,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 18)),
                    subtitle: Text(Strings.versionString,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .color)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
