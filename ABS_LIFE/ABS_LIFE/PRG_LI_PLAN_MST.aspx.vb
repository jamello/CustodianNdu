Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Partial Public Class PRG_LI_PLAN_MST
    Inherits System.Web.UI.Page
    Dim planMstRepo As PlanMasterRepository
    Dim prodEnq As ProductDetailsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim PlanMstDet As CustodianLife.Model.PlanMaster

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            planMstRepo = New PlanMasterRepository
            prodEnq = New ProductDetailsRepository
            Session("planMstRepo") = planMstRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("pmid") = strKey

            Dim lstProds As IList = CType(prodEnq.ProductDetailInfo(), IList) ' list of products
            SetComboBinding(cmbProductCode, lstProds, "ProductDesc", "ProductCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                planMstRepo = CType(Session("planMstRepo"), PlanMasterRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The PlanMaster object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the PlanMaster object
            PlanMstDet = New CustodianLife.Model.PlanMaster()
            planMstRepo = New PlanMasterRepository()
            lblError.Visible = False

            PlanMstDet.ProductCode = cmbProductCode.SelectedValue
            PlanMstDet.AnnualPaymentModeRate = CType(txtAnnualPaymentModeRate.Text, Decimal)
            PlanMstDet.HalfYearlyPaymentModeRate = CType(txtHalfYrPaymentModeRate.Text, Decimal)
            PlanMstDet.LoanAllowed = cmbLoanAllowed.SelectedValue
            PlanMstDet.LoanPercentOnSA = CType(txtLoanPcentSA.Text, Decimal)
            PlanMstDet.MaturityBasedPayment = cmbPaymentMaturityBased.SelectedValue
            PlanMstDet.MaximumAge = CType(txtPlanMaxAge.Text, Integer)
            PlanMstDet.MaximumSA = CType(txtPlanMaxSA.Text, Decimal)
            PlanMstDet.MaximumYears = CType(txtPlanMaxYears.Text, Integer)
            PlanMstDet.MinimumYears = CType(txtPlanMinYears.Text, Integer)
            PlanMstDet.MinimumAge = CType(txtPlanMinAge.Text, Integer)
            PlanMstDet.MinimumSA = CType(txtPlanMinSA.Text, Decimal)
            PlanMstDet.MinimumLoanAmt = CType(txtMinLoanAmt.Text, Decimal)
            PlanMstDet.MonthlyPaymentModeRate = CType(txtMthPaymentModeRate.Text, Decimal)
            PlanMstDet.NumOfYearsBeforeSurrender = CType(txtMaxNoOfYrBeforeSurr.Text, Integer)
            PlanMstDet.PlanCode = txtPlanCode.Text
            PlanMstDet.PlanTerm = CType(txtPlanTerm.Text, Integer)
            PlanMstDet.PolicyValidAfterMaturity = cmbPolicyValidAfterMaturity.SelectedValue
            PlanMstDet.QuarterlyPaymentModeRate = CType(txtQtrPaymentModeRate.Text, Decimal)
            PlanMstDet.SAPaymentPeriodic = cmbSAPeriodic.SelectedValue
            PlanMstDet.SAPaymentSurrenderBased = cmbPaymentSurrenderBased.SelectedValue

            planMstRepo.Save(PlanMstDet)
            Session("planmstdet") = PlanMstDet
        Else
            PlanMstDet = CType(Session("PlanMstDet"), CustodianLife.Model.PlanMaster)
            planMstRepo = CType(Session("planMstRepo"), PlanMasterRepository)

            PlanMstDet.ProductCode = cmbProductCode.SelectedValue
            PlanMstDet.AnnualPaymentModeRate = CType(txtAnnualPaymentModeRate.Text, Decimal)
            PlanMstDet.HalfYearlyPaymentModeRate = CType(txtHalfYrPaymentModeRate.Text, Decimal)
            PlanMstDet.LoanAllowed = cmbLoanAllowed.SelectedValue
            PlanMstDet.LoanPercentOnSA = CType(txtLoanPcentSA.Text, Decimal)
            PlanMstDet.MaturityBasedPayment = cmbPaymentMaturityBased.SelectedValue
            PlanMstDet.MaximumAge = CType(txtPlanMaxAge.Text, Integer)
            PlanMstDet.MaximumSA = CType(txtPlanMaxSA.Text, Decimal)
            PlanMstDet.MaximumYears = CType(txtPlanMaxYears.Text, Integer)
            PlanMstDet.MinimumAge = CType(txtPlanMinAge.Text, Integer)
            PlanMstDet.MinimumSA = CType(txtPlanMinSA.Text, Decimal)
            PlanMstDet.MinimumLoanAmt = CType(txtMinLoanAmt.Text, Decimal)
            PlanMstDet.MinimumYears = CType(txtPlanMinYears.Text, Integer)
            PlanMstDet.MonthlyPaymentModeRate = CType(txtMthPaymentModeRate.Text, Decimal)
            PlanMstDet.NumOfYearsBeforeSurrender = CType(txtMaxNoOfYrBeforeSurr.Text, Integer)
            PlanMstDet.PlanCode = txtPlanCode.Text
            PlanMstDet.PlanTerm = CType(txtPlanTerm.Text, Integer)
            PlanMstDet.PolicyValidAfterMaturity = cmbPolicyValidAfterMaturity.SelectedValue
            PlanMstDet.QuarterlyPaymentModeRate = CType(txtQtrPaymentModeRate.Text, Decimal)
            PlanMstDet.SAPaymentPeriodic = cmbSAPeriodic.SelectedValue
            PlanMstDet.SAPaymentSurrenderBased = cmbPaymentSurrenderBased.SelectedValue
            planMstRepo.Save(PlanMstDet)

        End If

        initializeFields()
    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub
    Private Sub fillValues()

        strKey = CType(Session("pmId"), String)
        planMstRepo = CType(Session("planMstRepo"), PlanMasterRepository)
        PlanMstDet = planMstRepo.GetById(strKey)

        Session("PlanMstDet") = PlanMstDet
        If PlanMstDet IsNot Nothing Then
            cmbProductCode.SelectedValue = PlanMstDet.ProductCode
            txtAnnualPaymentModeRate.Text = PlanMstDet.AnnualPaymentModeRate.ToString()
            txtHalfYrPaymentModeRate.Text = PlanMstDet.HalfYearlyPaymentModeRate.ToString()
            cmbLoanAllowed.SelectedValue = PlanMstDet.LoanAllowed
            txtLoanPcentSA.Text = PlanMstDet.LoanPercentOnSA.ToString()
            cmbPaymentMaturityBased.SelectedValue = PlanMstDet.MaturityBasedPayment
            txtPlanMaxAge.Text = PlanMstDet.MaximumAge.ToString()
            txtPlanMaxSA.Text = PlanMstDet.MaximumSA.ToString()
            txtPlanMaxYears.Text = PlanMstDet.MaximumYears.ToString()
            txtPlanMinAge.Text = PlanMstDet.MinimumAge.ToString()
            txtPlanMinSA.Text = PlanMstDet.MinimumSA.ToString()
            txtPlanMinYears.Text = PlanMstDet.MinimumYears.ToString()
            txtMinLoanAmt.Text = PlanMstDet.MinimumLoanAmt.ToString()
            txtMthPaymentModeRate.Text = PlanMstDet.MonthlyPaymentModeRate.ToString()
            txtMaxNoOfYrBeforeSurr.Text = PlanMstDet.NumOfYearsBeforeSurrender.ToString()
            txtPlanCode.Text = PlanMstDet.PlanCode
            txtPlanTerm.Text = PlanMstDet.PlanTerm.ToString()
            cmbPolicyValidAfterMaturity.SelectedValue = PlanMstDet.PolicyValidAfterMaturity
            txtQtrPaymentModeRate.Text = PlanMstDet.QuarterlyPaymentModeRate.ToString()
            cmbSAPeriodic.SelectedValue = PlanMstDet.SAPaymentPeriodic
            cmbPaymentSurrenderBased.SelectedValue = PlanMstDet.SAPaymentSurrenderBased

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbProductCode.SelectedIndex = 0
        txtAnnualPaymentModeRate.Text = String.Empty
        txtHalfYrPaymentModeRate.Text = String.Empty
        cmbLoanAllowed.SelectedIndex = 0
        txtLoanPcentSA.Text = String.Empty
        cmbPaymentMaturityBased.SelectedIndex = 0
        txtPlanMaxAge.Text = String.Empty
        txtPlanMaxSA.Text = String.Empty
        txtPlanMaxYears.Text = String.Empty
        txtPlanMinAge.Text = String.Empty
        txtPlanMinSA.Text = String.Empty
        txtMinLoanAmt.Text = String.Empty
        txtMthPaymentModeRate.Text = String.Empty
        txtMaxNoOfYrBeforeSurr.Text = String.Empty
        txtPlanCode.Text = String.Empty
        txtPlanTerm.Text = String.Empty
        cmbPolicyValidAfterMaturity.SelectedIndex = 0
        txtQtrPaymentModeRate.Text = String.Empty
        txtPlanMinYears.Text = String.Empty
        cmbSAPeriodic.SelectedIndex = 0
        cmbPaymentSurrenderBased.SelectedIndex = 0
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        PlanMstDet = CType(Session("PlanMstDet"), CustodianLife.Model.PlanMaster)
        planMstRepo = CType(Session("planMstRepo"), PlanMasterRepository)
        planMstRepo.Delete(PlanMstDet)
        initializeFields()

    End Sub
End Class