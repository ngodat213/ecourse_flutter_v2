import 'package:flutter/material.dart';
import '../../core/base/base_view.dart';
import '../../core/services/api_service.dart';
import '../../services/home_service.dart';
import '../../view_models/home_vm.dart';

class HomeView extends BaseView<HomeVM> {
  const HomeView({super.key});

  @override
  HomeVM createViewModel(BuildContext context) {
    return HomeVM(HomeService(ApiService()))..loadUsers();
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context, HomeVM viewModel) {
    return AppBar(title: const Text('Home'));
  }

  @override
  Widget buildView(BuildContext context, HomeVM viewModel) {
    return ListView.builder(
      itemCount: viewModel.users.length,
      itemBuilder: (context, index) {
        final user = viewModel.users[index];
        return ListTile(title: Text(user.name), subtitle: Text(user.email));
      },
    );
  }
}
