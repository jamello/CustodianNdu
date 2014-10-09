using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class TransactionTypes
    {
        public virtual int? ttId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string TransactionCode { get; set; }
        public virtual string Description { get; set; }
        public virtual string ShortDescription { get; set; }
        public virtual string Branch { get; set; }
        public virtual string Department { get; set; }
        public virtual string Flag { get; set; }
        public virtual DateTime EntryDate { get; set; }
        public virtual string OperatorId { get; set; }

    }

}

