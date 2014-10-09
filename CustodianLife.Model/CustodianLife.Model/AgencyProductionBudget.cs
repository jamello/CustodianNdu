using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class AgencyProductionBudget
    {
        public virtual int? abId { get; set; }
        public virtual string AgencyTypeCode { get; set; }
        public virtual Decimal BudgetAmount { get; set; }
        public virtual decimal BonusAmount { get; set; }
        public virtual Int32 StartNewAgentMonth { get; set; }
        public virtual Int32 EndNewAgentMonth { get; set; }
        public virtual Decimal CollectionExpensesRate { get; set; }
        public virtual Decimal AddCollectionExpensesRate { get; set; }
        public virtual Decimal LunchModeRate { get; set; }

    }
}
