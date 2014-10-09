using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
   public class GLTrans
   {
       public virtual int? glId { get; set; }
       public virtual string CompanyCode { get; set; }
       public virtual Int32 BatchDate { get; set; }
       public virtual Int32 BatchNo { get; set; }
       public virtual Int32 SerialNo { get; set; }
       public virtual Int32 SubSerialNo { get; set; }
       public virtual string TransId { get; set; }
       public virtual string TransType { get; set; }
       public virtual string BranchCode { get; set; }
       public virtual string DocNo { get; set; }
       public virtual DateTime TransDate { get; set; }
       public virtual string TransMode { get; set; }
       public virtual string CurrencyType { get; set; }
       public virtual string TellerNo { get; set; }
       public virtual DateTime TellerDate { get; set; }
       public virtual string ChequeNo { get; set; }
       public virtual DateTime ChequeDate { get; set; }
       public virtual string ClientName{ get; set; }
       public virtual string TransDescription{ get; set; }
       public virtual string Remarks { get; set; }
       public virtual string DeptCode { get; set; }
       public virtual decimal GLAmountLC { get; set; }
       public virtual decimal GLAmountFC { get; set; }
       public virtual string  DetailTransType { get; set; }
       public virtual string  RefNo1 { get; set; }
       public virtual string  RefNo2 { get; set; }
       public virtual string  RefNo3 { get; set; }
       public virtual DateTime  RefDate { get; set; }
       public virtual string  DRCR { get; set; }
       public virtual decimal RefAmount { get; set; }
       public virtual string  MainAccount { get; set; }
       public virtual string LedgerTypeCode { get; set; }
       public virtual string SubAccount { get; set; }
       public virtual DateTime  EntryDate { get; set; }
       public virtual string PostStatus { get; set; }
       public virtual string ApprovalStatus { get; set; }
       public virtual string RecordStatus { get; set; }
       public virtual string OperatorId { get; set; }
       public virtual decimal TotalAmt { get; set; }
   }
}
