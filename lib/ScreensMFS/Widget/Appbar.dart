import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../Constants/Constants.dart';
import '../../helpers/auth_service.dart';
import '../../route.dart';
import 'AppBarItem.dart';
import 'Appbool.dart';

class Appbar extends AppBar {
  Appbool navbool;
  Appbar({required this.navbool, Key? key}) : super(key: key);

  @override
  State<Appbar> createState() => _NavbarState();
}

class _NavbarState extends State<Appbar> {
  var arr = [
    false,
  ];
  _toglechnage(int index) {
    setState(() {
      for (int i = 0; i < arr.length; i++) {
        arr[i] = false;
      }
      arr[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:
      Row(
        children: [
          Image.asset('assets/logo.png', width: 60, height: 50),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Shwapno Sanchoy & Rindan Co-Operative Samitee Ltd.',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          MediaQuery.of(context).size.width > 1100
              ? Row(
            children: [
              buildAction(DateFormat.yMMMMd().format(DateTime.now()), Icons.calendar_month_sharp,
                      () {
                    // Date function's code
                  }),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.navbool.makeallfalse();
                    widget.navbool.home = true;
                  });
                  Get.toNamed(homePageRoute);
                },
                child: AppbarItem(
                    flag: widget.navbool.dashboard,
                    text: 'Home',
                    icon: Icons.home),
              ),
              // InkWell(
              //     onTap: () {
              //       setState(() {
              //         widget.navbool.makeallfalse();
              //         widget.navbool.dashboard = true;
              //       });
              //     },
              //     child: AppbarItem(
              //         flag: widget.navbool.dashboard,
              //         text: 'Dashboard',
              //         icon: Icons.bar_chart)),
              // buildAction('Branch Code - 5200', null, () {
              //   // Branch Code function's Code
              // }),
              // InkWell(
              //     onTap: () {
              //       setState(() {
              //         widget.navbool.makeallfalse();
              //         widget.navbool.admin = true;
              //       });
              //
              //       Get.dialog(
              //           barrierColor: Colors.transparent,
              //           barrierDismissible: true,
              //           Dialog(
              //             insetPadding:
              //             EdgeInsets.only(right: 10, top: 25),
              //             backgroundColor: Colors.white,
              //             elevation: 20,
              //             alignment: Alignment.topRight,
              //             child: Container(
              //               width: 300,
              //               height: 350,
              //               padding: EdgeInsets.all(20),
              //               child: Column(
              //                 children: [
              //                   const SizedBox(
              //                     height: 15,
              //                   ),
              //                   Text(
              //                     AuthService.to.user!.type,
              //                     style: TextStyle(
              //                       color: Colors.black87,
              //                       fontSize: 12,
              //                     ),
              //                   ),
              //                   Text(
              //                     "ID: ${AuthService.to.user!.id}",
              //                     style: TextStyle(
              //                       color: Colors.black87,
              //                       fontSize: 12,
              //                     ),
              //                   ),
              //                   Text(
              //                     "Name: ${AuthService.to.user!.name}",
              //                     style: TextStyle(
              //                       color: Colors.black87,
              //                       fontSize: 12,
              //                     ),
              //                   ),
              //                   const Expanded(
              //                       child: SizedBox(
              //                         height: 0,
              //                       )),
              //                   InkWell(
              //                     onTap: () {
              //                       Get.toNamed(myprofilePageRoute);
              //                     },
              //                     child: Container(
              //                       padding: const EdgeInsets.only(
              //                           left: 20, right: 20, top: 5),
              //                       margin: const EdgeInsets.only(
              //                           bottom: 10),
              //                       child: const Row(
              //                         crossAxisAlignment:
              //                         CrossAxisAlignment.center,
              //                         children: [
              //                           Icon(Icons.person,
              //                               color: Colors.black87),
              //                           SizedBox(
              //                             width: 15,
              //                           ),
              //                           Text(
              //                             "My Profile",
              //                             style: TextStyle(
              //                               color: Colors.black87,
              //                               fontSize: 16,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                   AuthService.to.user!.type ==
              //                       "Super Admin"
              //                       ? SizedBox(
              //                     height: 5,
              //                   )
              //                       : SizedBox(),
              //                   AuthService.to.user!.type ==
              //                       "Super Admin"
              //                       ? InkWell(
              //                     onTap: () {
              //                       Get.toNamed(
              //                           adduserPageRoute);
              //                     },
              //                     child: Container(
              //                       padding:
              //                       const EdgeInsets.only(
              //                           left: 20,
              //                           right: 20,
              //                           top: 5),
              //                       margin:
              //                       const EdgeInsets.only(
              //                           bottom: 10),
              //                       child: Row(
              //                         crossAxisAlignment:
              //                         CrossAxisAlignment
              //                             .center,
              //                         children: [
              //                           const Icon(
              //                               Icons
              //                                   .add_circle_outline_outlined,
              //                               color:
              //                               Colors.black87),
              //                           const SizedBox(
              //                             width: 15,
              //                           ),
              //                           Text(
              //                             "Add User",
              //                             style: TextStyle(
              //                               color:
              //                               Colors.black87,
              //                               fontSize: 16,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   )
              //                       : SizedBox(),
              //                   AuthService.to.user!.type ==
              //                       "Super Admin"
              //                       ? SizedBox(
              //                     height: 5,
              //                   )
              //                       : SizedBox(),
              //                   AuthService.to.user!.type ==
              //                       "Super Admin"
              //                       ? InkWell(
              //                     onTap: () {
              //                       Get.toNamed(
              //                           userlistPageRoute);
              //                     },
              //                     child: Container(
              //                       padding:
              //                       const EdgeInsets.only(
              //                           left: 20,
              //                           right: 20,
              //                           top: 5),
              //                       margin:
              //                       const EdgeInsets.only(
              //                           bottom: 10),
              //                       child: Row(
              //                         crossAxisAlignment:
              //                         CrossAxisAlignment
              //                             .center,
              //                         children: [
              //                           const Icon(Icons.list,
              //                               color:
              //                               Colors.black87),
              //                           const SizedBox(
              //                             width: 15,
              //                           ),
              //                           Text(
              //                             "User List",
              //                             style: TextStyle(
              //                               color:
              //                               Colors.black87,
              //                               fontSize: 16,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   )
              //                       : SizedBox(),
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   InkWell(
              //                     onTap: () {
              //                       AuthService.to.Logout();
              //                       Get.offAllNamed(
              //                           authenticationPageRoute);
              //                     },
              //                     child: Container(
              //                       padding: const EdgeInsets.only(
              //                           left: 20, right: 20, top: 5),
              //                       margin: const EdgeInsets.only(
              //                           bottom: 10),
              //                       child: Row(
              //                         crossAxisAlignment:
              //                         CrossAxisAlignment.center,
              //                         children: [
              //                           const Icon(Icons.logout,
              //                               color: Colors.black87),
              //                           const SizedBox(
              //                             width: 15,
              //                           ),
              //                           Text(
              //                             "Logout",
              //                             style: TextStyle(
              //                               color: Colors.black87,
              //                               fontSize: 16,
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ));
              //     },
              //     child: AppbarItem(
              //         flag: widget.navbool.admin,
              //         text: AuthService.to.user!.type,
              //         icon: Icons.person_2_rounded)),


              InkWell(
                onTap: () {
                  AuthService.to.Logout();
                  Get.offAllNamed(
                      authenticationPageRoute);
                },
                child: Container(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 20,
                        bottom: 10),
                    height: 40,
                    width: 140,
                    color: AppColor,
                    child: Row(
                      children: [

                        const Icon(Icons.logout,
                            color: Colors.white),
                        SizedBox(width: 5,),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )
              : IconButton(
              onPressed: () {
                Get.dialog(
                    barrierColor: Colors.transparent,
                    barrierDismissible: true,
                    Dialog(
                      alignment: Alignment.topRight,
                      insetPadding: const EdgeInsets.only(
                        top: 45,
                      ),
                      child: Container(
                        color: AppColor,
                        // height: 800,
                        width: 200,
                        child: Column(
                          children: [
                            InkWell(
                              onHover: (val) {},
                              onTap: () {
                                // Get.to(SamiteeRegistration(
                                //   appbool: widget.appbool,
                                //   navbool: widget.navbool,
                                // ));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    left: 20,
                                    right: 20,
                                    bottom: 10),
                                height: 40,
                                width: 200,
                                color: AppColor,
                                child: Text(
                                  DateFormat.yMMMMd()
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.navbool.makeallfalse();
                                  widget.navbool.home = true;
                                });
                                Get.toNamed(homePageRoute);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10,
                                      left: 20,
                                      right: 20,
                                      bottom: 10),
                                  height: 40,
                                  width: 200,
                                  color: AppColor,
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  )),
                            ),


                            InkWell(
                              onTap: () {
                                                      AuthService.to.Logout();
                                                      Get.offAllNamed(
                                                          authenticationPageRoute);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10,
                                      left: 20,
                                      right: 20,
                                      bottom: 10),
                                  height: 40,
                                  width: 200,
                                  color: AppColor,
                                  child: Row(
                                    children: [

                                                                const Icon(Icons.logout,
                                                                    color: Colors.black87),
                                      SizedBox(width: 5,),
                                      Text(
                                        "Logout",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            // InkWell(
                            //   onHover: (val) {},
                            //   onTap: () {
                            //     setState(() {
                            //       widget.navbool.makeallfalse();
                            //       widget.navbool.dashboard = true;
                            //     });
                            //   },
                            //   child: Container(
                            //       padding: EdgeInsets.only(
                            //           top: 10, left: 20, bottom: 10),
                            //       height: 40,
                            //       width: 200,
                            //       color: AppColor,
                            //       child: Text(
                            //         "Dashboard",
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 12,
                            //         ),
                            //       )),
                            // ),
                            // InkWell(
                            //   onHover: (val) {},
                            //   onTap: () {
                            //     // Get.to(EditMembers(
                            //     //   appbool: widget.appbool,
                            //     //   navbool: widget.navbool,
                            //     // ));
                            //   },
                            //   child: Container(
                            //       padding: EdgeInsets.only(
                            //           top: 10, left: 20, bottom: 10),
                            //       height: 40,
                            //       width: 200,
                            //       color: AppColor,
                            //       child: Text(
                            //         "Branch Code - 5200",
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 12,
                            //         ),
                            //       )),
                            // ),
                            // InkWell(
                            //   onHover: (val) {},
                            //   onTap: () {
                            //     setState(() {
                            //       widget.navbool.makeallfalse();
                            //       widget.navbool.admin = true;
                            //     });
                            //   },
                            //   child: Container(
                            //       padding: EdgeInsets.only(
                            //           top: 10, left: 20, bottom: 10),
                            //       height: 40,
                            //       width: 200,
                            //       color: AppColor,
                            //       child: Text(
                            //         AuthService.to.user!.type,
                            //         style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 12,
                            //         ),
                            //       )),
                            // ),
                          ],
                        ),
                      ),
                    ));
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Widget buildAction(String text, IconData? icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 4),
            Text(text, style: TextStyle(fontSize: 12, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
