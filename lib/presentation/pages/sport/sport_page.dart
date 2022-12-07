import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template_demo/model/entities/sport_cat_entity.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../common/gen/assets.gen.dart';
import '../../../common/gen/colors.gen.dart';
import '../../../model/use_cases/sport_view_model.dart';
import '../../custom_hooks/use_effect_once.dart';
import '../../custom_hooks/use_refresh_controller.dart';
import '../../widgets/smart_refresher_custom.dart';
import '../../widgets/thumbnail.dart';
import '../../widgets/error_message.dart';

class SportPage extends HookConsumerWidget {
  const SportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sportViewModel = ref.watch(sportViewModelProvider);
    final scrollController = useScrollController();
    final refreshController = useRefreshController();
    final width = MediaQuery.of(context).size.width;
    useEffectOnce(() {
      Future(() async {
        await ref.read(sportViewModelProvider.notifier).fetch();
      });
      return null;
    });
    return Scaffold(
      body: sportViewModel.when(
        loading: () => buildLoading(),
        data: (items) {
          return buildData(
              ref, width, refreshController, scrollController, items);
        },
        error: (e, _) => buildErrorMessage(ref, e),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget buildData(
    WidgetRef ref,
    double width,
    RefreshController refreshController,
    ScrollController scrollController,
    List<SportCatEntity> items,
  ) {
    return Column(
      children: [
        Assets.images.iconTopBar.image(
          width: width,
          height: width * 271 / 1080,
          fit: BoxFit.fill,
        ),
        Expanded(
          child: SmartRefresher(
            header: const SmartRefreshHeader(),
            footer: const SmartRefreshFooter(),
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            physics: const BouncingScrollPhysics(),
            onRefresh: () async {
              await ref.read(sportViewModelProvider.notifier).fetch();
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await ref.read(sportViewModelProvider.notifier).fetchMore();
              refreshController.loadComplete();
            },
            child: ListView.separated(
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                final data = items[index];
                return Container(
                  width: width,
                  height: 100,
                  color: ColorName.cFF222222,
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      CircleThumbnail(
                        size: 68,
                        url: data.url,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(flex: 2),
                            Text(
                              data.id ?? '',
                              style: const TextStyle(
                                color: ColorName.cFF464646,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                data.url ?? '-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: ColorName.cFF464646,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  color: ColorName.c30FFFFFF,
                );
              },
              itemCount: items.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildErrorMessage(
    WidgetRef ref,
    Object e,
  ) {
    return ErrorMessage(
      message: e.toString(),
      onTapRetry: () async {
        await ref.read(sportViewModelProvider.notifier).fetch();
      },
    );
  }
}
