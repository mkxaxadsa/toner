// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finance_app/app/global_navigator/global_navigator.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:finance_app/features/main/home/detail_news/detail_news_screen.dart';
import 'package:flutter/material.dart';

import 'package:finance_app/data/models/news_item_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final NewsItemModel item;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.maxFinite,
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                cacheKey: item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.5), // Тёмный цвет с прозрачностью
                      borderRadius:
                          BorderRadius.circular(12), // Округление углов
                    ),
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ).paddingOnly(left: 20, right: 20),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      GlobalNavigator.push(context,
                          page: DetailNewsScreen(item: item));
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF2289EA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Read',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  )
                ],
              ).paddingSymetric(vertical: 18),
            ),
          ],
        ),
      ),
    );
  }
}
