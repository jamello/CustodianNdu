using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IReInsuranceTreatyCommissionRepository:IRepository<ReInsuranceTreatyCommission,Int32?>
    {
        IList<ReInsuranceTreatyCommission> ReInsuranceTreatyCommissionDetails();
        ReInsuranceTreatyCommission GetById(String _key);
    }
}
