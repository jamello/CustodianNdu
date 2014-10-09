using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class LoanInterest
    {
        public virtual int? biId { get; set; }
        public virtual string LoanCode{ get; set; }
        public virtual decimal StartLoanAmount { get; set; }
        public virtual decimal EndLoanAmount { get; set; }
        public virtual decimal LoanInterestRate { get; set; }
        public virtual decimal LoanInterestRatePer { get; set; }

    }
}
