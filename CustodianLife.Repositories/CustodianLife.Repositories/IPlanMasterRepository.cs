using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
   public interface IPlanMasterRepository:IRepository<PlanMaster, Int32?>
    {
        IList<PlanMaster> PlanMasterInfo();
        PlanMaster GetById(String _key);

    }
}
