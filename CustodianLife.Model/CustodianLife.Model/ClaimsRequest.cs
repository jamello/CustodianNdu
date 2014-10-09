using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
   public class ClaimsRequest
    {
        public virtual int? crId { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual string PolicyNo { get; set; }
        public virtual string ClaimsNo { get; set; }
        public virtual Int32 UnderwritingYear { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string ClaimType { get; set; }
        public virtual DateTime PolicyStartDate { get; set; }
        public virtual DateTime PolicyEndDate { get; set; }
        public virtual DateTime NotificationDate { get; set; }
        public virtual DateTime EffectiveDate { get; set; }
        public virtual Decimal BasicSumClaimedLC { get; set; }
        public virtual Decimal BasicSumClaimedFC { get; set; }
        public virtual Decimal AdditionalSumClaimedLC { get; set; }
        public virtual Decimal AdditionalSumClaimedFC { get; set; }
        public virtual string ClaimsDescription { get; set; }
        public virtual Int32 AssuredAge { get; set; }
        public virtual string LossType { get; set; }

    }
}
