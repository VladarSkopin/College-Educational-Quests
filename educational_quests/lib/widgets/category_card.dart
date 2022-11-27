
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../models/category.dart';
import '../screens/quest_screens/quest_college_screen.dart';
import '../screens/quest_screens/quest_parks_screen.dart';
import '../screens/quest_screens/quest_riddles_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width * 0.7;
    return Column(
      children: [
        const SizedBox(height: 14),
        GestureDetector(
          onTap: () {
            if (category.categoryName == 'Загадки Петербурга'){
              Navigator.of(context).push(
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 900),
                      child: const QuestRiddlesScreen()
                  )
              );
            } else if (category.categoryName == 'Петербургские парки') {
              Navigator.of(context).push(
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 900),
                      child: const QuestParksScreen()
                  )
              );
            } else {
              Navigator.of(context).push(
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 900),
                      child: const QuestCollegeScreen()
                  )
              );
            }
          },
          child: SizedBox(
            height: mediaQueryWidth,
            width: mediaQueryWidth,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(category.imgUrl),
                      fit: BoxFit.cover
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(1.0, 2.0),
                        blurRadius: 4.0
                    )
                  ]
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(category.categoryName, style: Theme.of(context).textTheme.headline6?.copyWith(
            shadows: [
              Shadow(
                  offset: const Offset(1, 1),
                  color: Colors.grey.shade300,
                  blurRadius: 2
              )
            ])),
        const SizedBox(height: 30),
      ],
    );
  }
}