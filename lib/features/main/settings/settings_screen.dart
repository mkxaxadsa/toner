import 'package:finance_app/core/constants/app_icons.dart';
import 'package:finance_app/core/extensions/expanded_ext_on_widget.dart';
import 'package:finance_app/core/extensions/padding_extension_on_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      children: [
        Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * .33,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          decoration: ShapeDecoration(
            color: const Color(0xFF2289E9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _item(
                      icon: AppIcons.terms,
                      title: "Terms of use",
                      url:
                          'https://docs.google.com/document/d/1fJdYcs2IwPT3euPtz5yIZdTkACJ37s1jxiAPlUUErgs/edit?usp=sharing')
                  .paddingOnly(bottom: 16),
              _item(
                      icon: AppIcons.privacy,
                      title: "Privacy Policy",
                      url:
                          'https://docs.google.com/document/d/1bGOUXOi3UXjtz5B0ZlJcVOHt9-kbHGAUROldo1Y94j0/edit?usp=sharing')
                  .paddingOnly(bottom: 16),
              _item(
                      icon: AppIcons.support,
                      title: "Support page",
                      url: 'https://forms.gle/iKEkK61cpdJ9HS4d7')
                  .paddingOnly(bottom: 16),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ).paddingSymetric(vertical: 24)
      ],
    );
  }

  Widget _item({
    required String icon,
    required String title,
    required String url,
  }) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        width: double.maxFinite,
        height: 45,
        decoration: ShapeDecoration(
          color: const Color(0xFF0966BD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 21,
            ).paddingOnly(right: 18),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ).expanded(),
            Image.asset(
              AppIcons.chevronRight,
              width: 8,
            ),
          ],
        ).paddingSymetric(horizontal: 20),
      ),
    );
  }
}
