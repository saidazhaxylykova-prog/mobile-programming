import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../l10n/app_localizations.dart';
import '../blocs/api/api_cubit.dart';
import '../blocs/api/api_state.dart';
import '../core/constants/app_colors.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.exploreTitle)),
      body: BlocBuilder<ApiCubit, ApiState>(
        builder: (context, state) {
          if (state.loading && state.reasons.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.reasons.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.error!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ApiCubit>().loadReasons(),
                      child: Text(t.retry),
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            color: AppColors.pinkDeep,
            onRefresh: () => context.read<ApiCubit>().loadReasons(),
            child: state.reasons.isEmpty
                ? ListView(
                    children: [
                      const SizedBox(height: 200),
                      Center(child: Text(t.exploreEmpty)),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.reasons.length,
                    itemBuilder: (context, i) {
                      final reason = state.reasons[i];
                      return TweenAnimationBuilder<double>(
                        duration: Duration(
                            milliseconds: 250 + (i * 30).clamp(0, 240)),
                        curve: Curves.easeOutCubic,
                        tween: Tween(begin: 0, end: 1),
                        builder: (context, v, child) => Opacity(
                          opacity: v,
                          child: Transform.translate(
                            offset: Offset(0, 16 * (1 - v)),
                            child: child,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              gradient: AppColors.gradientSoft,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.format_quote_rounded,
                                      color: AppColors.pinkDeep),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      reason,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
