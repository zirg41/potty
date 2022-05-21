import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../create_pot_set_page.dart/create_pot_set_page.dart';
import '../../routes/router.gr.dart';
import 'widgets/pots_sets_overview_body.dart';

class PotSetsOverviewPage extends StatelessWidget {
  const PotSetsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('potty'),
        actions: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).pushNamed(const SettingsRoute().path);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: const PotSetsOverviewBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const CreatePotSetBody(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Создать"),
      ),
    );
  }
}
