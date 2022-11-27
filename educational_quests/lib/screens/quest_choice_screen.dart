
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common_constants.dart';
import '../models/category.dart';
import '../models/theme_provider.dart';
import '../widgets/category_card.dart';

class QuestChoiceScreen extends StatefulWidget {
  const QuestChoiceScreen({Key? key}) : super(key: key);

  @override
  State<QuestChoiceScreen> createState() => _QuestChoiceScreenState();
}

class _QuestChoiceScreenState extends State<QuestChoiceScreen> {
  bool _switchOn = false;

  @override
  Widget build(BuildContext context) {
    _switchOn = context.read<ThemeProvider>().theme == "dark";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('ВЫБОР КВЕСТА', style: Theme.of(context).textTheme.headline1)),
        body: Container(
            decoration: _switchOn ? pageDecorationDark : pageDecorationLight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: Category.categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: Category.categories[index]);
              },
            )
        ),
      ),
    );
  }


}
