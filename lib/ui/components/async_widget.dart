import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AsyncWidget<T> extends StatelessWidget {
  const AsyncWidget(
      {super.key, required this.value, required this.data, this.retry});

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? retry;
  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, s) {
        debugPrint('$e');
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("$e"),
                if (retry != null) ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: retry,
                    child:  const Text("Retry"),
                  ),
                ]
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class AsyncPage<T> extends StatelessWidget {
  const AsyncPage(
      {super.key, required this.value, required this.data, this.retry});

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? retry;
  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, s) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("$e"),
                  if (retry != null) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: retry,
                      child: const Text("Retry"),
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
