using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class PremiumRatesMaster
    {
        public virtual int? pmId { get; set; }
        public virtual string ModuleSource { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string RateTypeCode { get; set; }
        public virtual Int32 StartPolicyTerm { get; set; }
        public virtual Int32 EndPolicyTerm { get; set; }
        public virtual Int32 StartAge { get; set; }
        public virtual Int32 EndAge { get; set; }
        public virtual decimal PremiumRate { get; set; }
    }
}
