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
Partial Public Class PRG_LI_TRTY_PRPTN
    Inherits System.Web.UI.Page
    Dim tpRepo As TreatyProportionRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim trtyProp As CustodianLife.Model.TreatyProportion

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            tpRepo = New TreatyProportionRepository
            trtyProp = New CustodianLife.Model.TreatyProportion
            indLifeEnq = New IndLifeCodesRepository
            Session("trtyProp") = trtyProp
            Session("tpRepo") = tpRepo

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("tpId") = strKey

            'Dim lstLifeCodes As IList = CType(indLifeEnq.GetById("L01", "012"), IList) ' these are codes for loan interests rate

            'SetComboBinding(cmbLoanCodeID, lstLifeCodes, "CodeLongDesc", "CodeItem")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                tpRepo = CType(Session("tpRepo"), TreatyProportionRepository)
            End If
        Else
            tpRepo = CType(Session("tpRepo"), TreatyProportionRepository)
            trtyProp = CType(Session("trtyProp"), CustodianLife.Model.TreatyProportion)

        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The Interest Rate object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

            trtyProp.StartSumAssuredValue = CType(txtStartSAValue.Text, Decimal)
            trtyProp.SystemModule = cmbModuleID.SelectedValue
            trtyProp.TreatyCompany = txtTreatyCoy.Text
            trtyProp.TreatyType = cmbTreatyType.SelectedValue
            trtyProp.TreatyYear = CType(txtTreatyYear.Text, Int32)

            tpRepo.Save(trtyProp)
            Session("trtyProp") = trtyProp
        Else
            trtyProp.StartSumAssuredValue = CType(txtStartSAValue.Text, Decimal)
            trtyProp.SystemModule = cmbModuleID.SelectedValue
            trtyProp.TreatyCompany = txtTreatyCoy.Text
            trtyProp.TreatyType = cmbTreatyType.SelectedValue
            trtyProp.TreatyYear = CType(txtTreatyYear.Text, Int32)
            tpRepo.Save(trtyProp)

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

        strKey = CType(Session("tpid"), String)
        tpRepo = CType(Session("tpRepo"), TreatyProportionRepository)
        trtyProp = tpRepo.GetById(strKey)

        Session("trtyProp") = trtyProp
        If trtyProp IsNot Nothing Then
            txtStartSAValue.Text = trtyProp.StartSumAssuredValue.ToString()
            cmbModuleID.SelectedValue = trtyProp.SystemModule
            txtTreatyCoy.Text = trtyProp.TreatyCompany
            cmbTreatyType.SelectedValue = trtyProp.TreatyType
            txtTreatyYear.Text = trtyProp.TreatyYear
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtStartSAValue.Text = String.Empty
        cmbModuleID.SelectedIndex = 0
        txtTreatyCoy.Text = String.Empty
        cmbTreatyType.SelectedIndex = 0
        txtTreatyYear.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub


    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        trtyProp = CType(Session("trtyProp"), CustodianLife.Model.TreatyProportion)
        tpRepo = CType(Session("tpRepo"), TreatyProportionRepository)
        tpRepo.Delete(trtyProp)
        initializeFields()
    End Sub
End Class