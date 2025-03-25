import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voyagedifiant/core/constants/app_colors.dart';

class SearchBarComponent extends StatefulWidget {
  // final bool checkboxstatus;
  const SearchBarComponent({
    super.key,
    //required this.checkboxstatus
  });

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final TextEditingController recherch = TextEditingController();
  bool isSearchFocused = false;
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() {
        isSearchFocused = searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    recherch.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 55.0.h,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TextField(
                  controller: recherch,
                  onChanged: (text) {},
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                    hintText:
                    isSearchFocused || recherch.text.isNotEmpty ? "" : "",
                    prefixIcon: isSearchFocused || recherch.text.isNotEmpty
                        ? null
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //  mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Rechercher un véhicule ...",
                                    style: AppColors.interNormal(
                                        color: AppColors.black, size: 14.sp)),
                                SizedBox(width: 10.0.sp),
                                const Icon(
                                  Icons.search,
                                  color: AppColors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppColors.black,
                        width: 1.0.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
