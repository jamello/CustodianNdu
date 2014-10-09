Imports System
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRG_LI_COV_MST
    Inherits System.Web.UI.Page
    Dim covRepo As ProductCoverDetailsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim covDet As CustodianLife.Model.ProductCoverDetails
    Dim prodEnq As ProductDetailsRepository

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            covDet = New CustodianLife.Model.ProductCoverDetails()
            covRepo = New ProductCoverDetailsRepository()
            prodEnq = New ProductDetailsRepository()
            Session("covDet") = covDet
            Session("covRepo") = covRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("id")
            Session("cvid") = strKey

            SetComboBinding(cmbProductCode, prodEnq.ProductDetailInfo(), "ProductDesc", "ProductCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                covRepo = CType(Session("covRepo"), ProductCoverDetailsRepository)
            End If
        Else
            covRepo = CType(Session("covRepo"), ProductCoverDetailsRepository)
            covDet = CType(Session("covDet"), ProductCoverDetails)
        End If

    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The covDetcodes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the cover  object
            lblError.Visible = False

            covDet.ProductCode = cmbProductCode.SelectedValue
            covDet.ProductCoverCode = txtCoverCode.Text
            covDet.ProductCoverDesc = txtCodeDesc.Text
            covDet.ProductCoverFundType = cmbFundType.SelectedValue
            covDet.ProductCoverMaximumSA = CType(txtMaxSACover.Text, Decimal)
            covDet.ProductCoverMinimumSA = CType(txtMinSACover.Text, Decimal)
            covDet.ProductCoverModule = cmbModuleID.SelectedValue
            covDet.ProductCoverOnBasicRate = cmbBasicRate.SelectedValue
            covDet.ProductCoverRateOn = cmbCoverRateOn.SelectedValue
            covDet.ProductCoverSAPercent = CType(txtSAPcent.Text, Decimal)
            covDet.ProductCoverType = cmbCoverType.SelectedValue
            'covDet.ProductDetail = Nothing
            covRepo.Save(covDet)
            Session("covDet") = covDet
        Else
            covDet = CType(Session("covDet"), CustodianLife.Model.ProductCoverDetails)
            covRepo = CType(Session("covRepo"), ProductCoverDetailsRepository)

            covDet.ProductCode = cmbProductCode.SelectedValue
            covDet.ProductCoverCode = txtCoverCode.Text
            covDet.ProductCoverDesc = txtCodeDesc.Text
            covDet.ProductCoverFundType = cmbFundType.SelectedValue
            covDet.ProductCoverMaximumSA = CType(txtMaxSACover.Text, Decimal)
            covDet.ProductCoverMinimumSA = CType(txtMinSACover.Text, Decimal)
            covDet.ProductCoverModule = cmbModuleID.SelectedValue
            covDet.ProductCoverOnBasicRate = cmbBasicRate.SelectedValue
            covDet.ProductCoverRateOn = cmbCoverRateOn.SelectedValue
            covDet.ProductCoverSAPercent = CType(txtSAPcent.Text, Decimal)
            covDet.ProductCoverType = cmbCoverType.SelectedValue
            'covDet.ProductDetail = Nothing


            covRepo.Save(covDet)

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

        strKey = CType(Session("cvid"), String)
        covRepo = CType(Session("covRepo"), ProductCoverDetailsRepository)
        covDet = covRepo.GetById(strKey) 
        Session("covDet") = covDet
        If covDet IsNot Nothing Then

            cmbProductCode.SelectedValue = covDet.ProductCode
            txtCoverCode.Text = covDet.ProductCoverCode
            txtCodeDesc.Text = covDet.ProductCoverDesc
            cmbFundType.SelectedValue = covDet.ProductCoverFundType
            txtMaxSACover.Text = covDet.ProductCoverMaximumSA.ToString()
            txtMinSACover.Text = covDet.ProductCoverMinimumSA.ToString()
            cmbModuleID.SelectedValue = covDet.ProductCoverModule
            cmbBasicRate.SelectedValue = covDet.ProductCoverOnBasicRate.ToString()
            cmbCoverRateOn.SelectedValue = covDet.ProductCoverRateOn.ToString()
            txtSAPcent.Text = covDet.ProductCoverSAPercent.ToString()
            cmbCoverType.SelectedValue = covDet.ProductCoverType
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbBasicRate.SelectedIndex = 0
        cmbCoverRateOn.SelectedIndex = 0
        cmbCoverType.SelectedIndex = 0
        cmbFundType.SelectedIndex = 0
        cmbModuleID.SelectedIndex = 0
        cmbProductCode.SelectedIndex = 0
        txtCodeDesc.Text = String.Empty
        txtCoverCode.Text = String.Empty
        txtMaxSACover.Text = String.Empty
        txtSAPcent.Text = String.Empty
        txtMinSACover.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        covDet = CType(Session("covDet"), CustodianLife.Model.ProductCoverDetails)
        covRepo = CType(Session("covRepo"), ProductCoverDetailsRepository)
        covRepo.Delete(covDet)
        initializeFields()

    End Sub
End Class