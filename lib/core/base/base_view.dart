import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_view_model.dart';

abstract class BaseView<T extends BaseVM> extends StatelessWidget {
  const BaseView({super.key});

  T createViewModel(BuildContext context);

  Widget buildView(BuildContext context, T viewModel);

  PreferredSizeWidget? buildAppBar(BuildContext context, T viewModel) {
    return null;
  }

  Widget? buildBottomNavigationBar(BuildContext context, T viewModel) {
    return null;
  }

  Widget? buildFloatingActionButton(BuildContext context, T viewModel) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: createViewModel,
      child: Consumer<T>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: buildAppBar(context, viewModel),
            body: Stack(
              children: [
                buildView(context, viewModel),
                if (viewModel.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
            bottomNavigationBar: buildBottomNavigationBar(context, viewModel),
            floatingActionButton: buildFloatingActionButton(context, viewModel),
          );
        },
      ),
    );
  }
}
