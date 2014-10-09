using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class PlanMaster
    {
        public virtual int? pmId { get; set; }
        public virtual string ProductCode { get; set; }
        public virtual string PlanCode { get; set; }
        public virtual Int32 PlanTerm { get; set; }
        public virtual Int32 MinimumYears { get; set; }
        public virtual Int32 MaximumYears { get; set; }
        public virtual Int32 MinimumAge { get; set; }
        public virtual Int32 MaximumAge { get; set; }
        public virtual decimal MinimumSA { get; set; }
        public virtual decimal MaximumSA { get; set; }
        public virtual string MaturityBasedPayment { get; set; }
        public virtual string SAPaymentPeriodic { get; set; }
        public virtual string SAPaymentSurrenderBased { get; set; }
        public virtual Int32 NumOfYearsBeforeSurrender { get; set; }
        public virtual string LoanAllowed { get; set; }
        public virtual decimal LoanPercentOnSA { get; set; }
        public virtual decimal MinimumLoanAmt{ get; set; }
        public virtual string PolicyValidAfterMaturity { get; set; }
        public virtual decimal AnnualPaymentModeRate { get; set; }
        public virtual decimal HalfYearlyPaymentModeRate { get; set; }
        public virtual decimal QuarterlyPaymentModeRate { get; set; }
        public virtual decimal MonthlyPaymentModeRate { get; set; }


    }
}
