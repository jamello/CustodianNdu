using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;


namespace CustodianLife.Model
{
   public class BrokersCommRates
    {
        public virtual int? bcId { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual Int32 StartYear { get; set; }
        public virtual Int32 EndYear { get; set; }
        public virtual Int32 StartPolicyTerm { get; set; }
        public virtual Int32 EndPolicyTerm { get; set; }
        public virtual decimal CommissionRate { get; set; }
    }
}
