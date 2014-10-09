using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class GroupDRCRNote
    {
          public virtual int? gdnId { get; set; }
       public virtual string SystemModule { get; set; }
       public virtual string FileNo { get; set; }
       public virtual string ProposalNo { get; set; }
       public virtual string PolicyNo { get; set; }
       public virtual string UnderwritingYear { get; set; }
	   public virtual string ProductCode { get; set; }
	   public virtual Int32 MembBatchNo { get; set; }
	   public virtual string ProcessingDate { get; set; }
	   public virtual string BatchNo { get; set; }

             

    }
}
