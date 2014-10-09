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
Partial Public Class PRG_LI_TRTY_COMM
    Inherits System.Web.UI.Page
    Dim tcRepo As ReInsuranceTreatyCommissionRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim reinTComm As CustodianLife.Model.ReInsuranceTreatyCommission


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            tcRepo = New ReInsuranceTreatyCommissionRepository
            indLifeEnq = New IndLifeCodesRepository
            Session("tcRepo") = tcRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("tpId") = strKey

            'Dim lstLifeCodes As IList = CType(indLifeEnq.GetById("L01", "012"), IList) ' these are codes for loan interests rate

            'SetComboBinding(cmbLoanCodeID, lstLifeCodes, "CodeLongDesc", "CodeItem")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                tcRepo = CType(Session("tcRepo"), ReInsuranceTreatyCommissionRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The treaty commission object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the reinTCommcode object
            reinTComm = New CustodianLife.Model.ReInsuranceTreatyCommission()
            tcRepo = New ReInsuranceTreatyCommissionRepository()
            lblError.Visible = False

            reinTComm.CommissionRate = CType(txtCommRate.Text, Decimal)
            reinTComm.SystemModule = cmbModuleID.SelectedValue
            reinTComm.EndSumAssuredAmt = CType(txtEndSAAmt.Text, Decimal)
            reinTComm.TreatyType = cmbTreatyType.SelectedValue
            reinTComm.TreatyCommYear = CType(txtTreatyCommYear.Text, Int32)
            reinTComm.ProductCode = cmbProductCode.SelectedValue
            reinTComm.StartSumAssuredAmt = CType(txtStartSAAmt.Text, Decimal)
            reinTComm.SumAssuredEndPeriod = CType(txtStartSAPeriod.Text, Int32)
            reinTComm.SumAssuredStartPeriod = CType(txtStartSAPeriod.Text, Decimal)

            tcRepo.Save(reinTComm)
            Session("reinTComm") = reinTComm
        Else
            reinTComm.CommissionRate = CType(txtCommRate.Text, Decimal)
            reinTComm.SystemModule = cmbModuleID.SelectedValue
            reinTComm.EndSumAssuredAmt = CType(txtEndSAAmt.Text, Decimal)
            reinTComm.TreatyType = cmbTreatyType.SelectedValue
            reinTComm.TreatyCommYear = CType(txtTreatyCommYear.Text, Int32)
            reinTComm.ProductCode = cmbProductCode.SelectedValue
            reinTComm.StartSumAssuredAmt = CType(txtStartSAAmt.Text, Decimal)
            reinTComm.SumAssuredEndPeriod = CType(txtStartSAPeriod.Text, Int32)
            reinTComm.SumAssuredStartPeriod = CType(txtStartSAPeriod.Text, Decimal)
            tcRepo.Save(reinTComm)

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
        tcRepo = CType(Session("tcRepo"), ReInsuranceTreatyCommissionRepository)
        reinTComm = tcRepo.GetById(strKey)

        Session("reinTComm") = reinTComm
        If reinTComm IsNot Nothing Then
            txtCommRate.Text = reinTComm.CommissionRate.ToString()
            cmbModuleID.SelectedValue = reinTComm.SystemModule
            txtEndSAAmt.Text = reinTComm.EndSumAssuredAmt.ToString()
            cmbTreatyType.SelectedValue = reinTComm.TreatyType
            txtTreatyCommYear.Text = reinTComm.TreatyCommYear.ToString()
            cmbProductCode.SelectedValue = reinTComm.ProductCode
            txtStartSAAmt.Text = reinTComm.StartSumAssuredAmt.ToString()
            txtStartSAPeriod.Text = reinTComm.SumAssuredEndPeriod.ToString()
            txtStartSAPeriod.Text = reinTComm.SumAssuredStartPeriod.ToString()
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtCommRate.Text = String.Empty
        cmbModuleID.SelectedIndex = 0
        txtEndSAAmt.Text = String.Empty
        cmbTreatyType.SelectedIndex = 0
        txtTreatyCommYear.Text = String.Empty
        cmbProductCode.SelectedIndex = 0
        txtStartSAAmt.Text = String.Empty
        txtStartSAPeriod.Text = String.Empty
        txtStartSAPeriod.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        reinTComm = CType(Session("reinTComm"), CustodianLife.Model.ReInsuranceTreatyCommission)
        tcRepo = CType(Session("tcRepo"), ReInsuranceTreatyCommissionRepository)
        tcRepo.Delete(reinTComm)
        initializeFields()
    End Sub
End Class