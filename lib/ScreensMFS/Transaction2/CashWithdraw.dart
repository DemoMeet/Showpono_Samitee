import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:flutter/services.dart';
import '../../../../Constants/Constants.dart';
import '../../../../route.dart';
import '../../Model/account.dart';
import '../../Model/member.dart';
import '../../ScreensMFS/Widget/Appbool.dart';
import '../../helpers/auth_service.dart';
import '../../ScreensMFS/Widget/Appbar.dart';
import '../Widget/NavBoolMFS.dart';
import '../Widget/NavbarScreenMFS.dart';

class CashWithdraw extends StatefulWidget {
  Navbool navbool;
  Appbool appbool;

  CashWithdraw({required this.appbool, required this.navbool});

  @override
  State<CashWithdraw> createState() => _CashWithdrawState();
}

class _CashWithdrawState extends State<CashWithdraw> {
  List<Memberss> memberss = [];
  var selectedmemberss;
  var sselectedmemberss;
  var withdrawamount = TextEditingController();
  var amountinwords = TextEditingController();
  var remarks = TextEditingController(text: "Cash Withdraw");
  var selectedcustomertype;

  bool mmems = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    await FirebaseFirestore.instance
        .collection('Member')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element["Status"]) {
          memberss.add(Memberss(
              somiteename: element["Somitee Name"],
              somiteeid: element["Somitee ID"],
              membertype: element["Member Type"],
              occupation: element["Occupation"],
              firstname: element["First Name"],fee: element["Fee"] ?? '',
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
  }
  void _onclear() {
    setState(() {
      var ss;
      selectedmemberss = ss;
      mmems = false;
    });
  }

  void _save() async {
    if (selectedmemberss == null ||
        withdrawamount.text == "" ||
        amountinwords.text == "") {
      Get.snackbar(
          "Balance Withdraw Request Failed.", "Some Required Fields are Empty",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          margin: EdgeInsets.zero,
          duration: const Duration(milliseconds: 2000),
          boxShadows: [
            const BoxShadow(
                color: Colors.grey, offset: Offset(-100, 0), blurRadius: 20),
          ],
          borderRadius: 0);
    } else {
      DocumentSnapshot ds = await FirebaseFirestore.instance
          .collection('BalanceAccount')
          .doc('0')
          .get();
      if (ds['Balance'] < double.parse(withdrawamount.text)) {
        Get.snackbar(
            "Balance Withdraw Request Failed.", "Insufficient Balance in Cash!",
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            margin: EdgeInsets.zero,
            duration: const Duration(milliseconds: 2000),
            boxShadows: [
              const BoxShadow(
                  color: Colors.grey, offset: Offset(-100, 0), blurRadius: 20),
            ],
            borderRadius: 0);
      } else {
        QuerySnapshot querySnapshot =
            await FirebaseFirestore.instance.collection('Cash Withdraw').get();
        FirebaseFirestore.instance.collection('Cash Withdraw').add({
          'Member Name': selectedmemberss.firstname +
              ' ' +
              selectedmemberss.lastname,
          'Member ID': selectedmemberss.id,
          "Requested By":
              "${AuthService.to.user!.id}-(*)-${AuthService.to.user!.name}",
          "Approved By": '',
          "SL": querySnapshot.docs.length + 1,
          "Approve": false,
          'Account No': selectedmemberss.id,
          'Withdraw Amount': double.parse(withdrawamount.text),
          'Amount In Words': amountinwords.text,
          'Disbursed Amount': selectedmemberss.loanpendingamount,
          'Requested Date': DateTime.now(),
          'Approve Date': DateTime.now(),
          'Status': false,
          'Remarks': remarks.text,
        }).then((value) async {
          await FirebaseFirestore.instance
              .collection('BalanceAccount')
              .doc('0')
              .update({
            'Balance': FieldValue.increment(-double.parse(withdrawamount.text)),
          });
          await FirebaseFirestore.instance
              .collection('Member')
              .doc(selectedmemberss.id)
              .update({
            'Loan Pending Amount':
                FieldValue.increment(-double.parse(withdrawamount.text)),
          }).then((value) {
            Get.offNamed(cashwithdrawlistPageRoute);
            Get.snackbar("Cash Withdraw Successful.",
                "Redirecting to Cash Withdraw List Page.",
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.green,
                margin: EdgeInsets.zero,
                duration: const Duration(milliseconds: 2000),
                boxShadows: [
                  const BoxShadow(
                      color: Colors.grey,
                      offset: Offset(-100, 0),
                      blurRadius: 20),
                ],
                borderRadius: 0);
          });
        });
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    var ScreenWidth = MediaQuery.of(context).size.width;
    var ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Appbar(
        navbool: widget.appbool,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100, left: 70),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: ScreenWidth / 1.097,
                    height: ScreenHeight / 1.5,
                    // color: Colors.white,
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
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: ScreenWidth / 1.097,
                          color: navbarColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: ScreenWidth / 38.4),
                                child: Text(
                                  "Cash Withdraw",
                                  style: TextStyle(
                                    color: AppColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenWidth / 96,
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  _save();
                                },
                                child: Container(
                                  height: ScreenWidth / 38.4,
                                  width: ScreenWidth / 17.07,
                                  color: Colors.green,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenWidth / 153.6,
                                        left: ScreenWidth / 102.4),
                                    child: Text(
                                      "✓ Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenWidth / 109.71),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenWidth / 153.6,
                              ),
                              InkWell(
                                onTap: () {
                                  _onclear();
                                },
                                child: Container(
                                  height: ScreenWidth / 38.4,
                                  width: ScreenWidth / 17.07,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenWidth / 512,
                                        left: ScreenWidth / 102.4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.clear_all_sharp,
                                          color: Colors.white,
                                          size: ScreenWidth / 85.33,
                                        ),
                                        SizedBox(
                                          width: ScreenWidth / 307.2,
                                        ),
                                        Text(
                                          "Clear",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenWidth / 109.71),
                                        ),
                                      ],
                                    ),
                                  ),
                                  color: AppColor_yellow,
                                ),
                              ),
                              SizedBox(
                                width: ScreenWidth / 153.6,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: ScreenWidth / 38.4,
                                  width: ScreenWidth / 30.72,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenWidth / 153.6,
                                        left: ScreenWidth / 76.8),
                                    child: Text(
                                      "X",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenWidth / 109.71),
                                    ),
                                  ),
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: ScreenWidth / 153.6,
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 80, right: 50),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Row(
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                            text: 'Select Member',
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 14),
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
                                                      color: Colors.black, fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                            width: 300,
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: AppColor_greyBorder,
                                              border: Border.all(color: AppColor_Black),
                                            ),
                                            child: DropdownSearch<Memberss>(
                                              filterFn: (Memberss item, String query) {
                                                return item.filterFn(query);
                                              },
                                              popupProps: PopupProps.menu(
                                                showSearchBox: true,
                                                itemBuilder: (BuildContext context,
                                                    Memberss item, bool isSelected) {
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
                                                searchFieldProps: const TextFieldProps(
                                                  style: TextStyle(fontSize: 12),
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: "Search...",
                                                  ),
                                                ),
                                              ),
                                              dropdownDecoratorProps:
                                              const DropDownDecoratorProps(
                                                dropdownSearchDecoration: InputDecoration(
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.transparent),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.transparent),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Account Type: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            mmems
                                                ? selectedmemberss.membertype
                                                : "",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Customer Name: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            mmems
                                                ? selectedmemberss.firstname
                                                         +
                                                    ' ' +
                                                selectedmemberss.lastname
                                                : "",
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Current Balance :",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            mmems
                                                ? selectedmemberss.loanpendingamount.toStringAsFixed(2)
                                                : '',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Withdraw Amount :",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 45,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: TextField(
                                            style:
                                                const TextStyle(fontSize: 16),
                                            controller: withdrawamount,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 250,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Customer ID: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            mmems
                                                ? selectedmemberss.id
                                                : "",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile No: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 43,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            mmems
                                                ? selectedmemberss.mobilenno
                                                : "",
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Remarks :",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: TextField(
                                            controller: remarks,
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 16),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[400],
                                              border:
                                                  const OutlineInputBorder(),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 5),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 120,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Amount In Words :",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 300,
                                          child: TextField(
                                            controller: amountinwords,
                                            style: TextStyle(fontSize: 16),
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 5),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
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
