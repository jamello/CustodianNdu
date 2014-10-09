using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustodianLife.Model
{
    public class RolePermissions
    {
        public virtual int? rpId { get; set; }
        public virtual string UserRole { get; set; }
        public virtual string Menu { get; set; }
        public virtual string Home { get; set; }
        public virtual string CodesMastersSetup { get; set; }
        public virtual string CodesMastersSetupU1 { get; set; }
        public virtual string GeneralLedger { get; set; }
        public virtual string GeneralLedgerU1 { get; set; }
        public virtual string GlCodesSetup { get; set; }
        public virtual string GlCodesSetupU1 { get; set; }
        public virtual string GlCodesPrint { get; set; }
        public virtual string GlCodesPrintU1 { get; set; }
        public virtual string GlTrans { get; set; }
        public virtual string GlTransU1 { get; set; }
        public virtual string GlJournal { get; set; }
        public virtual string GlJournalU1 { get; set; }
        public virtual string GlMasterUpdate { get; set; }
        public virtual string GlMasterUpdateU1 { get; set; }
        public virtual string GlReports { get; set; }
        public virtual string GlReportsU1 { get; set; }
        public virtual string FinReportGroup { get; set; }
        public virtual string FinReportGroupU1 { get; set; }
        public virtual string GlMonthEnd { get; set; }
        public virtual string GlMonthEndU1 { get; set; }
        public virtual string GlYearEnd { get; set; }
        public virtual string GlYearEndU1 { get; set; }
        public virtual string Receivable { get; set; }
        public virtual string ReceivableU1 { get; set; }
        public virtual string RecCodesSetup { get; set; }
        public virtual string RecCodesSetupU1 { get; set; }
        public virtual string RecDebEntry { get; set; }
        public virtual string RecDebEntryU1 { get; set; }
        public virtual string RecDebTransReport { get; set; }
        public virtual string RecDebTransReportU1 { get; set; }
        public virtual string RecMasterUpdate { get; set; }
        public virtual string RecMasterUpdateU1 { get; set; }
        public virtual string RecDebtorReports { get; set; }
        public virtual string RecDebtorReportsU1 { get; set; }
        public virtual string Payables { get; set; }
        public virtual string PayablesU1 { get; set; }
        public virtual string PayCodesSetup { get; set; }
        public virtual string PayCodesSetupU1 { get; set; }
        public virtual string PayCredTransEntry { get; set; }
        public virtual string PayCredTransEntryU1 { get; set; }
        public virtual string PayCredTransRep { get; set; }
        public virtual string PayCredTransRepU1 { get; set; }
        public virtual string PayCreditorsReports { get; set; }
        public virtual string PayCreditorsReportsU1 { get; set; }
        public virtual string Fixedassets { get; set; }
        public virtual string FixedassetsU1 { get; set; }
        public virtual string FaCodesSetup { get; set; }
        public virtual string FaCodesSetupU1 { get; set; }
        public virtual string FaReports { get; set; }
        public virtual string FaReportsU1 { get; set; }
        
    }
}
