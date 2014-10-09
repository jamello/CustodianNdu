using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class LoanDisbursement
    {
        public virtual int? ldId { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string LoanCode { get; set; }
        public virtual string PolicyNumber { get; set; }
        public virtual DateTime RequestDate { get; set; }
        public virtual Int64 ReferenceNo { get; set; }
        public virtual decimal LoanMaxAmountLocal { get; set; }
        public virtual decimal LoanMaxAmountForeign { get; set; }
        public virtual decimal LoanAmtGrantedLC { get; set; }
        public virtual decimal LoanAmtGrantedFC { get; set; }
        public virtual string  LoanRepayFrequency{ get; set; }
        public virtual Int16   NumberOfInstallment { get; set; }
        public virtual DateTime RepaymentStartDate { get; set; }
        public virtual decimal RepaymentAmountLC { get; set; }
        public virtual decimal RepaymentAmountFC { get; set; }
        public virtual decimal LoanInterestRate { get; set; }
        public virtual decimal LoanInterestAmtLC { get; set; }
        public virtual decimal LoanInterestAmtFC { get; set; }
        public virtual decimal LoanDisbursementChargeLC { get; set; }
        public virtual decimal LoanDisbursementChargeFC { get; set; }
        public virtual decimal FirstInstallAmountLC { get; set; }
        public virtual decimal FirstInstallAmountFC { get; set; }
    }
}
