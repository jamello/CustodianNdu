using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class InsuredDetails
    {
        public virtual int? idId { get; set; }
        public virtual string InsuredModule { get; set; }
        public virtual string InsuredClass { get; set; }
        public virtual string InsuredCode { get; set; }
        public virtual string InsuredSurname { get; set; }
        public virtual string InsuredFirstname{ get; set; }
        public virtual string InsuredLongname { get; set; }
        public virtual string InsuredShortname { get; set; }
        public virtual string InsuredAddress1 { get; set; }
        public virtual string InsuredAddress2 { get; set; }
        public virtual string InsuredPhone1 { get; set; }
        public virtual string InsuredPhone2 { get; set; }
        public virtual string InsuredEmail1 { get; set; }
        public virtual string InsuredEmail2 { get; set; }
        public virtual string InsuredOccupation { get; set; }
        public virtual string InsuredBizSource { get; set; }
        public virtual decimal InsuredCreditLimit { get; set; }
        public virtual string InsuredPayMode { get; set; }
        public virtual string InsuredBranchCode { get; set; }


    }
}
