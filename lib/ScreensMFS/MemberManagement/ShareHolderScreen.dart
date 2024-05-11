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

class ShareholderScreen extends StatefulWidget {
  Navbool navbool;
  Appbool appbool;

  ShareholderScreen({required this.appbool, required this.navbool});

  @override
  State<ShareholderScreen> createState() => _ShareholderScreenState();
}

class _ShareholderScreenState extends State<ShareholderScreen> {
  DateTime selectedDate = DateTime.now();
  var noofshare = TextEditingController();
  var admissionfee = TextEditingController(text: '0');
  var shareamount = TextEditingController(text: '0');
  final TextEditingController _amountController = TextEditingController();
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  var due = TextEditingController(text: '0');
  var addfee = TextEditingController(text: '0');
  var samount = TextEditingController(text: '0');
  String electeddate = '';
  bool click = false;
  bool mmems = false;
  List<Memberss> memberss = [];
  var selectedmemberss;
  var sselectedmemberss;
  List<Map> _expenses = [];

  Future<void> fetch() async {
    clr();
    _expenses = [];
    int i = 0;
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

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Shared Member').get();

    querySnapshot.docs.forEach((DocumentSnapshot data) {
      i++;
      _expenses.add({
        'Member Name': data['Member Name'],
        'Member ID': data['Member ID'],
        'History': data['History'],
        'No of Shares': data['No of Shares'],
        'Due': data['Due'],
        'Admission Fee': data['Admission Fee'],
        'Share Amount': data['Share Amount'],
        'Paid Admission Fee': data['Paid Admission Fee'],
        'Paid Share Amount': data['Paid Share Amount'],
        'Date': data['Date'].toDate(),
        'sl': i,
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  _calculate() {
    setState(() {
      double noshare = double.parse(noofshare.text);
      samount.text = (noshare * perSharePrice).toString();
      addfee.text = (noshare * perShareAddmissionFee).toString();
      due.text =
          (((noshare * perSharePrice) + (noshare * perShareAddmissionFee)) -
                  double.parse(shareamount.text) -
                  double.parse(admissionfee.text))
              .toString();
    });
  }

  clr() {
    var ss;
    selectedmemberss = ss;
    selectedDate = DateTime.now();
    noofshare = TextEditingController();
    admissionfee = TextEditingController(text: '0');
    shareamount = TextEditingController(text: '0');
    due = TextEditingController(text: '0');
    addfee = TextEditingController(text: '0');
    samount = TextEditingController(text: '0');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    Future<void> _selectDates(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate.value,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null && pickedDate != _selectedDate.value) {
        _selectedDate.value = pickedDate;
      }
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
                      height: 400,
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
                                    "Add Share Holder Info",
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
                                    if (selectedmemberss == null ||
                                        noofshare.text.isEmpty ||
                                        double.parse(noofshare.text) < 1) {
                                      Get.snackbar(
                                          "Shared Member Adding Failed.",
                                          "Some Required Fields are Empty or Number of share is less then 1.",
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.white,
                                          backgroundColor: Colors.red,
                                          margin: EdgeInsets.zero,
                                          duration: const Duration(
                                              milliseconds: 2500),
                                          boxShadows: [
                                            const BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(-100, 0),
                                                blurRadius: 20),
                                          ],
                                          borderRadius: 0);
                                    } else {
                                      DocumentSnapshot docSnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('Shared Member')
                                              .doc(selectedmemberss.id)
                                              .get();
                                      if (docSnapshot.exists) {
                                        Get.snackbar(
                                            "Shared Member Adding Failed.",
                                            "Member is already a shared member.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: Colors.white,
                                            backgroundColor: Colors.red,
                                            margin: EdgeInsets.zero,
                                            duration: const Duration(
                                                milliseconds: 2500),
                                            boxShadows: [
                                              const BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(-100, 0),
                                                  blurRadius: 20),
                                            ],
                                            borderRadius: 0);
                                      } else {
                                        List<Map<String, dynamic>> lll = [
                                          {
                                            'amount': double.parse(
                                                    admissionfee.text) +
                                                double.parse(shareamount.text),
                                            'date': selectedDate,
                                          }
                                        ];
                                        FirebaseFirestore.instance
                                            .collection('Shared Member')
                                            .doc(selectedmemberss.id)
                                            .set({
                                          'Member Name':
                                              selectedmemberss.firstname +
                                                  ' ' +
                                                  selectedmemberss.lastname,
                                          'Member ID': selectedmemberss.id,
                                          'History': lll,
                                          'No of Shares':
                                              double.parse(noofshare.text),
                                          'Due': double.parse(due.text),
                                          'Admission Fee':
                                              double.parse(addfee.text),
                                          'Share Amount':
                                              double.parse(samount.text),
                                          'Paid Admission Fee':
                                              double.parse(admissionfee.text),
                                          'Paid Share Amount':
                                              double.parse(shareamount.text),
                                          'Date': selectedDate,
                                        }).then((value) async {
                                          fetch();
                                          Get.snackbar(
                                              "Shared Member Added Successfully.",
                                              "Refreshing the Page.",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText: Colors.white,
                                              backgroundColor: Colors.green,
                                              margin: EdgeInsets.zero,
                                              duration: const Duration(
                                                  milliseconds: 2500),
                                              boxShadows: [
                                                const BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(-100, 0),
                                                    blurRadius: 20),
                                              ],
                                              borderRadius: 0);
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    color: Colors.green,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 10.0, left: 15),
                                      child: Text(
                                        "✓ Submit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    clr();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    color: AppColor_yellow,
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 3.0, left: 15),
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                          Container(
                                              width: 250,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                color: AppColor_greyBorder,
                                                border: Border.all(
                                                    color: AppColor_Black),
                                              ),
                                              child: DropdownSearch<Memberss>(
                                                filterFn: (Memberss item,
                                                    String query) {
                                                  return item.filterFn(query);
                                                },
                                                popupProps: PopupProps.menu(
                                                  showSearchBox: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          Memberss item,
                                                          bool isSelected) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child: Text(
                                                        "${item.firstname} ${item.lastname} - ${item.id}",
                                                      ),
                                                    );
                                                  },
                                                  fit: FlexFit.loose,
                                                  showSelectedItems: false,
                                                  menuProps: const MenuProps(
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 100,
                                                  ),
                                                  searchFieldProps:
                                                      const TextFieldProps(
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                  ),
                                                ),
                                                dropdownBuilder:
                                                    (context, item) {
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: 'Admission Fee',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              children: <TextSpan>[
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
                                            width: 250,
                                            child: TextField(
                                              controller: addfee,
                                              keyboardType:
                                                  TextInputType.number,
                                              readOnly: true,
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: 'Paid Admission Fee',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
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
                                            width: 210,
                                            child: TextField(
                                              controller: admissionfee,
                                              onChanged: (val) {
                                                setState(() {
                                                  if (val.isEmpty) {
                                                    admissionfee.text = '0';
                                                  }
                                                });
                                                _calculate();
                                              },
                                              keyboardType:
                                                  TextInputType.number,
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: 'Total Due',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              children: <TextSpan>[
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
                                          SizedBox(
                                            width: 250,
                                            child: TextField(
                                              controller: due,
                                              keyboardType:
                                                  TextInputType.number,
                                              readOnly: true,
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
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: 'No of Shares',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            width: 250,
                                            child: TextField(
                                              controller: noofshare,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              onChanged: (val) {
                                                setState(() {
                                                  if (val.isEmpty) {
                                                    noofshare.text;
                                                    samount.text = '0';
                                                    addfee.text = '0';
                                                  } else {
                                                    _calculate();
                                                  }
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: 'Share Amount',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              children: <TextSpan>[
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
                                            width: 250,
                                            child: TextField(
                                              controller: samount,
                                              readOnly: true,
                                              keyboardType:
                                                  TextInputType.number,
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: const TextSpan(
                                              text: 'Paid Share Amount',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
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
                                            width: 210,
                                            child: TextField(
                                              controller: shareamount,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (val) {
                                                setState(() {
                                                  if (val.isEmpty) {
                                                    shareamount.text = '0';
                                                  }
                                                });
                                                _calculate();
                                              },
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                            width: 55,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: InkWell(
                                              onTap: () => _selectDate(context),
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    hintText:
                                                        "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                    suffixIcon: const Icon(
                                                        Icons
                                                            .calendar_month_sharp,
                                                        size: 14,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
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
                                    "Add Share Holders Info List",
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
                          const SizedBox(
                            height: 25,
                          ),
                          MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Member Name',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'No of Shares',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Admission Fee',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Share Amount',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Due',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Date',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Action',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: _expenses.map<DataRow>((member) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(member['sl'].toString(),
                                            style:
                                                const TextStyle(fontSize: 12))),
                                        DataCell(Text(member['Member Name'],
                                            style:
                                                const TextStyle(fontSize: 12))),
                                        DataCell(Text(
                                            member['No of Shares'].toString(),
                                            style:
                                                const TextStyle(fontSize: 12))),
                                        DataCell(Text(
                                            member['Admission Fee'].toString(),
                                            style:
                                                const TextStyle(fontSize: 12))),
                                        DataCell(Text(
                                            member['Share Amount'].toString(),
                                            style:
                                                const TextStyle(fontSize: 12))),
                                        DataCell(Text(member['Due'].toString(),
                                            style:
                                                const TextStyle(fontSize: 12))),
                                        DataCell(Text(
                                            DateFormat.yMMMMd()
                                                .format(member['Date']),
                                            style: TextStyle(fontSize: 12))),
                                        DataCell(IconButton(
                                          onPressed: () {
                                            Get.dialog(
                                              Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  width: 350,
                                                  padding: EdgeInsets.all(30),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          "Add A Payment For Member : ${member['Member Name']}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                      const Text(
                                                        'Amount',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextField(
                                                        controller:
                                                            _amountController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      const Text(
                                                        'Date',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 10),
                                                      InkWell(
                                                        onTap: () =>
                                                            _selectDates(
                                                                context),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Obx(() => Text(
                                                                '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              )),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                height: 40,
                                                                width: 80,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              if (_amountController
                                                                  .text
                                                                  .isEmpty) {
                                                                Get.snackbar(
                                                                    "Shared Member Payment Adding Failed.",
                                                                    "Some Required Fields are Empty.",
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                    colorText:
                                                                        Colors
                                                                            .white,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    margin:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    duration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                2500),
                                                                    boxShadows: [
                                                                      const BoxShadow(
                                                                          color: Colors
                                                                              .grey,
                                                                          offset: Offset(
                                                                              -100,
                                                                              0),
                                                                          blurRadius:
                                                                              20),
                                                                    ],
                                                                    borderRadius:
                                                                        0);
                                                              } else {
                                                                List<
                                                                        Map<String,
                                                                            dynamic>>
                                                                    history =
                                                                    List.from(
                                                                        member[
                                                                            'History']);
                                                                Timestamp
                                                                    selectedTimestamp =
                                                                    Timestamp
                                                                        .fromDate(
                                                                            _selectedDate.value);
                                                                history.add({
                                                                  'amount': double.parse(
                                                                      _amountController
                                                                          .text),
                                                                  'date':
                                                                      selectedTimestamp,
                                                                });

                                                                double dd = member[
                                                                        'Due'] -
                                                                    double.parse(
                                                                        _amountController
                                                                            .text);
                                                                print(dd
                                                                    .toString());
                                                                print(history
                                                                    .toString());
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Shared Member')
                                                                    .doc(member[
                                                                        'Member ID'])
                                                                    .update({
                                                                  'History':
                                                                      history,
                                                                  'Due': dd,
                                                                }).then((value) async {
                                                                  Get.back();
                                                                  fetch();
                                                                  Get.snackbar(
                                                                      "Shared Member Due Added Successfully.",
                                                                      "Refreshing the Page.",
                                                                      snackPosition:
                                                                          SnackPosition
                                                                              .BOTTOM,
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      margin: EdgeInsets
                                                                          .zero,
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              2500),
                                                                      boxShadows: [
                                                                        const BoxShadow(
                                                                            color: Colors
                                                                                .grey,
                                                                            offset: Offset(-100,
                                                                                0),
                                                                            blurRadius:
                                                                                20),
                                                                      ],
                                                                      borderRadius:
                                                                          0);
                                                                });
                                                              }
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                height: 40,
                                                                width: 80,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                                child:
                                                                    const Text(
                                                                  "Submit",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.payments_outlined,
                                            color: Colors.blue,
                                          ),
                                        )),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ))
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
