Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Partial Public Class PRG_LI_PRD_DTL
    Inherits System.Web.UI.Page
    Dim prodRepo As ProductDetailsRepository
    Dim catEnq As ProductCatRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim ProductDet As CustodianLife.Model.ProductDetails

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            prodRepo = New ProductDetailsRepository
            catEnq = New ProductCatRepository
            Session("prodRepo") = prodRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("pdid") = strKey

            Dim lstProdCats As IList = CType(catEnq.ProductCategories(), IList) ' these are categories

            SetComboBinding(cmbProductCategory, lstProdCats, "ProductCatDesc", "ProductCatCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                prodRepo = CType(Session("prodRepo"), ProductDetailsRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The ProductDetails object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the ProductDetails object
            ProductDet = New CustodianLife.Model.ProductDetails()
            prodRepo = New ProductDetailsRepository()
            lblError.Visible = False

            ProductDet.ProductCode = txtProductDetailsCode.Text
            ProductDet.ProductDetailsModule = cmbPrdSysModule.SelectedValue
            ProductDet.ProductAgeCalc = cmbAgeCalc.SelectedValue
            ProductDet.ProductCategory = cmbProductCategory.SelectedValue
            ProductDet.ProductDesc = txtDetailsDesc.Text

            ProductDet.ProductInstallPeriod1 = txtFirstSAInstalPayPeriod.Text
            ProductDet.ProductInstallPeriod2 = txtSecondSAInstalPayPeriod.Text
            ProductDet.ProductInstallPeriod3 = txtThirdSAInstalPayPeriod.Text

            ProductDet.ProductInstallPay1 = txtFirstSAInstallPcent.Text
            ProductDet.ProductInstallPay2 = txtSecondSAInstalPcent.Text
            ProductDet.ProductInstallPay3 = txtThirdSAInstalPcent.Text

            ProductDet.ProductPlanCode = cmbPlanCd.SelectedValue
            ' ProductDet.ProductSAInstallType  'to be implemented
            ProductDet.ProductSAMultiple = cmbSumAssuredMultiplePay.SelectedValue

            prodRepo.Save(ProductDet)
            Session("ProductDet") = ProductDet
        Else
            ProductDet = CType(Session("ProductDet"), CustodianLife.Model.ProductDetails)
            prodRepo = CType(Session("prodRepo"), ProductDetailsRepository)

            ProductDet.ProductCode = txtProductDetailsCode.Text
            ProductDet.ProductDetailsModule = cmbPrdSysModule.SelectedValue
            ProductDet.ProductAgeCalc = cmbAgeCalc.SelectedValue
            ProductDet.ProductCategory = cmbProductCategory.SelectedValue
            ProductDet.ProductDesc = txtDetailsDesc.Text

            ProductDet.ProductInstallPeriod1 = txtFirstSAInstalPayPeriod.Text
            ProductDet.ProductInstallPeriod2 = txtSecondSAInstalPayPeriod.Text
            ProductDet.ProductInstallPeriod3 = txtThirdSAInstalPayPeriod.Text

            ProductDet.ProductInstallPay1 = txtFirstSAInstallPcent.Text
            ProductDet.ProductInstallPay2 = txtSecondSAInstalPcent.Text
            ProductDet.ProductInstallPay3 = txtThirdSAInstalPcent.Text

            ProductDet.ProductPlanCode = cmbPlanCd.SelectedValue
            ' ProductDet.ProductSAInstallType  'to be implemented
            ProductDet.ProductSAMultiple = cmbSumAssuredMultiplePay.SelectedValue


            prodRepo.Save(ProductDet)

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

        strKey = CType(Session("pdid"), String)
        prodRepo = CType(Session("prodRepo"), ProductDetailsRepository)
        ProductDet = prodRepo.GetById(strKey)

        Session("ProductDet") = ProductDet
        If ProductDet IsNot Nothing Then
            txtProductDetailsCode.Text = ProductDet.ProductCode
            cmbPrdSysModule.SelectedValue = ProductDet.ProductDetailsModule
            cmbAgeCalc.SelectedValue = ProductDet.ProductAgeCalc
            cmbProductCategory.SelectedValue = ProductDet.ProductCategory
            txtDetailsDesc.Text = ProductDet.ProductDesc

            txtFirstSAInstalPayPeriod.Text = ProductDet.ProductInstallPeriod1
            txtSecondSAInstalPayPeriod.Text = ProductDet.ProductInstallPeriod2
            txtThirdSAInstalPayPeriod.Text = ProductDet.ProductInstallPeriod3

            txtFirstSAInstallPcent.Text = ProductDet.ProductInstallPay1
            txtSecondSAInstalPcent.Text = ProductDet.ProductInstallPay2
            txtThirdSAInstalPcent.Text = ProductDet.ProductInstallPay3

            cmbPlanCd.SelectedValue = ProductDet.ProductPlanCode
            ' ProductDet.ProductSAInstallType  'to be implemented
            cmbSumAssuredMultiplePay.SelectedValue = ProductDet.ProductSAMultiple

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbAgeCalc.SelectedIndex = 0
        txtProductDetailsCode.Text = String.Empty
        cmbPrdSysModule.SelectedIndex = 0
        cmbAgeCalc.SelectedIndex = 0
        cmbProductCategory.SelectedIndex = 0
        txtDetailsDesc.Text = String.Empty

        txtFirstSAInstalPayPeriod.Text = String.Empty
        txtSecondSAInstalPayPeriod.Text = String.Empty
        txtThirdSAInstalPayPeriod.Text = String.Empty

        txtFirstSAInstallPcent.Text = String.Empty
        txtSecondSAInstalPcent.Text = String.Empty
        txtThirdSAInstalPcent.Text = String.Empty

        cmbPlanCd.SelectedIndex = 0
        cmbSumAssuredMultiplePay.SelectedIndex = 0
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        ProductDet = CType(Session("ProductDet"), CustodianLife.Model.ProductDetails)
        prodRepo = CType(Session("prodRepo"), ProductDetailsRepository)
        prodRepo.Delete(ProductDet)
        initializeFields()

    End Sub

    Protected Sub txtProductDetailsCode_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtProductDetailsCode.TextChanged

    End Sub
End Class