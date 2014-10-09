using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
     public class BankAccounts
    {
        public virtual int? baId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string StartBankDivision { get; set; }
        public virtual string EndBankDivision { get; set; }
        public virtual string StartBankDepartment { get; set; }
        public virtual string EndBankDepartment { get; set; }
        public virtual string BankTransType { get; set; }
        public virtual string BankPaymentMode { get; set; }
        public virtual string OurBankCode { get; set; }
        public virtual string GLMainAccount { get; set; }
        public virtual string GLSubAccount { get; set; }
        public virtual string BranchCode { get; set; }

    }
}
