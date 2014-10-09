using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public  interface IClaimsRequestRepository:IRepository<ClaimsRequest, Int32?>
    {
        IList<ClaimsRequest> ClaimsRequestDetails();
        ClaimsRequest GetById(String _key);
    }
}
