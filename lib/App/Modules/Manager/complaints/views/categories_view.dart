import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/bindings/filters_binding.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/controllers/categories_controller.dart';
import 'package:e_jareemah/App/Modules/Manager/complaints/views/filters_view.dart';
import 'package:e_jareemah/App/Utilities/Constants/AppStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Models/Main/complaint_cat.dart';
import '../../../../Utilities/Constants/AppColors.dart';

class ComplaintsCategoriesView extends GetView<ComplaintsCategoriesController> {
  const ComplaintsCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'شكاوي',
          style: Get.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.crimeTypesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('error'.tr);
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CupertinoActivityIndicator();
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: Text(
                    'لا يوجد تصنيفات',
                    style: Get.textTheme.headlineMedium!
                        .copyWith(color: AppColors.darkBlue),
                  )).marginOnly(top: 64.0);
                }
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    ComplaintCat cat = ComplaintCat.fromJson(
                        documents[index].data() as Map<String, dynamic>);

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                            () => ComplaintsFiltersView(title: cat.name ?? ''),
                            binding: ComplaintsFiltersBinding(),
                            arguments: [
                              1,
                              cat.id,
                            ]);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(
                                AppStyles.borderRadius * 2.0),
                            border:
                                Border.all(width: 6.0, color: AppColors.milky)),
                        child: Center(
                          child: Text(
                            cat.name ?? '',
                            style: Get.textTheme.titleLarge!.copyWith(
                                color: AppColors.darkBlue,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )).marginSymmetric(horizontal: 20.0, vertical: 16.0),
      ),
    );
  }
}
