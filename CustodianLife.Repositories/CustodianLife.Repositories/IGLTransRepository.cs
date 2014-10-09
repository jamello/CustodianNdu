using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IGLTransRepository:IRepository<GLTrans,Int32?>
    {
        IList<GLTrans> GLTransDetails();
        GLTrans GetById(String _key);

    }
}
