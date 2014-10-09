using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class Agents
    {
        public virtual string AgentId { get; set; }
        public virtual int? acId { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual string AgentType { get; set; }
        public virtual string AgentDescription { get; set; }
        public virtual string RegionCode { get; set; }
        public virtual string RegionName { get; set; }
        public virtual string AgentCode { get; set; }
        public virtual string AgentName { get; set; }
        public virtual string UnitCode { get; set; }
        public virtual string UnitName { get; set; }
        public virtual string AgentCode1 { get; set; }
        public virtual string AgentName1 { get; set; }
        public virtual string AddressLine1 { get; set; }
        public virtual string AddressLine2 { get; set; }
        public virtual string PhoneNo1 { get; set; }
        public virtual string PhoneNo2 { get; set; }
        public virtual string EmailAddress1 { get; set; }
        public virtual string EmailAddress2 { get; set; }
        public virtual string AgencyLevel { get; set; }
        public virtual string AgencyTag { get; set; }
        public virtual string AgencyFlag { get; set; }
        public virtual string AgencyOperId { get; set; }
        public virtual DateTime EntryDate { get; set; }

    }
}
