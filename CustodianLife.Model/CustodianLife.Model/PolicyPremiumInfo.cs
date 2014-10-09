using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class PolicyPremiumInfo
    {
        public virtual int? ppId { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual string FileNo { get; set; }
        public virtual string ProposalNo { get; set; }
        public virtual string PolicyNo { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string PlanCode { get; set; }
        public virtual int PolicyTerm { get; set; }
        public virtual DateTime PolicyStartDate { get; set; }
        public virtual DateTime PolicyEndDate { get; set; }
        public virtual string SumAssuredCurrency { get; set; }
        public virtual Decimal AnnualContributionLC { get; set; }
        public virtual Decimal AnnualContributionFC { get; set; }
        public virtual Decimal MonthContributionLC { get; set; }
        public virtual Decimal MonthContributionFC { get; set; }
        public virtual string LifeCover { get; set; }
        public virtual string SACalculatedPremium { get; set; }
        public virtual Decimal SumAssuredLC { get; set; }
        public virtual Decimal SumAssuredFC { get; set; }
        public virtual Decimal FreeCoverLimitLC { get; set; }
        public virtual Decimal FreeCoverLimitFC { get; set; }
        public virtual string ModeOfPayment { get; set; }
        public virtual string PremiumRateSelect { get; set; }
        public virtual Decimal FixedRate { get; set; }
        public virtual Decimal FixedRatePer { get; set; }
        public virtual string RateCode { get; set; }
        public virtual Decimal PremiumRate { get; set; }
        public virtual Decimal NoOfInstalments { get; set; }
        public virtual Decimal ModeOfPaymentRate { get; set; }
        public virtual Decimal ExchangeRate { get; set; }
        public virtual Decimal DiscountPercentage { get; set; }
        public virtual Decimal LoadingPercentage { get; set; }
        public virtual Decimal FreeLifeCoverAmountLC { get; set; }
        public virtual Decimal FreeLifeCoverAmountFC { get; set; }
        public virtual String  AppliedOn { get; set; }






    }
}
