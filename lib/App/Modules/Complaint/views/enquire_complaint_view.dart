import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_jareemah/App/Modules/Complaint/binding/complaint_details_binging.dart';
import 'package:e_jareemah/App/Modules/Complaint/controllers/enquire_complaint_controller.dart';
import 'package:e_jareemah/App/Modules/Complaint/views/complaint_details_view.dart';
import 'package:e_jareemah/App/Modules/Complaint/widget/complaint_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Models/Main/complaint.dart';
import '../../../Utilities/Constants/AppColors.dart';

class EnquireComplaintView extends GetView<EnquireComplaintController> {
  const EnquireComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        title: Text(
          'استعلام',
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
              stream: controller.getComplaints,
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
                    'لا يوجد شكاوي',
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
                    Complaint complaint = Complaint.fromJson(
                        documents[index].data() as Map<String, dynamic>);

                    return ComplaintItem(
                      date: complaint.date!,
                      number: complaint.id!,
                      status: complaint.status!,
                      onTap: () {
                        Get.to(
                            () => const ComplaintDetailsView(),  binding: ComplaintDetailsBinding(), arguments: complaint);
                      },
                    );
                  },
                );
              },
            )).marginSymmetric(horizontal: 20.0, vertical: 12.0),
      ),
    );
  }
}
