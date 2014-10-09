Imports System
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRG_LI_UNDW_CODE
    Inherits System.Web.UI.Page
    Dim indRepo As IndLifeCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim indlife As CustodianLife.Model.LifeCodes

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            indRepo = New IndLifeCodesRepository()
            Session("indRepo") = indRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("qid") = strKey
            If strKey IsNot Nothing Then
                fillValues()

            Else
                indRepo = CType(Session("indRepo"), IndLifeCodesRepository)
            End If
        End If

    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The indlifecodes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        Try

            If cmbCodeID.SelectedValue = "000" Then
                Throw New ApplicationException("Invalid Code selection from the dropdown!")
            End If
            If Not updateFlag Then 'if new record

                'create a new instance of the indlifecode object
                indlife = New CustodianLife.Model.LifeCodes()
                indRepo = New IndLifeCodesRepository()
                lblError.Visible = False

                indlife.CodeItem = txtCodeItem.Text
                indlife.CodeLongDesc = txtCodeLongDesc.Text
                indlife.CodeShortDesc = txtCodeShortDesc.Text
                indlife.CodeTabId = cmbCodeID.SelectedValue
                indlife.CodeType = cmbCodeType.SelectedValue

                indRepo.Save(indlife)
                Session("indlife") = indlife
            Else
                indlife = CType(Session("indlife"), CustodianLife.Model.LifeCodes)
                indRepo = CType(Session("indRepo"), IndLifeCodesRepository)

                indlife.CodeItem = txtCodeItem.Text
                indlife.CodeLongDesc = txtCodeLongDesc.Text
                indlife.CodeShortDesc = txtCodeShortDesc.Text
                indlife.CodeTabId = cmbCodeID.SelectedValue
                indlife.CodeType = cmbCodeType.SelectedValue


                indRepo.Save(indlife)

            End If
        Catch ex As ApplicationException
            lblError.Text = ex.Message
            lblError.Visible = True
        End Try


        initializeFields()

    End Sub
    Private Sub fillValues()

        strKey = CType(Session("qid"), String)
        indRepo = CType(Session("indRepo"), IndLifeCodesRepository)
        indlife = indRepo.GetById(strKey) '"1,LO1,001"

        Session("indlife") = indlife
        If indlife IsNot Nothing Then
            txtCodeLongDesc.Text = indlife.CodeLongDesc
            txtCodeShortDesc.Text = indlife.CodeShortDesc
            cmbCodeType.SelectedValue = indlife.CodeType
            txtCodeItem.Text = indlife.CodeItem
            cmbCodeID.SelectedValue = indlife.CodeTabId
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbCodeID.SelectedIndex = 0
        cmbCodeType.SelectedValue = String.Empty
        txtCodeShortDesc.Text = String.Empty
        txtCodeLongDesc.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record
        ' lblError.Visible = False

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        indlife = CType(Session("indlife"), CustodianLife.Model.LifeCodes)
        indRepo = CType(Session("indRepo"), IndLifeCodesRepository)
        indRepo.Delete(indlife)
        initializeFields()


    End Sub
End Class