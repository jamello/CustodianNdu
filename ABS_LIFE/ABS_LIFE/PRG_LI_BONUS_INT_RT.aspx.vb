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
Partial Public Class PRG_LI_BONUS_INT_RT
    Inherits System.Web.UI.Page
    Dim brRepo As BonusInterestRateRepository
    Dim prodEnq As ProductDetailsRepository
    Dim indcEnq As IndLifeCodesRepository

    Dim updateFlag As Boolean
    Dim strKey As String
    Dim BiRate As CustodianLife.Model.BonusInterestRate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            brRepo = New BonusInterestRateRepository
            prodEnq = New ProductDetailsRepository
            indcEnq = New IndLifeCodesRepository
            Session("brRepo") = brRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("brId") = strKey

            SetComboBinding(cmbRateType, indcEnq.GetById("L01", "017"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbProductCodeID, prodEnq.ProductDetailInfo(), "ProductDesc", "ProductCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                brRepo = CType(Session("brRepo"), BonusInterestRateRepository)
            End If
        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The Bonus Interest Rate object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the BiRatecode object
            BiRate = New CustodianLife.Model.BonusInterestRate()
            brRepo = New BonusInterestRateRepository()
            lblError.Visible = False

            BiRate.BonusRate = CType(txtBonusRate.Text, Decimal)
            BiRate.BonusRatePer = CType(txtRatePer.Text, Integer)
            BiRate.ProductCode = cmbProductCodeID.SelectedValue
            BiRate.BonusRateType = cmbRateType.SelectedValue
            BiRate.BonusYear = CType(txtBonusYear.Text, Integer)

            brRepo.Save(BiRate)
            Session("BiRate") = BiRate
        Else
            BiRate.BonusRate = CType(txtBonusRate.Text, Decimal)
            BiRate.BonusRatePer = CType(txtRatePer.Text, Integer)
            BiRate.ProductCode = cmbProductCodeID.SelectedValue
            BiRate.BonusRateType = cmbRateType.SelectedValue
            BiRate.BonusYear = CType(txtBonusYear.Text, Integer)
            brRepo.Save(BiRate)

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

        strKey = CType(Session("Intid"), String)
        brRepo = CType(Session("brRepo"), BonusInterestRateRepository)
        BiRate = brRepo.GetById(strKey)

        Session("BiRate") = BiRate
        If BiRate IsNot Nothing Then
            txtBonusRate.Text = BiRate.BonusRate.ToString()
            txtRatePer.Text = BiRate.BonusRatePer.ToString()
            cmbProductCodeID.SelectedValue = BiRate.ProductCode
            cmbRateType.SelectedValue = BiRate.BonusRateType
            txtBonusYear.Text = BiRate.BonusYear.ToString()
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtBonusRate.Text = String.Empty
        txtRatePer.Text = String.Empty
        cmbProductCodeID.SelectedIndex = 0
        cmbRateType.SelectedIndex = 0
        txtBonusYear.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        BiRate = CType(Session("BiRate"), CustodianLife.Model.BonusInterestRate)
        brRepo = CType(Session("brRepo"), BonusInterestRateRepository)
        brRepo.Delete(BiRate)
        initializeFields()
    End Sub
End Class