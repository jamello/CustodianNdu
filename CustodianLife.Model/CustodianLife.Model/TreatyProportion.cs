using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class TreatyProportion
    {
        public virtual int? tpId { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual Int32 TreatyYear { get; set; }
        public virtual string TreatyCompany { get; set; }
        public virtual string TreatyType { get; set; }
        public virtual Decimal StartSumAssuredValue  { get; set; }
    }
}
