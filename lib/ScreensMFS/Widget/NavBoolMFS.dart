

class Navbool{

  bool memberManagement, transaction, transaction2,  loan, reports, accounts, employee, samiteemanagement, calculators, specialConsideration;

  Navbool(this.accounts, this.calculators, this.employee, this.loan, this.memberManagement, this.reports, this.samiteemanagement, this.specialConsideration, this.transaction, this.transaction2);

  makeallfalse(){
    memberManagement = false;
    transaction = false;
    transaction2 = false;
    loan = false;
    reports = false;
    accounts = false;
    employee = false;
    samiteemanagement = false;
    calculators = false;
    specialConsideration = false;
  }
}