using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class Brokers
    {
        public virtual int? abId { get; set; }
        public virtual string Category { get; set; }
        public virtual string BrokerCode { get; set; }
        public virtual string LongDescription { get; set; }
        public virtual string ShortDescription { get; set; }
        public virtual string AddressLine1 { get; set; }
        public virtual string AddressLine2 { get; set; }
        public virtual string PhoneNo1 { get; set; }
        public virtual string PhoneNo2 { get; set; }
        public virtual string EmailAddress1 { get; set; }
        public virtual string EmailAddress2 { get; set; }
        public virtual string Staff { get; set; }
        public virtual string OccupationCode { get; set; }
        public virtual string SourceBuz { get; set; }
        public virtual string Branch { get; set; }
        public virtual string LedgerType { get; set; }
    }
}
