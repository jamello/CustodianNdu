Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model

Partial Public Class PRG_FIN_ACCOUNTS_CHART
    Inherits System.Web.UI.Page
    Dim indLifeEnq As IndLifeCodesRepository
    Dim coaRepo As AccountsChartRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim accChart As CustodianLife.Model.ChartOfAccounts
    Dim coyCdEnq As New CompanyCodesRepository()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the ChartOfAccounts object
            accChart = New CustodianLife.Model.ChartOfAccounts()
            indLifeEnq = New IndLifeCodesRepository
            coaRepo = New AccountsChartRepository()

            Session("coaRepo") = coaRepo  'save the repository object in the session
            Session("accChart") = accChart ' save the trans type object in the session

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("ttid") = strKey

            txtCompanyCode.Text = "003"
            txtEntryDate.Text = Now.Date

            If strKey IsNot Nothing Then
                fillValues()

            Else
                coaRepo = CType(Session("coaRepo"), AccountsChartRepository)
                accChart = CType(Session("accChart"), ChartOfAccounts)
            End If
        Else
            coaRepo = CType(Session("coaRepo"), AccountsChartRepository)
            accChart = CType(Session("accChart"), ChartOfAccounts)

        End If



    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The ChartOfAccounts object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False
            With accChart
                .AccountLedgerCode = Trim(txtLedgerCode.Text)
                .AccountLedgerType = txtLedgerType.Text.Trim
                .AccountLevel = txtLevel.Text.Trim
                .AccountMainGroup = txtGroup.Text.Trim
                .AccountMode = txtAccountMode.Text.Trim
                .AccountPolicyType = txtPolicyType.Text.Trim
                .AccountStatus = txtAccountStatus.Text.Trim
                .AccountSub1Group = txtSubGrp1.Text.Trim
                .AccountSub2Group = txtSubGrp2.Text.Trim
                .BusinessType = txtBusType.Text.Trim
                .CompanyCode = "003"
                .EntryDate = Now.Date
                .EntryFlag = "A"
                .FullDescription = txtMainDesc.Text.Trim
                .MainAcctsCode = txtMainCode.Text.Trim
                .OperatorId = "001"
                .ProductCode = txtProductType.Text.Trim
                .ShortDescription = txtSubDesc.Text.Trim
                .SubAcctsCode = txtSubCode.Text.Trim


            End With
            coaRepo.Save(accChart)
            Session("accChart") = accChart
        Else
            With accChart
                .AccountLedgerCode = Trim(txtLedgerCode.Text)
                .AccountLedgerType = txtLedgerType.Text.Trim
                .AccountLevel = txtLevel.Text.Trim
                .AccountMainGroup = txtGroup.Text.Trim
                .AccountMode = txtAccountMode.Text.Trim
                .AccountPolicyType = txtPolicyType.Text.Trim
                .AccountStatus = txtAccountStatus.Text.Trim
                .AccountSub1Group = txtSubGrp1.Text.Trim
                .AccountSub2Group = txtSubGrp2.Text.Trim
                .BusinessType = txtBusType.Text.Trim
                '.CompanyCode = "001"
                .EntryDate = Now.Date
                '.EntryFlag = "A"
                '.OperatorId = "001"
                .FullDescription = txtMainDesc.Text.Trim
                .MainAcctsCode = txtMainCode.Text.Trim
                .ProductCode = txtProductType.Text.Trim
                .ShortDescription = txtSubDesc.Text.Trim
                .SubAcctsCode = txtSubCode.Text.Trim

            End With
            coaRepo.Save(accChart)

        End If

        initializeFields()



    End Sub
    Private Sub fillValues()

        strKey = CType(Session("ttid"), String)
        coaRepo = CType(Session("coaRepo"), AccountsChartRepository)
        accChart = coaRepo.GetById(strKey)

        Session("accChart") = accChart
        If accChart IsNot Nothing Then

            With accChart
                txtLedgerCode.Text = .AccountLedgerCode
                txtLedgerType.Text = .AccountLedgerType
                txtLevel.Text = .AccountLevel
                txtGroup.Text = .AccountMainGroup
                txtAccountMode.Text = .AccountMode
                txtPolicyType.Text = .AccountPolicyType
                txtAccountStatus.Text = .AccountStatus
                txtSubGrp1.Text = .AccountSub1Group
                txtSubGrp2.Text = .AccountSub2Group
                txtBusType.Text = .BusinessType
                txtMainDesc.Text = .FullDescription
                txtMainCode.Text = .MainAcctsCode
                txtProductType.Text = .ProductCode
                txtSubDesc.Text = .ShortDescription
                txtSubCode.Text = .SubAcctsCode
                txtEntryDate.Text = .EntryDate

            End With

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtLedgerCode.Text = String.Empty
        txtLedgerType.Text = String.Empty
        txtLevel.Text = String.Empty
        txtGroup.Text = String.Empty
        txtAccountMode.Text = String.Empty
        txtPolicyType.Text = String.Empty
        txtAccountStatus.Text = String.Empty
        txtSubGrp1.Text = String.Empty
        txtSubGrp2.Text = String.Empty
        txtBusType.Text = String.Empty
        txtMainDesc.Text = String.Empty
        txtMainCode.Text = String.Empty
        txtProductType.Text = String.Empty
        txtSubDesc.Text = String.Empty
        txtSubDesc.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        accChart = CType(Session("accChart"), CustodianLife.Model.ChartOfAccounts)
        coaRepo = CType(Session("coaRepo"), AccountsChartRepository)
        coaRepo.Delete(accChart)
        initializeFields()


    End Sub

    
    Protected Sub butClose_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butClose.Click
        Response.Redirect("ChartOfAccountsEntryBrowse.aspx")

    End Sub
End Class