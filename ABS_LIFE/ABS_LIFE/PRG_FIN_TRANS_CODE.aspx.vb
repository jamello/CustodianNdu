Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model

Partial Public Class PRG_FIN_TRANS_CODE
    Inherits System.Web.UI.Page
    Dim indLifeEnq As IndLifeCodesRepository
    Dim ttRepo As TransactionTypesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim transTyp As CustodianLife.Model.TransactionTypes
    Dim coyCdEnq As New CompanyCodesRepository()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the TransactionTypes object
            transTyp = New CustodianLife.Model.TransactionTypes()
            indLifeEnq = New IndLifeCodesRepository
            ttRepo = New TransactionTypesRepository()

            Session("ttRepo") = ttRepo  'save the repository object in the session
            Session("transTyp") = transTyp ' save the trans type object in the session

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("ttid") = strKey

            Dim lstCoyCodes As IList = CType(coyCdEnq.CompanyCodesDetails(), IList) ' these are company codes

            SetComboBinding(cmbCoyCode, lstCoyCodes, "CompanyLongName", "CompanyCode")
            SetComboBinding(cmbBranch, indLifeEnq.GetById("L02", "003"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbDepts, indLifeEnq.GetById("L02", "005"), "CodeLongDesc", "CodeItem")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                ttRepo = CType(Session("ttRepo"), TransactionTypesRepository)
                transTyp = CType(Session("transTyp"), TransactionTypes)
            End If
        Else
            ttRepo = CType(Session("ttRepo"), TransactionTypesRepository)
            transTyp = CType(Session("transTyp"), TransactionTypes)

        End If


    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The TransactionTypes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

            transTyp.Branch = cmbBranch.SelectedValue
            transTyp.CompanyCode = cmbCoyCode.SelectedValue
            transTyp.Department = cmbDepts.SelectedValue

            transTyp.Description = txtTransCodeDesc.Text
            transTyp.TransactionCode = txtTransCode.Text
            ttRepo.Save(transTyp)
            Session("transTyp") = transTyp
        Else
            transTyp.Branch = cmbBranch.SelectedValue
            transTyp.CompanyCode = cmbCoyCode.SelectedValue
            transTyp.Department = cmbDepts.SelectedValue

            transTyp.Description = txtTransCodeDesc.Text
            transTyp.TransactionCode = txtTransCode.Text

            ttRepo.Save(transTyp)

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

        strKey = CType(Session("ttid"), String)
        ttRepo = CType(Session("ttRepo"), TransactionTypesRepository)
        transTyp = ttRepo.GetById(strKey)

        Session("transTyp") = transTyp
        If transTyp IsNot Nothing Then

            cmbBranch.SelectedValue = transTyp.Branch.ToString()
            cmbCoyCode.SelectedValue = transTyp.CompanyCode()
            cmbDepts.SelectedValue = transTyp.Department

            txtTransCodeDesc.Text = transTyp.Description
            txtTransCode.Text = transTyp.TransactionCode

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbBranch.SelectedIndex = 0
        cmbCoyCode.SelectedIndex = 0
        cmbDepts.SelectedIndex = 0

        txtTransCodeDesc.Text = String.Empty
        txtTransCode.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        transTyp = CType(Session("transTyp"), CustodianLife.Model.TransactionTypes)
        ttRepo = CType(Session("ttRepo"), TransactionTypesRepository)
        ttRepo.Delete(transTyp)
        initializeFields()

    End Sub
End Class