import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/providers/ingredients/ingredients_provider.dart';
import 'package:mealtime/utils/constants.dart';
import 'package:mealtime/widgets/error_display.dart';
import 'package:misc_utils/misc_utils.dart';

class IngredientsScreen extends ConsumerWidget {
  final ScrollController scrollController;

  const IngredientsScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasIngredients = ref.watch(hasIngredientsProvider);
    final ingredients = ref.watch(ingredientsProvider);
    final totalIngredients = ref.watch(ingredientCountProvider);

    return SafeArea(
      child: hasIngredients.when(
        skipLoadingOnReload: true,
        data: (hasIngredients) => RefreshIndicator(
          onRefresh: () => ref.refresh(ingredientsProvider.future),
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: scrollController,
            physics: !hasIngredients
                ? const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  )
                : null,
            slivers: [
              if (!hasIngredients)
                // SliverFancyImageHeader(
                //   imagePath: ImageAssets.gamePile.value,
                //   height: 300.0,
                // ),
                SliverToBoxAdapter(
                  child: Placeholder(),
                ),
              if (!hasIngredients)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingX,
                      vertical: 16.0,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!
                          .buildYourPileOfShameByAddingNewGames,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (hasIngredients)
                ...ingredients.when(
                  skipLoadingOnReload: true,
                  data: (ingredients) {
                    return ingredients.map(
                      (ingredient) => SliverToBoxAdapter(
                        child: ListTile(
                          title: Text(ingredient.name),
                          subtitle: Text(ingredient.id),
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => [
                    SliverToBoxAdapter(
                      child: ErrorDisplay(
                        error: error,
                        stackTrace: stackTrace,
                      ),
                    ),
                  ],
                  loading: () => [
                    SliverList.builder(
                      itemBuilder: (context, index) => const Skeleton()
                          .animate()
                          .fade(curve: Curves.easeOut, duration: 130.ms),
                      itemCount: 10,
                    ),
                  ],
                ),
              if (hasIngredients)
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            totalIngredients.when(
                              data: (data) => "Total ingredients: $data",
                              loading: () => "",
                              error: (error, stackTrace) => error.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        loading: () => CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) => const Skeleton(),
              itemCount: 10,
            ),
          ],
        ).animate().fadeIn(),
        error: (error, stackTrace) => ErrorDisplay(
          error: error,
          stackTrace: stackTrace,
        ).animate().fadeIn(),
      ),
    );
  }
}
