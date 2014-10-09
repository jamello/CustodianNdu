using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class AgencyStandardComm
    {
        public virtual int? acId { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual Int32 CollectionStartYear { get; set; }
        public virtual Int32 CollectionEndYear { get; set; }
        public virtual Int32 PolicyTermStart { get; set; }
        public virtual Int32 PolicyTermEnd { get; set; }
        public virtual decimal CommissionRate { get; set; }
    }
}
