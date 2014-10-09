using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class Invoice
    {
        public virtual int? InId { get; set; }
        public virtual string CompanyCode { get; set; }
        public virtual Int64 BatchDate { get; set; }
        public virtual string BranchCode { get; set; }
        public virtual string BatchNo { get; set; }
        public virtual Int32 SerialNo { get; set; }
        public virtual string RecordType { get; set; }
        public virtual string DeptCode { get; set; }
        public virtual string InvoiceNo { get; set; }
        public virtual DateTime TransDate { get; set; }
        public virtual string TransType { get; set; }
        public virtual string ItemSize { get; set; }
        public virtual Int64 Quantity { get; set; }
        public virtual decimal Price { get; set; }
        public virtual decimal TransAmt { get; set; }
        public virtual string DRCR { get; set; }
        public virtual string CreditorCode { get; set; }
        public virtual string CreditorType { get; set; }
        public virtual string MainAccountDR { get; set; }
        public virtual string SubAccountDR { get; set; }
        public virtual string LedgerTypeCode { get; set; }
        public virtual string TransDescription { get; set; }
        public virtual string RefNo { get; set; }
        public virtual DateTime RefDate { get; set; }
        public virtual string PostStatus { get; set; }
        public virtual string ApprovalStatus { get; set; }
        public virtual string Flag { get; set; }
        public virtual DateTime EntryDate { get; set; }
        public virtual string OperatorId { get; set; }
    }
}
