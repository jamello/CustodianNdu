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
Partial Public Class PRG_LI_BRK_COMM
    Inherits System.Web.UI.Page
    Dim brcomRepo As BrokersCommRatesRepository
    Dim prodEnq As ProductDetailsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim BrokerComm As CustodianLife.Model.BrokersCommRates

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            brcomRepo = New BrokersCommRatesRepository
            prodEnq = New ProductDetailsRepository
            Session("brcomRepo") = brcomRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("bcId") = strKey

            Dim lstProdCodes As IList = CType(prodEnq.ProductDetailInfo(), IList) ' these are product codes from details table

            SetComboBinding(cmbProductCodeID, lstProdCodes, "ProductDesc", "ProductCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                brcomRepo = CType(Session("brcomRepo"), BrokersCommRatesRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The BrokerCommerest object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the BrokerCommcode object
            BrokerComm = New CustodianLife.Model.BrokersCommRates()
            brcomRepo = New BrokersCommRatesRepository()
            lblError.Visible = False

            BrokerComm.ProductCode = cmbProductCodeID.SelectedValue
            BrokerComm.StartYear = CType(txtStartYear.Text, Integer)
            BrokerComm.EndYear = CType(txtEndYear.Text, Integer)
            BrokerComm.CommissionRate = CType(txtBrokersCommRate.Text, Decimal)
            BrokerComm.StartPolicyTerm = CType(txtPolicyTermStart.Text, Integer)
            BrokerComm.EndPolicyTerm = CType(txtPolicyTermEnd.Text, Integer)

            brcomRepo.Save(BrokerComm)
            Session("BrokerComm") = BrokerComm
        Else
            BrokerComm = CType(Session("BrokerComm"), CustodianLife.Model.BrokersCommRates)
            brcomRepo = CType(Session("brcomRepo"), BrokersCommRatesRepository)

            BrokerComm.ProductCode = cmbProductCodeID.SelectedValue
            BrokerComm.ProductCode = cmbProductCodeID.SelectedValue
            BrokerComm.StartYear = CType(txtStartYear.Text, Integer)
            BrokerComm.EndYear = CType(txtEndYear.Text, Integer)
            BrokerComm.CommissionRate = CType(txtBrokersCommRate.Text, Decimal)
            BrokerComm.StartPolicyTerm = CType(txtPolicyTermStart.Text, Integer)
            BrokerComm.EndPolicyTerm = CType(txtPolicyTermEnd.Text, Integer)
            brcomRepo.Save(BrokerComm)

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

        strKey = CType(Session("bcId"), String)
        brcomRepo = CType(Session("brcomRepo"), BrokersCommRatesRepository)
        BrokerComm = brcomRepo.GetById(strKey)

        Session("BrokerComm") = BrokerComm
        If BrokerComm IsNot Nothing Then
            cmbProductCodeID.SelectedValue = BrokerComm.ProductCode
            txtStartYear.Text = BrokerComm.StartYear
            txtEndYear.Text = BrokerComm.EndYear
            txtBrokersCommRate.Text = BrokerComm.CommissionRate
            txtPolicyTermStart.Text = BrokerComm.StartPolicyTerm
            txtPolicyTermEnd.Text = BrokerComm.EndPolicyTerm
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbProductCodeID.SelectedIndex = 0
        txtStartYear.Text = String.Empty
        txtEndYear.Text = String.Empty
        txtBrokersCommRate.Text = String.Empty
        txtPolicyTermStart.Text = String.Empty
        txtPolicyTermEnd.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        BrokerComm = CType(Session("BrokerComm"), CustodianLife.Model.BrokersCommRates)
        brcomRepo = CType(Session("brcomRepo"), BrokersCommRatesRepository)
        brcomRepo.Delete(BrokerComm)
        initializeFields()
    End Sub
End Class