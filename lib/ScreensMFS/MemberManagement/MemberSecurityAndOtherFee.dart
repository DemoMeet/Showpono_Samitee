import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../Constants/Constants.dart';
import '../../Constants/values.dart';
import '../../Model/member.dart';
import '../../ScreensMFS/Widget/Appbar.dart';
import '../../ScreensMFS/Widget/Appbool.dart';
import '../Widget/NavBoolMFS.dart';
import '../Widget/NavbarScreenMFS.dart';

class MemberSecurityAndOtherFee extends StatefulWidget {
  Navbool navbool;
  Appbool appbool;

  MemberSecurityAndOtherFee({required this.appbool, required this.navbool});

  @override
  State<MemberSecurityAndOtherFee> createState() =>
      _MemberSecurityAndOtherFeeState();
}

class _MemberSecurityAndOtherFeeState extends State<MemberSecurityAndOtherFee> {
  bool mmems = false;
  String electeddate = '';
  bool click = false;
  List<Map<String, dynamic>> _expenses = [];
  List<Memberss> memberss = [];
  var selectedmemberss;
  var sselectedmemberss;
  int i = 0;
  var revenustampamounttxt = TextEditingController();
  DateTime revenustampselectedDate = DateTime.now();
  var processingfeeamounttxt = TextEditingController();
  DateTime processingfeeselectedDate = DateTime.now();
  var sharesavingsamounttxt = TextEditingController();
  DateTime sharesavingsselectedDate = DateTime.now();
  var memberfeeamounttxt = TextEditingController();
  DateTime memberfeesselectedDate = DateTime.now();
  var loanpassbookamounttxt = TextEditingController();
  DateTime loanpassbookselectedDate = DateTime.now();
  var loanpassfileamounttxt = TextEditingController();
  DateTime loanpassfileselectedDate = DateTime.now();
  Future<void> fetch() async {
    clr();
    _expenses = [];
    await FirebaseFirestore.instance
        .collection('Member')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element["Status"] && !element['Dead']) {
          memberss.add(Memberss(
              somiteename: element["Somitee Name"],
              somiteeid: element["Somitee ID"],
              membertype: element["Member Type"],
              occupation: element["Occupation"],
              firstname: element["First Name"],
              dead: element['Dead'],
              lastname: element["Last Name"],
              fathername: element["Father Name"],
              mothername: element["Mother Name"],
              gender: element["Gender"] ?? '',
              religion: element["Religion"],
              nationalid: element["National ID"],
              loanpendingamount: element["Loan Pending Amount"],
              owndepositamount: element["Own deposit Amount"],
              birthregi: element["Birth Registration"],
              annualincome: element["Annual Income"],
              sts: element["Status"],
              age: element["Age"],
              education: element["Education"],
              maritalstatus: element["Marital Status"],
              mobilenotype: element["Mobile No Type"],
              mobilenno: element["Mobile No"],
              presentadd: element["Present Address"],
              parmaadd: element["Permanent Address"],
              livingperiod: element["Living Period"],
              nomaleearner: element["No Female Earner"],
              nofemaleearner: element["No Male Earner"],
              id: element.id,
              headfamily: element["Head Family"],
              ownhomestead: element["Own HomeStead"],
              relationwithhead: element["Relation With Head"],
              landdesc: element["Land Desc"],
              remarks: element["Remarks"],
              imageurl: element["ImageURL"],
              img: element["Image"],
              birthdate: element["Date Of Birth"].toDate(),
              sl: 0));
        }
      }
    });

    await FirebaseFirestore.instance.collection('Others Fee').get().then((que) {
      que.docs.forEach((docSnapshot) {
        var data = docSnapshot.data();
        var userId = docSnapshot.id;
        Map<String, dynamic> allExpenses = {
          'User ID': userId,
          'User Name': docSnapshot['Member Name'],
        };
        data.forEach((key, value) {
          if (value is Map &&
              value.containsKey('amount') &&
              value.containsKey('date')) {
            if (!allExpenses.containsKey(key)) {
              allExpenses[key] = [];
            }
            allExpenses[key]?.add({
              'amount': value['amount'].toString(),
              'Date': value['date'].toDate(),
            });
          }
        });
        _expenses.add(allExpenses);
        setState(() {});
      });
    });
  }

  clr() {
    var ss;
    selectedmemberss = ss;
    revenustampamounttxt = TextEditingController();
    revenustampselectedDate = DateTime.now();
    processingfeeamounttxt = TextEditingController();
    processingfeeselectedDate = DateTime.now();
    sharesavingsamounttxt = TextEditingController();
    sharesavingsselectedDate = DateTime.now();
    memberfeeamounttxt = TextEditingController();
    memberfeesselectedDate = DateTime.now();
    loanpassbookamounttxt = TextEditingController();
    loanpassbookselectedDate = DateTime.now();
    loanpassfileamounttxt = TextEditingController();
    loanpassfileselectedDate = DateTime.now();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _revenustampselectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: revenustampselectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != revenustampselectedDate) {
        setState(() {
          revenustampselectedDate = picked;
        });
      }
    }

    Future<void> _processingfeeselectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: processingfeeselectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != processingfeeselectedDate) {
        setState(() {
          processingfeeselectedDate = picked;
        });
      }
    }

    Future<void> _sharesavingsselectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: sharesavingsselectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != sharesavingsselectedDate) {
        setState(() {
          sharesavingsselectedDate = picked;
        });
      }
    }

    Future<void> _memberfeesselectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: memberfeesselectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != memberfeesselectedDate) {
        setState(() {
          memberfeesselectedDate = picked;
        });
      }
    }

    Future<void> _loanpassfileselectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: loanpassfileselectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != loanpassfileselectedDate) {
        setState(() {
          loanpassfileselectedDate = picked;
        });
      }
    }

    DataRow buildDataRow(Map<String, dynamic> userData) {
      i++;
      List<DataCell> cells = [
        DataCell(Text(i.toString(), style: const TextStyle(fontSize: 12))),
        DataCell(
            Text(userData["User Name"], style: const TextStyle(fontSize: 12))),
      ];

      List<String> categories = [
        'Revenue Stamp',
        'Processing Fee',
        'Share Savings',
        'Member Fee',
        'Loan Pass Book',
        'Loan Pass File'
      ];
      categories.forEach((category) {
        if (userData.containsKey(category)) {
          var expense = userData[category];
          print(userData[category]);
          String amountText = expense[0]['amount'].toString() ?? 'N/A';
          cells.add(DataCell(Text(amountText,
              textAlign: TextAlign.end, style: TextStyle(fontSize: 12))));
        } else {
          cells.add(DataCell(Text('N/A', style: TextStyle(fontSize: 12))));
        }
      });

      return DataRow(cells: cells);
    }

    return Scaffold(
      appBar: Appbar(
        navbool: widget.appbool,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, right: 30, left: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            color: navbarColor,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    "Members Extra Fees & Dates",
                                    style: TextStyle(
                                      color: AppColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    if (selectedmemberss != null &&
                                        (revenustampamounttxt.text.isNotEmpty ||
                                            processingfeeamounttxt
                                                .text.isNotEmpty ||
                                            sharesavingsamounttxt
                                                .text.isNotEmpty ||
                                            memberfeeamounttxt
                                                .text.isNotEmpty ||
                                            loanpassbookamounttxt
                                                .text.isNotEmpty ||
                                            loanpassfileamounttxt
                                                .text.isNotEmpty)) {
                                      Map<String, dynamic> data = {
                                        'Member Name':
                                            selectedmemberss.firstname +
                                                ' ' +
                                                selectedmemberss.lastname,
                                        'Member ID': selectedmemberss.id,
                                        if (revenustampamounttxt
                                            .text.isNotEmpty)
                                          'Revenue Stamp': {
                                            'amount': revenustampamounttxt.text
                                                .trim(),
                                            'date': DateTime.now(),
                                          },
                                        if (processingfeeamounttxt
                                            .text.isNotEmpty)
                                          'Processing Fee': {
                                            'amount': processingfeeamounttxt
                                                .text
                                                .trim(),
                                            'date': DateTime.now(),
                                          },
                                        if (sharesavingsamounttxt
                                            .text.isNotEmpty)
                                          'Share Savings': {
                                            'amount': sharesavingsamounttxt.text
                                                .trim(),
                                            'date': DateTime.now(),
                                          },
                                        if (memberfeeamounttxt.text.isNotEmpty)
                                          'Member Fee': {
                                            'amount':
                                                memberfeeamounttxt.text.trim(),
                                            'date': DateTime.now(),
                                          },
                                        if (loanpassbookamounttxt
                                            .text.isNotEmpty)
                                          'Loan Pass Book': {
                                            'amount': loanpassbookamounttxt.text
                                                .trim(),
                                            'date': DateTime.now(),
                                          },
                                        if (loanpassfileamounttxt
                                            .text.isNotEmpty)
                                          'Loan Pass File': {
                                            'amount': loanpassfileamounttxt.text
                                                .trim(),
                                            'date': DateTime.now(),
                                          },
                                      };

                                      DocumentSnapshot docSnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('Others Fee')
                                              .doc(selectedmemberss.id)
                                              .get();
                                      if (docSnapshot.exists) {
                                        await FirebaseFirestore.instance
                                            .collection('Others Fee')
                                            .doc(selectedmemberss.id)
                                            .update(data)
                                            .then((value) {
                                          fetch();
                                          Get.snackbar(
                                              "Others Fee Added Successfully.",
                                              "Refreshing the page",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.green,
                                              margin: EdgeInsets.zero,
                                              duration: const Duration(
                                                  milliseconds: 2000),
                                              boxShadows: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(-100, 0),
                                                    blurRadius: 20),
                                              ],
                                              borderRadius: 0);
                                        });
                                      } else {
                                        await FirebaseFirestore.instance
                                            .collection('Others Fee')
                                            .doc(selectedmemberss.id)
                                            .set(data)
                                            .then((value) {
                                          fetch();
                                          Get.snackbar(
                                              "Others Fee Added Successfully.",
                                              "Refreshing the page",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.green,
                                              margin: EdgeInsets.zero,
                                              duration: const Duration(
                                                  milliseconds: 2000),
                                              boxShadows: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(-100, 0),
                                                    blurRadius: 20),
                                              ],
                                              borderRadius: 0);
                                        });
                                      }
                                    } else {
                                      Get.snackbar("Others Fee Adding Failed.",
                                          "Some Required Fields are Empty",
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.white,
                                          backgroundColor: Colors.red,
                                          margin: EdgeInsets.zero,
                                          duration: const Duration(
                                              milliseconds: 2000),
                                          boxShadows: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(-100, 0),
                                                blurRadius: 20),
                                          ],
                                          borderRadius: 0);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 15),
                                      child: Text(
                                        "✓ Submit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    clr();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3.0, left: 15),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.clear_all_sharp,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Clear",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    color: AppColor_yellow,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Select Member',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Container(
                                          width: 300,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            color: AppColor_greyBorder,
                                            border: Border.all(
                                                color: AppColor_Black),
                                          ),
                                          child: DropdownSearch<Memberss>(
                                            filterFn:
                                                (Memberss item, String query) {
                                              return item.filterFn(query);
                                            },
                                            popupProps: PopupProps.menu(
                                              showSearchBox: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      Memberss item,
                                                      bool isSelected) {
                                                return Container(
                                                  padding: EdgeInsets.all(15),
                                                  child: Text(
                                                    "${item.firstname} ${item.lastname} - ${item.id}",
                                                  ),
                                                );
                                              },
                                              fit: FlexFit.loose,
                                              showSelectedItems: false,
                                              menuProps: const MenuProps(
                                                backgroundColor: Colors.white,
                                                elevation: 100,
                                              ),
                                              searchFieldProps:
                                                  const TextFieldProps(
                                                style: TextStyle(fontSize: 12),
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText: "Search...",
                                                ),
                                              ),
                                            ),
                                            dropdownDecoratorProps:
                                                const DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                ),
                                              ),
                                            ),
                                            dropdownBuilder: (context, item) {
                                              if (item == null) {
                                                return const Text(
                                                  "Enter Member Name/Code",
                                                );
                                              } else {
                                                return Text(
                                                  "${item.firstname} ${item.lastname} - ${item.id}",
                                                );
                                              }
                                            },
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedmemberss = newValue;
                                                mmems = true;
                                              });
                                            },
                                            items: memberss,
                                            selectedItem: selectedmemberss,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Revenue Stamp Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextField(
                                          controller: revenustampamounttxt,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          onTap: () =>
                                              _revenustampselectDate(context),
                                          child: AbsorbPointer(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText: revenustampselectedDate !=
                                                        null
                                                    ? "${revenustampselectedDate!.day}-${revenustampselectedDate!.month}-${revenustampselectedDate!.year}"
                                                    : "Select a date",
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                suffixIcon: Icon(
                                                    Icons.calendar_month_sharp,
                                                    size: 14,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Processing Fee Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextField(
                                          controller: processingfeeamounttxt,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          onTap: () =>
                                              _processingfeeselectDate(context),
                                          child: AbsorbPointer(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText:
                                                    processingfeeselectedDate !=
                                                            null
                                                        ? "${processingfeeselectedDate!.day}-${processingfeeselectedDate!.month}-${processingfeeselectedDate!.year}"
                                                        : "Select a date",
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                suffixIcon: Icon(
                                                    Icons.calendar_month_sharp,
                                                    size: 14,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Share Savings Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextField(
                                          controller: sharesavingsamounttxt,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          onTap: () =>
                                              _sharesavingsselectDate(context),
                                          child: AbsorbPointer(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText:
                                                    sharesavingsselectedDate !=
                                                            null
                                                        ? "${sharesavingsselectedDate!.day}-${sharesavingsselectedDate!.month}-${sharesavingsselectedDate!.year}"
                                                        : "Select a date",
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                suffixIcon: Icon(
                                                    Icons.calendar_month_sharp,
                                                    size: 14,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Member Fee Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextField(
                                          controller: memberfeeamounttxt,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          onTap: () =>
                                              _memberfeesselectDate(context),
                                          child: AbsorbPointer(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText: memberfeesselectedDate !=
                                                        null
                                                    ? "${memberfeesselectedDate!.day}-${memberfeesselectedDate!.month}-${memberfeesselectedDate!.year}"
                                                    : "Select a date",
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                suffixIcon: Icon(
                                                    Icons.calendar_month_sharp,
                                                    size: 14,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Loan Pass File Amount',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextField(
                                          controller: loanpassfileamounttxt,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' *',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 14)),
                                            TextSpan(
                                                text: ' :',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: InkWell(
                                          onTap: () =>
                                              _loanpassfileselectDate(context),
                                          child: AbsorbPointer(
                                            child: TextField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                hintText:
                                                    loanpassfileselectedDate !=
                                                            null
                                                        ? "${loanpassfileselectedDate!.day}-${loanpassfileselectedDate!.month}-${loanpassfileselectedDate!.year}"
                                                        : "Select a date",
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                                suffixIcon: Icon(
                                                    Icons.calendar_month_sharp,
                                                    size: 14,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            color: navbarColor,
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    "Members Extra Fees & Dates Lists",
                                    style: TextStyle(
                                      color: AppColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  border: TableBorder.all(
                                      color: Colors.black26, width: 1),
                                  headingRowColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor_Blue),
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'SL',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'User Name',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Revenue Stamp',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Processing Fee',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Share Savings',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Member Fee',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Loan Pass Book',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Loan Pass File',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    for (var ele in _expenses)
                                      buildDataRow(ele),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            NavbarScreenMFS(
              appbool: widget.appbool,
              navbool: widget.navbool,
            ),
          ],
        ),
      ),
    );
  }
}
