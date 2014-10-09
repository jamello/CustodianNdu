using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class AccountsActivityCodes
    {
        public virtual int? aaId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual string GLMainAccountCode { get; set; }
        public virtual string GLSubAccountCode { get; set; }
        public virtual string ActivityCode { get; set; }
        public virtual string ActivityDescription { get; set; }

    }
}
