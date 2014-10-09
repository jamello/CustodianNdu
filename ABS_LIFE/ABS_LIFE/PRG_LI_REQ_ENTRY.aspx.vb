Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories

Partial Public Class PRG_LI_REQ_ENTRY
    Inherits System.Web.UI.Page
    Dim crRepo As ClaimsRequestRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim CReq As CustodianLife.Model.ClaimsRequest

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            crRepo = New ClaimsRequestRepository
            indLifeEnq = New IndLifeCodesRepository
            Session("crRepo") = crRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("tpId") = strKey

            'Dim lstLifeCodes As IList = CType(indLifeEnq.GetById("L01", "012"), IList) ' these are codes for loan interests rate

            'SetComboBinding(cmbLoanCodeID, lstLifeCodes, "CodeLongDesc", "CodeItem")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                crRepo = CType(Session("crRepo"), ClaimsRequestRepository)
            End If
        End If

    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The claims request object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the CReqcode object
            CReq = New CustodianLife.Model.ClaimsRequest()
            crRepo = New ClaimsRequestRepository()
            lblError.Visible = False

            CReq.AdditionalSumClaimedFC = CType(txtAddClaimsAmtFC.Text, Decimal)
            CReq.AdditionalSumClaimedLC = CType(txtAddClaimsAmtLC.Text, Decimal)
            CReq.AssuredAge = CType(txtAssuredAge.Text, Integer)
            CReq.BasicSumClaimedFC = CType(txtBasicClaimsAmtFC.Text, Decimal)
            CReq.BasicSumClaimedLC = CType(txtBasicClaimsAmtLC.Text, Decimal)

            CReq.ClaimsDescription = txtClaimsDescription.Text
            CReq.ClaimsNo = txtClaimsNo.Text

            CReq.ClaimType = cmbClaimsType.SelectedValue
            CReq.EffectiveDate = CType(txtEffectiveDate.Text, Date)
            CReq.NotificationDate = CType(txtNotificationDate.Text, Date)
            CReq.LossType = cmbClaimsType.SelectedValue
            CReq.PolicyEndDate = CType(txtPolicyEndDate.Text, Date)
            CReq.PolicyStartDate = CType(txtPolicyStartDate.Text, Date)
            CReq.PolicyNo = txtPolicyNo.Text
            CReq.ProductCode = txtProductCode.Text
            CReq.UnderwritingYear = CType(txtUnderwritingYear.Text, Integer)
            CReq.SystemModule = cmbPrdSysModule.SelectedValue

            crRepo.Save(CReq)
            Session("CReq") = CReq
        Else
            CReq.AdditionalSumClaimedFC = CType(txtAddClaimsAmtFC.Text, Decimal)
            CReq.AdditionalSumClaimedLC = CType(txtAddClaimsAmtLC.Text, Decimal)
            CReq.AssuredAge = CType(txtAssuredAge.Text, Integer)
            CReq.BasicSumClaimedFC = CType(txtBasicClaimsAmtFC.Text, Decimal)
            CReq.BasicSumClaimedLC = CType(txtBasicClaimsAmtLC.Text, Decimal)

            CReq.ClaimsDescription = txtClaimsDescription.Text
            CReq.ClaimsNo = txtClaimsNo.Text

            CReq.ClaimType = cmbClaimsType.SelectedValue
            CReq.EffectiveDate = CType(txtEffectiveDate.Text, Date)
            CReq.NotificationDate = CType(txtNotificationDate.Text, Date)
            CReq.LossType = cmbClaimsType.SelectedValue
            CReq.PolicyEndDate = CType(txtPolicyEndDate.Text, Date)
            CReq.PolicyStartDate = CType(txtPolicyStartDate.Text, Date)
            CReq.PolicyNo = txtPolicyNo.Text
            CReq.ProductCode = txtProductCode.Text
            CReq.UnderwritingYear = CType(txtUnderwritingYear.Text, Integer)
            CReq.SystemModule = cmbPrdSysModule.SelectedValue
            crRepo.Save(CReq)

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

        strKey = CType(Session("Intid"), String)
        crRepo = CType(Session("crRepo"), ClaimsRequestRepository)
        CReq = crRepo.GetById(strKey)

        Session("CReq") = CReq
        If CReq IsNot Nothing Then
            txtAddClaimsAmtFC.Text = CReq.AdditionalSumClaimedFC.ToString()
            txtAddClaimsAmtLC.Text = CReq.AdditionalSumClaimedLC.ToString()
            txtAssuredAge.Text = CReq.AssuredAge
            txtBasicClaimsAmtFC.Text = CReq.BasicSumClaimedFC.ToString()
            txtBasicClaimsAmtLC.Text = CReq.BasicSumClaimedLC.ToString()

            txtClaimsDescription.Text = CReq.ClaimsDescription
            txtClaimsNo.Text = CReq.ClaimsNo

            cmbClaimsType.SelectedValue = CReq.ClaimType
            txtEffectiveDate.Text = CReq.EffectiveDate.ToString()
            txtNotificationDate.Text = CReq.NotificationDate.ToString()
            cmbClaimsType.SelectedValue = CReq.LossType
            txtPolicyEndDate.Text = CReq.PolicyEndDate.ToString()
            txtPolicyStartDate.Text = CReq.PolicyStartDate.ToString()
            txtPolicyNo.Text = CReq.PolicyNo
            txtProductCode.Text = CReq.ProductCode
            txtUnderwritingYear.Text = CReq.UnderwritingYear
            cmbPrdSysModule.SelectedValue = CReq.SystemModule
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtAddClaimsAmtFC.Text = String.Empty
        txtAddClaimsAmtLC.Text = String.Empty
        txtAssuredAge.Text = String.Empty
        txtBasicClaimsAmtFC.Text = String.Empty
        txtBasicClaimsAmtLC.Text = String.Empty

        txtClaimsDescription.Text = String.Empty
        txtClaimsNo.Text = String.Empty

        cmbClaimsType.SelectedIndex = -1
        txtEffectiveDate.Text = String.Empty
        txtNotificationDate.Text = String.Empty
        cmbClaimsType.SelectedIndex = -1
        txtPolicyEndDate.Text = String.Empty
        txtPolicyStartDate.Text = String.Empty
        txtPolicyNo.Text = String.Empty
        txtProductCode.Text = String.Empty
        txtUnderwritingYear.Text = String.Empty
        cmbPrdSysModule.SelectedIndex = -1
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        CReq = CType(Session("CReq"), CustodianLife.Model.ClaimsRequest)
        crRepo = CType(Session("crRepo"), ClaimsRequestRepository)
        crRepo.Delete(CReq)
        initializeFields()
    End Sub

End Class