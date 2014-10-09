Imports System
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRG_LI_PRD_CAT
    Inherits System.Web.UI.Page

    Dim catRepo As ProductCatRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim prodCat As CustodianLife.Model.ProductCategories

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            catRepo = New ProductCatRepository()
            Session("catRepo") = catRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("id")
            Session("pcid") = strKey
            If strKey IsNot Nothing Then
                fillValues()

            Else
                catRepo = CType(Session("catRepo"), ProductCatRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The prodCatcodes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the cover  object
            prodCat = New CustodianLife.Model.ProductCategories()
            catRepo = New ProductCatRepository()
            lblError.Visible = False

            prodCat.ProductCatCode = cmbCatCode.SelectedValue
            prodCat.ProductCatDesc = txtCodeLongDesc.Text
            prodCat.ProductCatShortDesc = txtCodeShortDesc.Text
            prodCat.ProductCatModule = cmbModule.SelectedValue
            
            catRepo.Save(prodCat)
            Session("prodCat") = prodCat
        Else
            prodCat = CType(Session("prodCat"), CustodianLife.Model.ProductCategories)
            catRepo = CType(Session("catRepo"), ProductCatRepository)

            prodCat.ProductCatCode = cmbCatCode.SelectedValue
            prodCat.ProductCatDesc = txtCodeLongDesc.Text
            prodCat.ProductCatShortDesc = txtCodeShortDesc.Text
            prodCat.ProductCatModule = cmbModule.SelectedValue
            catRepo.Save(prodCat)

        End If

        initializeFields()
    End Sub
    Private Sub fillValues()

        strKey = CType(Session("pcid"), String)
        catRepo = CType(Session("catRepo"), ProductCatRepository)
        prodCat = catRepo.GetById(strKey)
        Session("prodCat") = prodCat
        If prodCat IsNot Nothing Then

            cmbCatCode.SelectedValue = prodCat.ProductCatCode
            txtCodeLongDesc.Text = prodCat.ProductCatDesc
            txtCodeShortDesc.Text = prodCat.ProductCatShortDesc
            cmbModule.SelectedValue = prodCat.ProductCatModule
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbCatCode.SelectedIndex = 0
        txtCodeLongDesc.Text = String.Empty
        txtCodeShortDesc.Text = String.Empty
        cmbModule.SelectedIndex = 0

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        prodCat = CType(Session("prodCat"), CustodianLife.Model.ProductCategories)
        catRepo = CType(Session("catRepo"), ProductCatRepository)
        catRepo.Delete(prodCat)
        initializeFields()

    End Sub
End Class