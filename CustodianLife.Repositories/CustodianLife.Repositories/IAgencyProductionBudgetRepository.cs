using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
namespace CustodianLife.Repositories
{
    public interface IAgencyProductionBudgetRepository:IRepository<AgencyProductionBudget,Int32?>
    {
        IList<AgencyProductionBudget> AgencyProductionBudgetDetails();
        AgencyProductionBudget GetById(String _key);

    }
}
