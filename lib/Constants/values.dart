import '../Model/scheme.dart';


const double perSharePrice = 50000;
const double perShareAddmissionFee = 3000;

const List<String> UserTypeList = [
  'Super Admin',
  'Admin',
  'Branch Manager',
  'Field Officer',
];


const List<String> ProductClassList = [
  'SME Loan',
  'Term Loan',
  'Short Term Loan',
  'Staff Loan',
];
const List<String> MemberTypeList = ['General Member'];
const List<String> MaritalstatusList = ['Single', 'Married', 'Divorced'];
const List<String> ReligionList = [
  'Hinduism',
  'Islam',
  'Buddhism ',
  'Christianity',
  'Others'
];
const List<String> MobileTypeList = ['Personal', 'Other'];
const List<String> InstallmentFrequencyList = ['Daily', 'Weekly', 'Monthly'];
const List<int> SanctionLimitList = [50000, 100000, 500000, 1000000];
const List<String> LoanPeriodList = [
  'January',
  'February',
  'March ',
  'April',
  'May',
  'June',
  'July',
  'August ',
  'September',
  'October',
  'November ',
  'December'
];
const List<String> TranTypeList = [
  'All Transaction',
  'Debit Transaction',
  'Credit Transaction',
];
const List<String> SectorList = [
  '901002 - Fishing Farms(Hatchery,Shrimp Culture Etc)',
  '901003 - Dairy Farms',
  '901004 - Poultry Farms',
  '901009 - Farmers/Fishermen',
  '901010 - Business',
  '902118 - Rice Mills',
  '902133 - Bricks Manufacturers & Sand Elevators',
  '902450 - Restaurant/Fast Food',
  '902451 - Photo Studio & Color Labs',
  '902452 - Travel agencies',
  '902454 - Beauty Parlors/Saloons',
  '902462 - Stone Crasher',
  '902463 - Jewelry Service',
  '902465 - Auto Mobile Service',
  '902050 - Foreign Individual',
  '905001 - Student',
  '905002 - Housewive',
];
const List<String> DocumentList = [
  'National ID Card',
  'Passport',
  'Birth Certificate',
  'Driver License',
  'General Deed',
  'School Certificate',
  'Land Deed'
];

const List<String> IntroducerTypeList = [
  'Existing Customer',
];

const List<String> ExpensecategoryList = [
  'Others',
  'Salary (Officer)',
  'Salary (Staff)',
  'House Rent Allowance',
  'Medical Allowance',
  'Education Allowance',
  'Conveyance Allowance',
  'Bank Contribution To Pf',
  'Rest And Recreation Leave Allowance',
  'Festival Bonus',
  'Lunch Subsidy',
  'Special Benefit Allowance'
      'Training Expense',
  'Travelling Expenses (Audit And Tour)',
  'Conveyance',
  'Fuel',
  'Entertainment',
  'Business Development',
  'Newspaper & Journal',
  'Bank Charge',
  'Electricity Cost',
  'Printed Stationary',
  'Internet Expense',
  'Miscellaneous Expenses',
  'Table Stationary',
  'Mobile Bill',
];
const List<String> TransactionNatureList = [
  'GL to GL',
  'GL to Party Account',
  'Party Account to GL',
  'Party Account to Party Account',
];
const List<String> TransactionentrytypeList = [
  'New Entry',
];

const List<Map<String, String>> IntroducerList = [
  {'ID': '7210220058837101', 'Name': 'Titas Ranjan Talukdar'}
];

const List<String> RelationList = [
  'Wife',
  'Husband',
  'Son',
  'Daughter',
  'Father',
  'Mother',
];
const List<String> LoanPurposeList = [
  'Business',
  'Rickshaw',
  'Van',
  'Motor Cycle',
  'Others',
  'Flower Farming',
  'Tailor Training',
  'Bee Farming'
];
const List<String> LoanType = [
  'Micro Credit',
  'Share Holder Loan'
];
const List<String> ReverseTypeList = [
  'Full Reverse',
  'Partial Reverse',
];

const List<String> CustomerTypeList = [
  'Individual',
];

List<String> CustomerRegi = [
  "Selection",
  'Basic Info',
  'Customer Photo',
  'Address\nInformation',
  'Contact\nInformation',
  'Related\nDocuments',
  'Bank\nA/C Info',
  'Know Your\nCustomer',
  'Review'
];

List<String> RegularAccopen = [
  "Account Type",
  'Account Information',
  'Account Operator',
  'Nominee\nInformation',
  'Introducer\nInformation',
  'Transaction\nProfile',
  'Know Your\nCustomer',
  'Final Submission'
];
const List<String> LedgerTypeList = [
  'Member Deposit Ledger',
  'Member Loan Ledger',
];
List<Scheme> LoanSchemes = [
  Scheme(
      sl: 1,
      installmentno: 160,
      duration: 196,
      prinamount: 10000,
      servicecharge: 12.00,
      dailyprofit: 7.5,
      installmentamount: 70,
      name: "Micro 1"),
];
