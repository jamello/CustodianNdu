using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class ChartOfAccounts
    {
        public virtual int? caId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string MainAcctsCode { get; set; }
        public virtual string SubAcctsCode { get; set; }
        public virtual string FullDescription { get; set; }
        public virtual string ShortDescription { get; set; }
        public virtual string AccountLevel { get; set; }
        public virtual string AccountMainGroup { get; set; }
        public virtual string AccountLedgerCode { get; set; }
        public virtual string AccountLedgerType { get; set; }
        public virtual string AccountSub1Group { get; set; }
        public virtual string AccountSub2Group { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string BusinessType { get; set; }
        public virtual string AccountPolicyType { get; set; }
        public virtual string AccountStatus { get; set; }
        public virtual string AccountMode { get; set; }
        public virtual string EntryFlag { get; set; }
        public virtual DateTime EntryDate { get; set; }
        public virtual string OperatorId { get; set; }

    }
}