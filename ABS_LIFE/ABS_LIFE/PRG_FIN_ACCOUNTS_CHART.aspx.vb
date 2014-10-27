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
    Dim coyCdEnq As CompanyCodesRepository
    Dim accGrps As AccountGroupsRepository

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the ChartOfAccounts object
            accChart = New CustodianLife.Model.ChartOfAccounts()
            indLifeEnq = New IndLifeCodesRepository
            coaRepo = New AccountsChartRepository()
            coyCdEnq = New CompanyCodesRepository()
            accGrps = New AccountGroupsRepository()


            Session("coaRepo") = coaRepo  'save the repository object in the session
            Session("accChart") = accChart ' save the trans type object in the session

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("ttid") = strKey

            SetComboBinding(cmbCoyCode, coyCdEnq.CompanyCodesDetails, "CompanyLongName", "CompanyCode")
            SetComboBinding(cmbGroup, accGrps.AccountGroupDetails, "AccountGroupLongDesc", "AccountGroupCode")
            SetComboBinding(cmbLedgerType, accGrps.AccountGroupDetails, "MainGroupDesc", "MainGroupCode")

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
                .AccountLedgerType = cmbLedgerType.SelectedValue
                .AccountLevel = cmbLevel.SelectedValue
                .AccountMainGroup = cmbGroup.SelectedValue
                .CompanyCode = cmbCoyCode.SelectedValue
                .EntryDate = Now.Date
                .EntryFlag = "A"
                .FullDescription = txtMainDesc.Text.Trim
                .MainAcctsCode = txtMainCode.Text.Trim
                .OperatorId = "001"
                .ShortDescription = txtSubDesc.Text.Trim
                .SubAcctsCode = txtSubCode.Text.Trim
            End With
            coaRepo.Save(accChart)
            Session("accChart") = accChart
        Else
            With accChart
                .AccountLedgerType = cmbLedgerType.SelectedValue
                .AccountLevel = cmbLevel.SelectedValue
                .AccountMainGroup = cmbGroup.SelectedValue
                .CompanyCode = cmbCoyCode.SelectedValue
                '.CompanyCode = "001"
                .EntryDate = Now.Date
                '.EntryFlag = "A"
                '.OperatorId = "001"
                .FullDescription = txtMainDesc.Text.Trim
                .MainAcctsCode = txtMainCode.Text.Trim
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
                cmbLedgerType.SelectedValue = .AccountLedgerType
                cmbLevel.SelectedValue = .AccountLevel
                cmbGroup.SelectedValue = .AccountMainGroup
                cmbCoyCode.SelectedValue = .CompanyCode
                txtMainDesc.Text = .FullDescription
                txtMainCode.Text = .MainAcctsCode
                txtSubDesc.Text = .ShortDescription
                txtSubCode.Text = .SubAcctsCode
                txtEntryDate.Text = .EntryDate

            End With

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()

        cmbLedgerType.SelectedIndex = 0
        cmbLevel.SelectedIndex = 0
        cmbGroup.SelectedIndex = 0
        cmbCoyCode.SelectedIndex = 0
        txtMainDesc.Text = String.Empty
        txtMainCode.Text = String.Empty
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
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub

End Class