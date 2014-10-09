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
Partial Public Class PRG_LI_UNDW_RATES
    Inherits System.Web.UI.Page
    Dim pmRepo As PremiumRateMasterRepository
    Dim prodEnq As ProductDetailsRepository
    Dim rattypEnq As RateTypeCodesRepository

    Dim updateFlag As Boolean
    Dim strKey As String
    Dim RatesMst As CustodianLife.Model.PremiumRatesMaster

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            pmRepo = New PremiumRateMasterRepository

            prodEnq = New ProductDetailsRepository
            rattypEnq = New RateTypeCodesRepository

            Session("pmRepo") = pmRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("pmid") = strKey

            SetComboBinding(cmbProductCodeID, prodEnq.ProductDetailInfo(), "ProductDesc", "ProductCode")
            SetComboBinding(cmbRateType, rattypEnq.RateTypeCodesDetails, "RateTypeDesc", "RateTypeCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                pmRepo = CType(Session("pmRepo"), PremiumRateMasterRepository)
            End If
        Else
            pmRepo = CType(Session("pmRepo"), PremiumRateMasterRepository)

        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The RatesMsterest object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the RatesMstcode object
            RatesMst = New CustodianLife.Model.PremiumRatesMaster()
            pmRepo = New PremiumRateMasterRepository()
            lblError.Visible = False

            RatesMst.EndAge = CType(txtEndAge.Text, Integer)
            RatesMst.EndPolicyTerm = CType(txtEndPolicyTerm.Text, Integer)
            RatesMst.ModuleSource = cmbModule.SelectedValue
            RatesMst.PremiumRate = CType(txtPremiumRate.Text, Decimal)
            RatesMst.ProductCode = cmbProductCodeID.SelectedValue
            RatesMst.RateTypeCode = cmbRateType.SelectedValue
            RatesMst.StartAge = CType(txtStartAge.Text, Integer)
            RatesMst.StartPolicyTerm = CType(txtStartPolicyTerm.Text, Integer)

            pmRepo.Save(RatesMst)
            Session("RatesMst") = RatesMst
        Else
            RatesMst = CType(Session("RatesMst"), CustodianLife.Model.PremiumRatesMaster)

            RatesMst.EndAge = CType(txtEndAge.Text, Integer)
            RatesMst.EndPolicyTerm = CType(txtEndPolicyTerm.Text, Integer)
            RatesMst.ModuleSource = cmbModule.SelectedValue
            RatesMst.PremiumRate = CType(txtPremiumRate.Text, Decimal)
            RatesMst.ProductCode = cmbProductCodeID.SelectedValue
            RatesMst.RateTypeCode = cmbRateType.SelectedValue
            RatesMst.StartAge = CType(txtStartAge.Text, Integer)
            RatesMst.StartPolicyTerm = CType(txtStartPolicyTerm.Text, Integer)
            pmRepo.Save(RatesMst)

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

        strKey = CType(Session("pmid"), String)
        RatesMst = pmRepo.GetById(strKey)

        Session("RatesMst") = RatesMst
        If RatesMst IsNot Nothing Then
            txtEndAge.Text = RatesMst.EndAge
            txtEndPolicyTerm.Text = RatesMst.EndPolicyTerm
            cmbModule.SelectedValue = RatesMst.ModuleSource
            txtPremiumRate.Text = RatesMst.PremiumRate
            cmbProductCodeID.SelectedValue = RatesMst.ProductCode
            cmbRateType.SelectedValue = RatesMst.RateTypeCode
            txtStartAge.Text = RatesMst.StartAge
            txtStartPolicyTerm.Text = RatesMst.StartPolicyTerm
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtEndAge.Text = String.Empty
        txtStartAge.Text = String.Empty
        cmbModule.SelectedIndex = 0
        txtPremiumRate.Text = String.Empty
        cmbProductCodeID.SelectedIndex = 0
        cmbRateType.SelectedIndex = 0
        txtEndPolicyTerm.Text = String.Empty
        txtStartPolicyTerm.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        RatesMst = CType(Session("LoanInt"), CustodianLife.Model.PremiumRatesMaster)
        pmRepo = CType(Session("pmRepo"), PremiumRateMasterRepository)
        pmRepo.Delete(RatesMst)
        initializeFields()
    End Sub
End Class