using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Repositories
{
    public interface IRepository<TD, KT> where TD : class
    {
        TD GetById(KT id);
        void Save(TD saveObj);
        void Delete(TD delObj);

    }
}
