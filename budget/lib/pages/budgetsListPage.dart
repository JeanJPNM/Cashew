import 'package:budget/database/tables.dart';
import 'package:budget/pages/editBudgetPage.dart';
import 'package:budget/struct/databaseGlobal.dart';
import 'package:budget/widgets/budgetContainer.dart';
import 'package:budget/widgets/openBottomSheet.dart';
import 'package:budget/widgets/pageFramework.dart';
import 'package:budget/widgets/popupFramework.dart';
import 'package:budget/widgets/selectColor.dart';
import 'package:budget/widgets/settingsContainers.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budget/main.dart';
import 'package:budget/colors.dart';

class BudgetsListPage extends StatefulWidget {
  const BudgetsListPage({Key? key}) : super(key: key);

  @override
  State<BudgetsListPage> createState() => BudgetsListPageState();
}

class BudgetsListPageState extends State<BudgetsListPage>
    with AutomaticKeepAliveClientMixin {
  late Color selectedColor = Colors.red;
  void refreshState() {
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return PageFramework(
      title: "Budgets",
      backButton: false,
      appBarBackgroundColor: Theme.of(context).colorScheme.accentColor,
      appBarBackgroundColorStart: Theme.of(context).canvasColor,
      slivers: [
        StreamBuilder<List<Budget>>(
          stream: database.watchAllPinnedBudgets(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: BudgetContainer(
                          budget: snapshot.data![index],
                        ),
                      );
                    },
                    childCount: snapshot.data?.length, //snapshot.data?.length
                  ),
                ),
              );
            } else {
              return SliverToBoxAdapter(child: SizedBox());
            }
          },
        ),
      ],
    );
  }
}