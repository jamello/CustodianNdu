Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRG_LI_UNDW_RATE_TYPES
    Inherits System.Web.UI.Page

    Dim RTRepo As RateTypeCodesRepository
    Dim prodEnq As ProductDetailsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim RateTypes As CustodianLife.Model.RateTypeCodes

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the cover  object
            RateTypes = New CustodianLife.Model.RateTypeCodes()
            RTRepo = New RateTypeCodesRepository()
            prodEnq = New ProductDetailsRepository

            Session("RateTypes") = RateTypes
            Session("RTRepo") = RTRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("id")
            Session("rtid") = strKey

            Dim lstProdCodes As IList = CType(prodEnq.ProductDetailInfo(), IList)
            SetComboBinding(cmbProductCode, lstProdCodes, "ProductDesc", "ProductCode")
            If strKey IsNot Nothing Then
                fillValues()

            Else
                RTRepo = CType(Session("RTRepo"), RateTypeCodesRepository)
            End If
        Else
            RateTypes = CType(Session("RateTypes"), CustodianLife.Model.RateTypeCodes)
            RTRepo = CType(Session("RTRepo"), RateTypeCodesRepository)

        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The RateTypeCodes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

           RateTypes.RatePer = txtRatePer.Text
           RateTypes.RateTypeCode= txtRateTypeCode.Text
           RateTypes.RateTypeDesc= txtRateTypeDesc.Text
           RateTypes.ModuleSource = cmbModule.SelectedValue
           RateTypes.ProductCode = cmbProductCode.SelectedValue

            RTRepo.Save(RateTypes)
            Session("RateTypes") = RateTypes
        Else
            RateTypes = CType(Session("RateTypes"), CustodianLife.Model.RateTypeCodes)
            RTRepo = CType(Session("RTRepo"), RateTypeCodesRepository)

           RateTypes.RatePer = txtRatePer.Text
           RateTypes.RateTypeCode= txtRateTypeCode.Text
           RateTypes.RateTypeDesc= txtRateTypeDesc.Text
           RateTypes.ModuleSource = cmbModule.SelectedValue
           RateTypes.ProductCode = cmbProductCode.SelectedValue
           RTRepo.Save(RateTypes)

        End If

        initializeFields()
    End Sub

    Private Sub fillValues()

        strKey = CType(Session("rtid"), String)
        RTRepo = CType(Session("RTRepo"), RateTypeCodesRepository)
        RateTypes = RTRepo.GetById(strKey)
        Session("RateTypes") = RateTypes
        If RateTypes IsNot Nothing Then

           txtRatePer.Text = RateTypes.RatePer
           txtRateTypeCode.Text = RateTypes.RateTypeCode
           txtRateTypeDesc.Text = RateTypes.RateTypeDesc
           cmbModule.SelectedValue = RateTypes.ModuleSource
           cmbProductCode.SelectedValue = RateTypes.ProductCode 
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub
    Protected Sub initializeFields()
           txtRatePer.Text = String.Empty
           txtRateTypeCode.Text = String.Empty
           txtRateTypeDesc.Text = String.Empty
           cmbModule.SelectedIndex = 0
           cmbProductCode.SelectedIndex = 0

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        RateTypes = CType(Session("RateTypes"), CustodianLife.Model.RateTypeCodes)
        RTRepo = CType(Session("RTRepo"), RateTypeCodesRepository)
        RTRepo.Delete(RateTypes)
        initializeFields()

    End Sub
End Class