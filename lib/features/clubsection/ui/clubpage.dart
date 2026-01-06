import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubsection/ui/clubbody.dart';
import 'package:akalpit/features/clubsection/ui/sidedrawer/sidedrawer.dart';
import 'package:akalpit/features/clubsection/ui/widget/appbar.dart';
import 'package:akalpit/features/clubsection/services/actions.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  @override
  void initState() {
    super.initState();

    /// 🔥 Trigger ONCE when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Store<AppState> store = StoreProvider.of<AppState>(context);
      store.dispatch(FetchMyClubByUserIdAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppSideDrawer(),
      appBar: const ClubsAppBar(),
      body: const ClubBody(),
    );
  }
}
