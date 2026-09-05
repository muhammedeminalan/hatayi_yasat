import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:life_shared/life_shared.dart';
import 'package:lifeclient/core/theme/app_colors.dart';
import 'package:lifeclient/core/theme/app_radius.dart';
import 'package:lifeclient/core/theme/app_shadows.dart';
import 'package:lifeclient/core/theme/app_spacing.dart';
import 'package:lifeclient/core/theme/app_text.dart';
import 'package:lifeclient/product/generated/assets.gen.dart';
import 'package:lifeclient/product/init/language/locale_keys.g.dart';
import 'package:lifeclient/product/package/image/custom_network_image.dart';
import 'package:lifeclient/product/utility/decorations/empty_box.dart';
import 'package:lifeclient/product/widget/button/open_url_general_button.dart';
import 'package:lifeclient/product/widget/button/share_advertisement_general_button.dart';
import 'package:lifeclient/product/widget/general/index.dart';
import 'package:lifeclient/sub_feature/advertisement_board/provider/advertisement_board_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

part 'advertisement_board_item.dart';
part 'advertisement_detail_view.dart';

final class AdvertisementBoardView extends ConsumerStatefulWidget {
  const AdvertisementBoardView({super.key});

  @override
  ConsumerState<AdvertisementBoardView> createState() =>
      _AdvertisementBoardViewState();
}

final class _AdvertisementBoardViewState
    extends ConsumerState<AdvertisementBoardView>
    with _AdvertisementBoardViewMixin {
  static const double _aspectRatio = 16 / 9;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(advertisementBoardViewModelProvider).advertisements;

    return GeneralScaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.advertisementBoard_title.tr()),
      ),
      body: ListView.separated(
        padding: const PagePadding.vertical12Symmetric(),
        itemCount: items.length + 1,
        separatorBuilder: (context, index) => const EmptyBox.middleHeight(),
        itemBuilder: (context, index) => AspectRatio(
          aspectRatio: _aspectRatio,
          child: index == 0
              ? const _HouseAdCard()
              : _AdvertisementItem(items[index - 1]),
        ),
      ),
    );
  }
}

mixin _AdvertisementBoardViewMixin on ConsumerState<AdvertisementBoardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(advertisementBoardViewModelProvider.notifier)
          .fetchAdvertisements();
    });
  }
}
