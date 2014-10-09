Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model

Partial Public Class PRG_FIN_BANK_SETUP
    Inherits System.Web.UI.Page
    Dim baRepo As BankAccountsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim bankAcct As CustodianLife.Model.BankAccounts
    Dim coyCdEnq As New CompanyCodesRepository()



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the BankAccounts object
            bankAcct = New CustodianLife.Model.BankAccounts()
            baRepo = New BankAccountsRepository()

            Session("ttRepo") = baRepo 'save the repository object in the session
            Session("bankAcct") = bankAcct ' save the trans type object in the session

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("baid") = strKey

            Dim lstCoyCodes As IList = CType(coyCdEnq.CompanyCodesDetails(), IList) ' these are company codes

            SetComboBinding(cmbCoyCode, lstCoyCodes, "CompanyLongName", "CompanyCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                baRepo = CType(Session("baRepo"), BankAccountsRepository)
                bankAcct = CType(Session("bankAcct"), BankAccounts)
            End If
        Else
            baRepo = CType(Session("baRepo"), BankAccountsRepository)
            bankAcct = CType(Session("bankAcct"), BankAccounts)

        End If



    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The BankAccounts object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

            bankAcct.BranchCode = cmbBranch.SelectedValue
            bankAcct.CompanyCode = cmbCoyCode.SelectedValue
            bankAcct.BankPaymentMode = cmbPayMode.SelectedValue

            bankAcct.BankTransType = cmbTransType.SelectedValue

            bankAcct.StartBankDepartment = cmbStartDept.SelectedValue
            bankAcct.StartBankDivision = cmbStartBankDiv.SelectedValue

            bankAcct.EndBankDepartment = cmbEndDept.SelectedValue
            bankAcct.EndBankDivision = cmbEndDept.SelectedValue

            bankAcct.GLMainAccount = txtGLMainAcct.Text
            bankAcct.GLSubAccount = txtGLSubAcct.Text
            bankAcct.OurBankCode = txtBankCode.Text

            baRepo.Save(bankAcct)
            Session("bankAcct") = bankAcct
        Else
            bankAcct.BranchCode = cmbBranch.SelectedValue
            bankAcct.CompanyCode = cmbCoyCode.SelectedValue
            bankAcct.BankPaymentMode = cmbPayMode.SelectedValue

            bankAcct.BankTransType = cmbTransType.SelectedValue

            bankAcct.StartBankDepartment = cmbStartDept.SelectedValue
            bankAcct.StartBankDivision = cmbStartBankDiv.SelectedValue

            bankAcct.EndBankDepartment = cmbEndDept.SelectedValue
            bankAcct.EndBankDivision = cmbEndDept.SelectedValue

            bankAcct.GLMainAccount = txtGLMainAcct.Text
            bankAcct.GLSubAccount = txtGLSubAcct.Text
            bankAcct.OurBankCode = txtBankCode.Text

            baRepo.Save(bankAcct)

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

        strKey = CType(Session("baid"), String)
        baRepo = CType(Session("baRepo"), BankAccountsRepository)
        bankAcct = baRepo.GetById(strKey)

        Session("bankAcct") = bankAcct
        If bankAcct IsNot Nothing Then

            cmbBranch.SelectedValue = bankAcct.BranchCode
            cmbCoyCode.SelectedValue = bankAcct.CompanyCode
            cmbPayMode.SelectedValue = bankAcct.BankPaymentMode

            cmbTransType.SelectedValue = bankAcct.BankTransType

            cmbStartDept.SelectedValue = bankAcct.StartBankDepartment
            cmbStartBankDiv.SelectedValue = bankAcct.StartBankDivision

            cmbEndDept.SelectedValue = bankAcct.EndBankDepartment
            cmbEndDept.SelectedValue = bankAcct.EndBankDivision

            txtGLMainAcct.Text = bankAcct.GLMainAccount
            txtGLSubAcct.Text = bankAcct.GLSubAccount
            txtBankCode.Text = bankAcct.OurBankCode

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbBranch.SelectedIndex = 0
        cmbCoyCode.SelectedIndex = 0
        cmbPayMode.SelectedIndex = 0
        cmbTransType.SelectedIndex = 0

        cmbStartDept.SelectedIndex = 0
        cmbStartBankDiv.SelectedIndex = 0

        cmbEndDept.SelectedIndex = 0
        cmbEndDept.SelectedIndex = 0

        txtGLMainAcct.Text = String.Empty
        txtGLSubAcct.Text = String.Empty
        txtBankCode.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        bankAcct = CType(Session("bankAcct"), CustodianLife.Model.BankAccounts)
        baRepo = CType(Session("baRepo"), BankAccountsRepository)
        baRepo.Delete(bankAcct)
        initializeFields()


    End Sub
End Class