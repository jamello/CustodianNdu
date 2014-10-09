using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using System.Xml.Schema;
using System.Xml.XPath;


namespace CustodianLife.Model
{
    public class PolicyInfo
    {
        public virtual int? polId { get; set; }
        public virtual string ProposalFileNumber { get; set; }
        public virtual string SystemModule { get; set; }
        public virtual string ProposalNumber { get; set; }
        public virtual string PolicyNumber { get; set; }
        public virtual string PolicyProductCode { get; set; }
        public virtual string ProductPlanCode { get; set; }
        public virtual string ProductCoverCode { get; set; }
        public virtual string UnderwritingYear { get; set; }
        public virtual string BranchCode { get; set; }
        public virtual string DeptCode { get; set; }
        public virtual DateTime ProposalReceivedDate { get; set; }
        public virtual DateTime DateProposalAccepted { get; set; }
        public virtual string ProposalStatus { get; set; }
        public virtual DateTime PolicyIssueDate { get; set; }
        public virtual DateTime PolicyEffectiveDate { get; set; }
        public virtual string BrokerAgentCode { get; set; }
        public virtual string BusinessSource { get; set; }
        public virtual string AgencyCode { get; set; }
        public virtual string AssuredCode { get; set; }
        public virtual DateTime AssuredDateOfBirth { get; set; }
        public virtual string AssuredHeight { get; set; }
        public virtual string AssuredWeight { get; set; }
        public virtual string AssuredHeightType { get; set; }
        public virtual string AssuredWeightType { get; set; }
        public virtual string AssuredAgeProofDoc { get; set; }
        public virtual string AgeCalculated { get; set; }
        public virtual string Nationality { get; set; }
        public virtual string Gender { get; set; }
        public virtual string MaritalStatus { get; set; }
        public virtual string Occupation { get; set; }
        public virtual string OccupationClass { get; set; }
        public virtual string Religion { get; set; }
        public virtual string Relation { get; set; }
        public virtual string PlaceOfBirth { get; set; }
        public virtual string PolicyStatus { get; set; }
        public virtual DateTime StatusDate { get; set; }
        public virtual DateTime WaiverEffectiveDate { get; set; }
        public virtual DateTime PaidUpEffectiveDate { get; set; }
        public virtual DateTime CancellationEffectiveDate { get; set; }
        public virtual DateTime LapseEffectiveDate { get; set; }
        public virtual DateTime ReactivationEffectiveDate { get; set; }
        public virtual string Tag { get; set; }
        public virtual string Flag { get; set; }
        public virtual string OperId { get; set; }
        public virtual DateTime EntryDate { get; set; }

    }
}