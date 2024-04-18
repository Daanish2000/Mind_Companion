import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPrivacyPolicy extends StatefulWidget {
  const AppPrivacyPolicy({super.key});

  @override
  State<AppPrivacyPolicy> createState() => _AppPrivacyPolicyState();
}

class _AppPrivacyPolicyState extends State<AppPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Privacy Policy",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Please take a moment to familiarize yourself with our Privacy Policy and let us know if you have any questions.",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Introduction:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "This Privacy Policy describes the privacy practices that Mind Companion employ about collecting, using, and disclosing information, both personal and non-personal information, which we receive when you use our Services.By using the Services you consent to the practices described in this Privacy Policy. if you do not agree with the practices explained in this privacy policy,do not access, browse or use this app."
                "We are committed to safeguarding any information collected through the Services. This Privacy Policy is intended to inform you of our policies and procedures regarding the collection and use,If you have any questions or concerns, please let us know (see the 'How to contact us' section below).",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
                softWrap: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "1. Information You Provide:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Account Information:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "When you sign up or log in to the App using Firebase authentication, we collect certain personal information such as your name and email address.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Tasks and Location Data:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "The App allows you to create, view, update, and delete tasks. We also collect your current location to associate tasks with specific locations. This location information is stored using Firestore.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "1.2 Automatically Collected Information",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Personal Information:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "When you sign up or log in to the App using Firebase authentication, we collect certain personal information such as your name and email address.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Location Information:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "We collect your current location to associate tasks with specific locations. This location information is stored using Firestore.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),

              ///
              ///
              ///
              SizedBox(
                height: 10.h,
              ),
              Text(
                "2. How We Use Your Information",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "We may use the information we collect for the following purposes:",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "To provide and maintain the App's functionality.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "To personalize your experience and provide you with customized content.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "To improve our services, develop new features, and analyze usage trends.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "To communicate with you, respond to your inquiries, and provide customer support.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "To detect, prevent, and address technical issues and security vulnerabilities.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "4. Data Retention:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "We retain your personal information for as long as necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "5. Security:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "We take reasonable measures to protect the security of your information against unauthorized access, alteration, disclosure, or destruction.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "6. Your Choices:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  " You can choose not to provide certain information, but this may limit your ability to use certain features of the App.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),

              Text(
                "7. Updates to this Privacy Policy:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              Text(
                "8. Contact Us",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Text(
                  "if you have any questions or concerns about this Privacy Policy, please use the FeedBack feature.",
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
