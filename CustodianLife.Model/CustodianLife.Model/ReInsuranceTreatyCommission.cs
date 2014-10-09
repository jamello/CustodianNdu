using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class ReInsuranceTreatyCommission
    {
        public virtual int? tcId { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual Int32 TreatyCommYear { get; set; }
        public virtual string TreatyType { get; set; }
        public virtual Int32 SumAssuredStartPeriod { get; set; }
        public virtual Int32 SumAssuredEndPeriod { get; set; }
        public virtual Decimal StartSumAssuredAmt { get; set; }
        public virtual Decimal EndSumAssuredAmt { get; set; }
        public virtual Decimal CommissionRate { get; set; }
    }
}
