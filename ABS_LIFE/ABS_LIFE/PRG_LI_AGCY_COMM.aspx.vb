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
Partial Public Class PRG_LI_AGCY_COMM
    Inherits System.Web.UI.Page
    Dim comRepo As AgencyCommRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim prodEnq As ProductDetailsRepository

    Dim updateFlag As Boolean
    Dim strKey As String
    Dim AgencyComm As CustodianLife.Model.AgencyStandardComm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            AgencyComm = New CustodianLife.Model.AgencyStandardComm
            comRepo = New AgencyCommRepository
            prodEnq = New ProductDetailsRepository

            Session("AgencyComm") = AgencyComm
            Session("comRepo") = comRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("acId") = strKey

            SetComboBinding(cmbProductCodeID, prodEnq.ProductDetailInfo(), "ProductDesc", "ProductCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                comRepo = CType(Session("comRepo"), AgencyCommRepository)
            End If
        Else
            comRepo = CType(Session("comRepo"), AgencyCommRepository)
            AgencyComm = CType(Session("AgencyComm"), CustodianLife.Model.AgencyStandardComm)
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The AgencyCommerest object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

            AgencyComm.ProductCode = cmbProductCodeID.SelectedValue
            AgencyComm.CollectionStartYear = CType(txtCollectionStartYear.Text, Integer)
            AgencyComm.CollectionEndYear = CType(txtCollectionEndYear.Text, Integer)
            AgencyComm.CommissionRate = CType(txtAgencyCommRate.Text, Decimal)
            AgencyComm.PolicyTermStart = CType(txtPolicyTermStart.Text, Integer)
            AgencyComm.PolicyTermEnd = CType(txtPolicyTermEnd.Text, Integer)

            comRepo.Save(AgencyComm)
            Session("AgencyComm") = AgencyComm
        Else
            AgencyComm = CType(Session("AgencyComm"), CustodianLife.Model.AgencyStandardComm)
            comRepo = CType(Session("comRepo"), AgencyCommRepository)

            AgencyComm.ProductCode = cmbProductCodeID.SelectedValue
            AgencyComm.CollectionStartYear = CType(txtCollectionStartYear.Text, Integer)
            AgencyComm.CollectionEndYear = CType(txtCollectionEndYear.Text, Integer)
            AgencyComm.CommissionRate = CType(txtAgencyCommRate.Text, Decimal)
            AgencyComm.PolicyTermStart = CType(txtPolicyTermStart.Text, Integer)
            AgencyComm.PolicyTermEnd = CType(txtPolicyTermEnd.Text, Integer)

            comRepo.Save(AgencyComm)

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

        strKey = CType(Session("acId"), String)
        comRepo = CType(Session("comRepo"), AgencyCommRepository)
        AgencyComm = comRepo.GetById(strKey)

        Session("AgencyComm") = AgencyComm
        If AgencyComm IsNot Nothing Then
            cmbProductCodeID.SelectedValue = AgencyComm.ProductCode
            txtCollectionStartYear.Text = AgencyComm.CollectionStartYear.ToString()
            txtCollectionEndYear.Text = AgencyComm.CollectionEndYear.ToString()
            txtAgencyCommRate.Text = AgencyComm.CommissionRate.ToString()
            txtPolicyTermStart.Text = AgencyComm.PolicyTermStart.ToString()
            txtPolicyTermEnd.Text = AgencyComm.PolicyTermEnd.ToString()
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbProductCodeID.SelectedIndex = 0
        txtCollectionStartYear.Text = String.Empty
        txtCollectionEndYear.Text = String.Empty
        txtAgencyCommRate.Text = String.Empty
        txtPolicyTermStart.Text = String.Empty
        txtPolicyTermEnd.Text = String.Empty
    
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        AgencyComm = CType(Session("AgencyComm"), CustodianLife.Model.AgencyStandardComm)
        comRepo = CType(Session("comRepo"), AgencyCommRepository)
        comRepo.Delete(AgencyComm)
        initializeFields()
    End Sub
End Class