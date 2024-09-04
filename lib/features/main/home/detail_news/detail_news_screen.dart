// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finance_app/core/constants/app_icons.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:flutter/material.dart';

import 'package:finance_app/data/models/news_item_model.dart';

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  final NewsItemModel item;
  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Colors.white, Color(0xFF2289EA)],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: 280,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: widget.item.imageUrl,
                              cacheKey: widget.item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            widget.item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          ).paddingLTRB(20, 0, 20, 24),
                          Positioned(
                            right: 18,
                            top: 18,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                AppIcons.close,
                                width: 21,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.item.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                    ).paddingLTRB(28, 24, 28, 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
