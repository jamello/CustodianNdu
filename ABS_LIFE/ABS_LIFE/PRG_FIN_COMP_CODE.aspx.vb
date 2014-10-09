Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model

Partial Public Class PRG_FIN_COMP_CODE
    Inherits System.Web.UI.Page
    Dim ccRepo As CompanyCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim coyCode As CustodianLife.Model.CompanyCodes

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the CompanyCodes object
            coyCode = New CustodianLife.Model.CompanyCodes()
            ccRepo = New CompanyCodesRepository()

            Session("ccRepo") = ccRepo  'save the repository object in the session
            Session("coyCode") = coyCode ' save the company code object in the session

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("ccid") = strKey

            'Dim lstProdCats As IList = CType(catEnq.ProductCategories(), IList) ' these are categories

            'SetComboBinding(cmbProductCategory, lstProdCats, "ProductCatDesc", "ProductCatCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                ccRepo = CType(Session("ccRepo"), CompanyCodesRepository)
                coyCode = CType(Session("coyCode"), CompanyCodes)
            End If
        Else
            ccRepo = CType(Session("ccRepo"), CompanyCodesRepository)
            coyCode = CType(Session("coyCode"), CompanyCodes)

        End If

    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The CompanyCodes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False
            coyCode.AddressLine1 = txtAddress1.Text
            coyCode.AddressLine2 = txtAddress2.Text
            coyCode.CompanyCode = txtCoyCode.Text

            coyCode.CompanyLongName = txtLongName.Text
            coyCode.CompanyShortName = txtShortName.Text
            coyCode.EmailAddress1 = txtEmail1.Text
            coyCode.EmailAddress2 = txtEmail2.Text
            coyCode.EstablishDate = CType(txtDateEstablished.Text, Date)
            coyCode.GroupSubsidiary = cmbStatus.SelectedValue
            coyCode.PhoneNo1 = txtPhone1.Text
            coyCode.PhoneNo2 = txtPhone2.Text

            coyCode.RegNo = txtRegNo.Text

            ccRepo.Save(coyCode)
            Session("coyCode") = coyCode
        Else
            coyCode.AddressLine1 = txtAddress1.Text
            coyCode.AddressLine2 = txtAddress2.Text
            coyCode.CompanyCode = txtCoyCode.Text

            coyCode.CompanyLongName = txtLongName.Text
            coyCode.CompanyShortName = txtShortName.Text
            coyCode.EmailAddress1 = txtEmail1.Text
            coyCode.EmailAddress2 = txtEmail2.Text
            coyCode.EstablishDate = CType(txtDateEstablished.Text, Date)
            coyCode.GroupSubsidiary = cmbStatus.SelectedValue
            coyCode.PhoneNo1 = txtPhone1.Text
            coyCode.PhoneNo2 = txtPhone2.Text

            coyCode.RegNo = txtRegNo.Text

            ccRepo.Save(coyCode)

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

        strKey = CType(Session("ccid"), String)
        ccRepo = CType(Session("ccRepo"), CompanyCodesRepository)
        coyCode = ccRepo.GetById(strKey)

        Session("coyCode") = coyCode
        If coyCode IsNot Nothing Then

            txtAddress1.Text = coyCode.AddressLine1
            txtAddress2.Text = coyCode.AddressLine2
            txtCoyCode.Text = coyCode.CompanyCode

            txtLongName.Text = coyCode.CompanyLongName
            txtShortName.Text = coyCode.CompanyShortName
            txtEmail1.Text = coyCode.EmailAddress1
            txtEmail2.Text = coyCode.EmailAddress2
            txtDateEstablished.Text = coyCode.EstablishDate.ToShortDateString()
            cmbStatus.SelectedValue = coyCode.GroupSubsidiary
            txtPhone1.Text = coyCode.PhoneNo1
            txtPhone2.Text = coyCode.PhoneNo2

            txtRegNo.Text = coyCode.RegNo
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtAddress1.Text = String.Empty
        txtAddress2.Text = String.Empty
        txtCoyCode.Text = String.Empty

        txtLongName.Text = String.Empty
        txtShortName.Text = String.Empty
        txtEmail1.Text = String.Empty
        txtEmail2.Text = String.Empty
        txtDateEstablished.Text = String.Empty
        cmbStatus.SelectedIndex = 0
        txtPhone1.Text = String.Empty
        txtPhone2.Text = String.Empty

        txtRegNo.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        coyCode = CType(Session("coyCode"), CustodianLife.Model.CompanyCodes)
        ccRepo = CType(Session("ccRepo"), CompanyCodesRepository)
        ccRepo.Delete(coyCode)
        initializeFields()

    End Sub
End Class