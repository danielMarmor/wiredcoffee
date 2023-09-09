import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiredcoffee/providers/loadingIndicatorProvider.dart';

class LoadedScaffoldBody extends StatefulWidget {
  final Widget child;
  const LoadedScaffoldBody({super.key, required this.child});

  @override
  State<LoadedScaffoldBody> createState() => _LoadedScaffoldBodyState();
}

class _LoadedScaffoldBodyState extends State<LoadedScaffoldBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            widget.child,
            ValueListenableBuilder<bool>(
                valueListenable: LoadingIndicatorProvider.loading,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                })
          ],
        ));
  }
}
