using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IMedicalExamsRepository:IRepository<MedicalExams,Int32?>
    {
        IList<MedicalExams> MedicalExamsInfo();
        MedicalExams GetById(String _key);

    }
}
