import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../app/router/app_routes.dart';
import '../../extensions/l10n_extension.dart';
import '../../extensions/theme_extension.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
    required this.state,
  });

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _Label404(),
                    const _NotFoundTitle(),
                    const SizedBox(height: 16),
                    _NotFoundUrl(state: state),
                    const SizedBox(height: 16),
                    const _NotFoundMessage(),
                    const SizedBox(height: 20),
                    const _NotFoundButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Label404 extends StatelessWidget {
  const _Label404();

  @override
  Widget build(BuildContext context) {
    return Text(
      '404',
      style: context.textTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.bold,
        letterSpacing: 12,
      ),
    );
  }
}

class _NotFoundTitle extends StatelessWidget {
  const _NotFoundTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.notFoundTitle,
      style: context.textTheme.headlineSmall,
      textAlign: TextAlign.center,
    );
  }
}

class _NotFoundUrl extends StatelessWidget {
  const _NotFoundUrl({
    required this.state,
  });

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      color: context.colorScheme.surfaceContainerHighest,
      borderRadius: .circular(12),
    );

    return Container(
      width: .infinity,
      padding: const .all(12),
      decoration: boxDecoration,
      child: SelectableText(
        state.uri.toString(),
        style: context.textTheme.labelMedium,
        textAlign: .center,
      ),
    );
  }
}

class _NotFoundMessage extends StatelessWidget {
  const _NotFoundMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.notFoundMessage,
      style: context.textTheme.bodyLarge?.copyWith(
        color: context.colorScheme.onSurfaceVariant,
      ),
      textAlign: .center,
    );
  }
}

class _NotFoundButton extends StatelessWidget {
  const _NotFoundButton();

  @override
  Widget build(BuildContext context) {
    void onPressed() {
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed(AppRoutes.home);
      }
    }

    IconData icon = context.canPop() ? Symbols.arrow_back : Symbols.home;
    String label = context.canPop() ? context.l10n.notFoundGoBack : context.l10n.notFoundGoHome;

    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
