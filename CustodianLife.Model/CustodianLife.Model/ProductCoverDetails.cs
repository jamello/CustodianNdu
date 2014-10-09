using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class ProductCoverDetails
    {
        public virtual int? pcId { get; set; }
        public virtual string ProductCoverModule { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string ProductCoverCode { get; set; }
        public virtual string ProductCoverType { get; set; }
        public virtual string ProductCoverDesc { get; set; }
        public virtual string ProductCoverOnBasicRate { get; set; }
        public virtual string ProductCoverRateOn { get; set; }
        public virtual decimal ProductCoverSAPercent { get; set; }
        public virtual decimal ProductCoverMinimumSA { get; set; }
        public virtual decimal ProductCoverMaximumSA { get; set; }
        public virtual string ProductCoverFundType { get; set; }
        
 

    }
}
