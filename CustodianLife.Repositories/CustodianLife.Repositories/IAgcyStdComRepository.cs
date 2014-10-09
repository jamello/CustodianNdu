using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IAgcyStdComRepository : IRepository<AgencyStandardComm, Int32?>
    {
        IList<AgencyStandardComm> AgencyStandardCommissions();
        AgencyStandardComm GetById(String _key);

    }
}
