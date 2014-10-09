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
Partial Public Class PRG_LI_INT_RATE
    Inherits System.Web.UI.Page

    Dim irRepo As InterestRatesRepository
    Dim prodEnq As ProductDetailsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim IntRate As CustodianLife.Model.InterestRates


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            irRepo = New InterestRatesRepository
            prodEnq = New ProductDetailsRepository

            Session("irRepo") = irRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("irId") = strKey


            SetComboBinding(cmbProductCodeID, prodEnq.ProductDetailInfo(), "ProductDesc", "ProductCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                irRepo = CType(Session("irRepo"), InterestRatesRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The Interest Rate object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the IntRatecode object
            IntRate = New CustodianLife.Model.InterestRates()
            irRepo = New InterestRatesRepository()
            lblError.Visible = False

            IntRate.EndTerm = CType(txtEndPolicyTerm.Text, Integer)
            IntRate.EndCountribAmt = CType(txtEndContribAmt.Text, Decimal)
            IntRate.InterestRate = CType(txtInterestRate.Text, Decimal)
            IntRate.InterestRatePer = CType(txtRatePer.Text, Integer)
            IntRate.ProductCode = cmbProductCodeID.SelectedValue
            IntRate.RateType = cmbRateType.SelectedValue
            IntRate.RateEndDate = CType(txtRateEndDate.Text, DateTime)
            IntRate.RateStartDate = CType(txtRateStartDate.Text, DateTime)
            IntRate.StartTerm = CType(txtStartPolicyTerm.Text, Integer)
            IntRate.StartCountribAmt = CType(txtStartContribAmt.Text, Decimal)

            irRepo.Save(IntRate)
            Session("IntRate") = IntRate
        Else
            IntRate.EndTerm = CType(txtEndPolicyTerm.Text, Integer)
            IntRate.EndCountribAmt = CType(txtEndContribAmt.Text, Decimal)
            IntRate.InterestRate = CType(txtInterestRate.Text, Decimal)
            IntRate.InterestRatePer = CType(txtRatePer.Text, Integer)
            IntRate.ProductCode = cmbProductCodeID.SelectedValue
            IntRate.RateType = cmbRateType.SelectedValue
            IntRate.RateEndDate = CType(txtRateEndDate.Text, DateTime)
            IntRate.RateStartDate = CType(txtRateStartDate.Text, DateTime)
            IntRate.StartTerm = CType(txtStartPolicyTerm.Text, Integer)
            IntRate.StartCountribAmt = CType(txtStartContribAmt.Text, Decimal)
            irRepo.Save(IntRate)

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
        irRepo = CType(Session("irRepo"), InterestRatesRepository)
        IntRate = irRepo.GetById(strKey)

        Session("IntRate") = IntRate
        If IntRate IsNot Nothing Then
            txtEndPolicyTerm.Text = IntRate.EndTerm.ToString()
            txtEndContribAmt.Text = IntRate.EndCountribAmt.ToString()
            txtInterestRate.Text = IntRate.InterestRate.ToString()
            txtRatePer.Text = IntRate.InterestRatePer.ToString()
            cmbProductCodeID.SelectedValue = IntRate.ProductCode
            cmbRateType.SelectedValue = IntRate.RateType
            txtRateEndDate.Text = IntRate.RateEndDate.Date.ToString
            txtRateStartDate.Text = IntRate.RateStartDate.Date.ToString()
            txtStartPolicyTerm.Text = IntRate.StartTerm.ToString()
            txtStartContribAmt.Text = IntRate.StartCountribAmt.ToString()
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtEndPolicyTerm.Text = String.Empty
        txtEndContribAmt.Text = String.Empty
        txtInterestRate.Text = String.Empty
        txtRatePer.Text = String.Empty
        cmbProductCodeID.SelectedIndex = 0
        cmbRateType.SelectedIndex = 0
        txtRateEndDate.Text = String.Empty
        txtRateStartDate.Text = String.Empty
        txtStartPolicyTerm.Text = String.Empty
        txtStartContribAmt.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        IntRate = CType(Session("IntRate"), CustodianLife.Model.InterestRates)
        irRepo = CType(Session("irRepo"), InterestRatesRepository)
        irRepo.Delete(IntRate)
        initializeFields()
    End Sub
End Class