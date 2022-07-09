import 'package:detectivce_dashboard/common/view/ProviderWidget.dart';
import 'package:detectivce_dashboard/modules/favorite/view_model/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavoriteViewModel>(
      vm: FavoriteViewModel(),
      init: (vm) async {},
      builder: (context, vm, child) {
        return Container();
      },
    );
  }
}
