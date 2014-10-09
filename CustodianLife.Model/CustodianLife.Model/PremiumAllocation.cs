using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class PremiumAllocation
    {
        public virtual int? paId { get; set; }
        public virtual string CompanyCode{ get; set; }
        public virtual Int32 Year { get; set; }
        public virtual String ProductCode { get; set; }
        public virtual String PolicyNo { get; set; }
        public virtual DateTime TransDate { get; set; }
        public virtual String InsuredCode { get; set; }
        public virtual String TransType { get; set; }
        public virtual String TransNo { get; set; }
        public virtual Decimal TotalTransAmount { get; set; }
        public virtual Decimal AllocationAmount { get; set; }
        public virtual Decimal PremiumAmount { get; set; }
        public virtual Decimal LumpsumAmount { get; set; }
        public virtual Decimal PremiumRecovery { get; set; }
    }
}
