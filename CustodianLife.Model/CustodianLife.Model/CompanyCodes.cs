using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class CompanyCodes
    {
        public virtual int? ccId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string CompanyLongName { get; set; }
        public virtual string CompanyShortName { get; set; }
        public virtual string AddressLine1 { get; set; }
        public virtual string AddressLine2 { get; set; }
        public virtual string PhoneNo1 { get; set; }
        public virtual string PhoneNo2 { get; set; }
        public virtual string RegNo { get; set; }
        public virtual string EmailAddress1 { get; set; }
        public virtual string EmailAddress2 { get; set; }
        public virtual string GroupSubsidiary { get; set; }
        public virtual DateTime EstablishDate { get; set; }

    }
}
