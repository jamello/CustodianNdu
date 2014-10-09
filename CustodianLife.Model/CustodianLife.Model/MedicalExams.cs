using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class MedicalExams
    {
        public virtual int? meId { get; set; }
        public virtual string ModuleSource { get; set; }
        public virtual Decimal StartSumAssured { get; set; }
        public virtual Decimal EndSumAssured { get; set; }
        public virtual Int32 StartAge { get; set; }
        public virtual Int32 EndAge { get; set; }
        public virtual string ProductCode { get; set; }
    }
}
