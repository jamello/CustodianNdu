using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class AccountGroup
    {
        public virtual int? agId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string AccountGroupCode { get; set; }
        public virtual string AccountGroupLongDesc { get; set; }
        public virtual string AccountGroupShortDesc { get; set; }
        public virtual string MainGroupCode { get; set; }
        public virtual string MainGroupDesc { get; set; }
        public virtual string Sub1GroupCode { get; set; }
        public virtual string Sub1GroupDesc { get; set; }
        public virtual string Sub2GroupCode { get; set; }
        public virtual string Sub2GroupDesc { get; set; }
        public virtual string LedgerType { get; set; }
        public virtual string EntryFlag { get; set; }
        public virtual DateTime EntryDate { get; set; }
        public virtual string OperatorId { get; set; }
    }
}