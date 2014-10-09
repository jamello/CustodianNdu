using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface ITreatyProportionRepository:IRepository<TreatyProportion,Int32?>
    {
        IList<TreatyProportion> TreatyProportionDetails();
        TreatyProportion GetById(String _key);
    }
}
