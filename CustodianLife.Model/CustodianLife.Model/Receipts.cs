using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class Receipts
    {
        public virtual int? rtId { get; set; }
        public virtual string CompanyCode{ get; set; }
        public virtual Int32 BatchNo { get; set; }
        public virtual Int64 SerialNo { get; set; }
        public virtual String TransType { get; set; }
        public virtual String TempTransNo { get; set; }
        public virtual DateTime TransDate { get; set; }
        public virtual DateTime EntryDate { get; set; }
        public virtual String TransMode { get; set; }
        public virtual String ReceiptType { get; set; }
        public virtual String ReferenceNo { get; set; }
        public virtual String ProductCode { get; set; }
        public virtual String DocNo { get; set; }
        public virtual String CurrencyType { get; set; }
        public virtual String ChequeTellerNo { get; set; }
        public virtual String ChequeInwardNo { get; set; }
        public virtual DateTime ChequeDate { get; set; }
        public virtual String PayeeName { get; set; }
        public virtual String TranDescription1 { get; set; }
        public virtual String TranDescription2 { get; set; }
        public virtual String BranchCode { get; set; }
        public virtual String BankCode { get; set; }
        public virtual decimal AmountLC { get; set; }
        public virtual decimal AmountFC { get; set; }
        public virtual String InsuredCode { get; set; }
        public virtual String AgentCode { get; set; }
        public virtual String CommissionApplicable { get; set; }
        public virtual decimal PolicyRegularContribution { get; set; }
        public virtual String PolicyPaymentMode { get; set; }
        public virtual String MainAccountDebit { get; set; }
        public virtual String SubAccountDebit { get; set; }
        public virtual String MainAccountCredit { get; set; }
        public virtual String SubAccountCredit { get; set; }
        public virtual String LedgerTypeCredit { get; set; }

    }
}
