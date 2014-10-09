using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IIndLifeCodesRepository:IRepository<LifeCodes,Int32?>
    {
        IList<LifeCodes> IndividualLifeCodes();
        LifeCodes GetById(String _key);
    }
}
