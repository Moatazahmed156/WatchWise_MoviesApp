import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int page;
  final void Function(bool isNext) onPageChanged;
  final bool canGoBack;

  const PaginationControls({
    super.key,
    required this.page,
    required this.onPageChanged,
    required this.canGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: canGoBack ? () => onPageChanged(false) : null,
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          Text('$page'),
          TextButton(
            onPressed: () => onPageChanged(true),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
