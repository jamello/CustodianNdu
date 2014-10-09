using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IRolePermissionsRepository : IRepository<RolePermissions, Int32?>
    {
        IList<RolePermissions> RoleDetails();
        RolePermissions GetByRole(String _key);
    }
}
