using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class RateTypeCodes
    {
        public virtual int? rtId { get; set; }
        public virtual string ModuleSource { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string RateTypeCode { get; set; }
        public virtual string RateTypeDesc { get; set; }
        public virtual Int32 RatePer { get; set; }
    }
}
