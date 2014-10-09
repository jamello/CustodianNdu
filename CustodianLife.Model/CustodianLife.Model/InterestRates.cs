using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class InterestRates
    {
        public virtual int? irId { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string RateType { get; set; }
        public virtual Decimal StartCountribAmt { get; set; }
        public virtual Decimal EndCountribAmt { get; set; }
        public virtual Int32 StartTerm { get; set; }
        public virtual Int32 EndTerm { get; set; }
        public virtual decimal InterestRate { get; set; }
        public virtual decimal InterestRatePer { get; set; }
        public virtual DateTime RateStartDate { get; set; }
        public virtual DateTime RateEndDate { get; set; }
    }
}
