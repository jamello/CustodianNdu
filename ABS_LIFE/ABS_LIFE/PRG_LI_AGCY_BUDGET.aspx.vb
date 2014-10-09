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
Partial Public Class PRG_LI_AGCY_BUDGET
    Inherits System.Web.UI.Page
    Dim apRepo As AgencyProductionBudgetRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim apBud As CustodianLife.Model.AgencyProductionBudget

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            apRepo = New AgencyProductionBudgetRepository
            apBud = New CustodianLife.Model.AgencyProductionBudget

            indLifeEnq = New IndLifeCodesRepository
            Session("apRepo") = apRepo
            Session("apBud") = apBud
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("brId") = strKey

            If strKey IsNot Nothing Then
                fillValues()

            Else
                apRepo = CType(Session("apRepo"), AgencyProductionBudgetRepository)
            End If
        Else
            apRepo = CType(Session("apRepo"), AgencyProductionBudgetRepository)
            apBud = CType(Session("apBud"), CustodianLife.Model.AgencyProductionBudget)

        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The Bonus Interest Rate object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

            apBud.AddCollectionExpensesRate = CType(txtAddCollectionExpRate.Text, Decimal)
            apBud.BonusAmount = CType(txtBonusAmount.Text, Integer)
            apBud.BudgetAmount = CType(txtBudgetAmount.Text, Integer) 'cmbProductCodeID.SelectedValue
            apBud.CollectionExpensesRate = CType(txtCollectionExpRate.Text, Decimal) 'cmbRateType.SelectedValue
            apBud.EndNewAgentMonth = CType(txtEndNewAgentMonth.Text, Integer)
            apBud.LunchModeRate = CType(txtLunchModeRate.Text, Decimal)
            apBud.StartNewAgentMonth = CType(txtStartNewAgentMonth.Text, Integer)
            apBud.AgencyTypeCode = cmbAgentTypeCode.SelectedValue

            apRepo.Save(apBud)
            Session("apBud") = apBud
        Else
            apBud.AddCollectionExpensesRate = CType(txtAddCollectionExpRate.Text, Decimal)
            apBud.BonusAmount = CType(txtBonusAmount.Text, Integer)
            apBud.BudgetAmount = CType(txtBudgetAmount.Text, Integer) 'cmbProductCodeID.SelectedValue
            apBud.CollectionExpensesRate = CType(txtCollectionExpRate.Text, Decimal) 'cmbRateType.SelectedValue
            apBud.EndNewAgentMonth = CType(txtEndNewAgentMonth.Text, Integer)
            apBud.LunchModeRate = CType(txtLunchModeRate.Text, Decimal)
            apBud.StartNewAgentMonth = CType(txtStartNewAgentMonth.Text, Integer)
            apBud.AgencyTypeCode = cmbAgentTypeCode.SelectedValue
            apRepo.Save(apBud)

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

        strKey = CType(Session("brid"), String)
        apRepo = CType(Session("apRepo"), AgencyProductionBudgetRepository)
        apBud = apRepo.GetById(strKey)

        Session("apBud") = apBud
        If apBud IsNot Nothing Then
            txtAddCollectionExpRate.Text = apBud.AddCollectionExpensesRate.ToString()
            txtBonusAmount.Text = apBud.BonusAmount.ToString()
            txtBudgetAmount.Text = apBud.BudgetAmount.ToString()
            txtCollectionExpRate.Text = apBud.CollectionExpensesRate.ToString()
            txtEndNewAgentMonth.Text = apBud.EndNewAgentMonth.ToString()
            txtLunchModeRate.Text = apBud.LunchModeRate.ToString()
            txtStartNewAgentMonth.Text = apBud.StartNewAgentMonth.ToString()
            cmbAgentTypeCode.SelectedValue = apBud.AgencyTypeCode
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtAddCollectionExpRate.Text = String.Empty
        txtBonusAmount.Text = String.Empty
        txtBudgetAmount.Text = String.Empty
        txtCollectionExpRate.Text = String.Empty
        txtEndNewAgentMonth.Text = String.Empty
        txtLunchModeRate.Text = String.Empty
        txtStartNewAgentMonth.Text = String.Empty
        cmbAgentTypeCode.SelectedIndex = 0
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record
        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        apBud = CType(Session("apBud"), CustodianLife.Model.AgencyProductionBudget)
        apRepo = CType(Session("apRepo"), AgencyProductionBudgetRepository)
        apRepo.Delete(apBud)
        initializeFields()
    End Sub
End Class