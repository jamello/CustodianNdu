using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class SystemGeneratedNumber
    {
        public virtual int? snId { get; set; }
        public virtual string Account { get; set; }
        public virtual string TransCodeType { get; set; }
        public virtual string Branch { get; set; }
        public virtual Int64  GeneratedNumber { get; set; }
        public virtual Int16  Year { get; set; }
        public virtual string Prefix { get; set; }
        public virtual string Flag { get; set; }
        public virtual string OperatorId { get; set; }
        public virtual DateTime EntryDate { get; set; }

    }
}
