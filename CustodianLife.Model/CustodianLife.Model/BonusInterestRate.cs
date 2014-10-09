using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class BonusInterestRate
    {
        public virtual int? brId { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string BonusRateType { get; set; }
        public virtual Int32 BonusYear { get; set; }
        public virtual Decimal BonusRate { get; set; }
        public virtual decimal BonusRatePer { get; set; }
    }
}
