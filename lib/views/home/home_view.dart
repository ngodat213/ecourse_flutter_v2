import 'package:ecourse_flutter_v2/core/widgets/banner.dart';
import 'package:ecourse_flutter_v2/core/widgets/category_item.dart';
import 'package:ecourse_flutter_v2/core/widgets/popular_card.dart';
import 'package:flutter/material.dart';
import '../../core/base/base_view.dart';
import '../../view_models/home_vm.dart';

class HomeView extends BaseView<HomeVM> {
  const HomeView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(context);
  }

  @override
  Widget buildView(BuildContext context, HomeVM vm) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [BannerWidget(), CategoryItem(), PopularCard()],
          ),
        ),
      ),
    );
  }
}
