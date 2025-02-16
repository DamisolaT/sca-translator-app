import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sca_translator_app/core/theme/colors.dart';
import 'package:sca_translator_app/core/utils/images.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Favourite",
          style: TextStyle(color: AppColors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              "Clear all",
              style: TextStyle(color: AppColors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 21,
          ),
          HistoryContainer(),
          SizedBox(
            height: 14,
          ),
          HistoryContainer(),
        ],
      )),
    );
  }
}

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 322,
        height: 82,
        decoration: BoxDecoration(
            color: AppColors.grey, borderRadius: BorderRadius.circular(11)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Text(
                    "en",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ),
                Text(
                  "Hello how are you?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appbar),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 9),
                  child: SvgPicture.asset(AppIcons.starrIcon),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Divider(
                color: AppColors.lightGrey,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 29),
                  child: Text(
                    "en",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "¿Hola como estas?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.buttonColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
