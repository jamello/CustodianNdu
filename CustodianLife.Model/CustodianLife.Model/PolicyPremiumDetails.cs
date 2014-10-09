using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class PolicyPremiumDetails
    {
        public virtual int? pdId { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual string FileNo { get; set; }
        public virtual string ProposalNo { get; set; }
        public virtual string PolicyNo { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual Decimal SumAssuredLC { get; set; }
        public virtual Decimal SumAssuredFC { get; set; }
        public virtual Decimal AnnualBasicPremiumLC { get; set; }
        public virtual Decimal AnnualBasicPremiumFC { get; set; }
        public virtual Decimal AnnualAdditionalPremLC { get; set; }
        public virtual Decimal AnnualAdditionalPremFC { get; set; }
        public virtual Decimal LoadingLC { get; set; }
        public virtual Decimal LoadingFC { get; set; }
        public virtual Decimal DiscountLC { get; set; }
        public virtual Decimal DiscountFC { get; set; }
        public virtual Decimal AdditionalChargeLC { get; set; }
        public virtual Decimal AdditionalChargeFC { get; set; }
        public virtual string  ModeOfPaymentFactor { get; set; }
        public virtual Decimal ModeOfPaymentAmountLC { get; set; }
        public virtual Decimal ModeOfPaymentAmountFC { get; set; }
        public virtual Decimal AnnualTotalPremiumLC { get; set; }
        public virtual Decimal AnnualTotalPremiumFC { get; set; }
        public virtual Decimal NetPremiumLC { get; set; }
        public virtual Decimal NetPremiumFC { get; set; }
        public virtual Decimal AnnualPremiumLC { get; set; }
        public virtual Decimal AnnualPremiumFC { get; set; }
        public virtual Decimal InstalmentalPremiumLC { get; set; }
        public virtual Decimal InstalmentalPremiumFC { get; set; }
        public virtual Decimal MOPContributionLC { get; set; }
        public virtual Decimal MOPContributionFC { get; set; }
        public virtual Decimal AnnualContributionLC { get; set; }
        public virtual Decimal AnnualContributionFC { get; set; }
        public virtual Decimal FirstPremiumLC { get; set; }
        public virtual Decimal FirstPremiumFC { get; set; }

    }
}
 
 	
