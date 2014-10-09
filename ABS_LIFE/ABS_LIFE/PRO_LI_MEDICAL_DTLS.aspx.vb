Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRO_LI_MEDICAL_DTLS
    Inherits System.Web.UI.Page
    Dim medRepo As MedicalExamsRepository
    Dim prodEnq As ProductDetailsRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim medExams As CustodianLife.Model.MedicalExams

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            medRepo = New MedicalExamsRepository()
            medExams = New CustodianLife.Model.MedicalExams()
            prodEnq = New ProductDetailsRepository

            Session("medRepo") = medRepo
            Session("medExams") = medExams
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("id")
            Session("pcid") = strKey

            Dim lstProds As IList = CType(prodEnq.ProductDetailInfo(), IList) ' list of products
            SetComboBinding(cmbProductCode, lstProds, "ProductDesc", "ProductCode")


            If strKey IsNot Nothing Then
                fillValues()

            Else
                medRepo = CType(Session("medRepo"), MedicalExamsRepository)
            End If
        Else
            medRepo = CType(Session("medRepo"), MedicalExamsRepository)
            medExams = CType(Session("medExams"), CustodianLife.Model.MedicalExams)

        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The medicalExams object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            'create a new instance of the cover  object
            lblError.Visible = False
            medExams.StartAge = txtStartAge.Text
            medExams.StartSumAssured = txtStartSA.Text
            medExams.EndAge = txtEndAge.Text
            medExams.EndSumAssured = txtEndSA.Text
            medExams.ModuleSource = cmbModule.SelectedValue
            medExams.ProductCode = cmbProductCode.SelectedValue

            medRepo.Save(medExams)
            Session("medExams") = medExams
        Else
            medExams = CType(Session("medExams"), CustodianLife.Model.MedicalExams)
            medRepo = CType(Session("medRepo"), MedicalExamsRepository)

            medExams.StartAge = txtStartAge.Text
            medExams.StartSumAssured = txtStartSA.Text
            medExams.EndAge = txtEndAge.Text
            medExams.EndSumAssured = txtEndSA.Text
            medExams.ModuleSource = cmbModule.SelectedValue
            medExams.ProductCode = cmbProductCode.SelectedValue
            medRepo.Save(medExams)

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

        strKey = CType(Session("pcid"), String)
        medRepo = CType(Session("medRepo"), MedicalExamsRepository)
        medExams = medRepo.GetById(strKey)
        Session("medExams") = medExams
        If medExams IsNot Nothing Then

            txtStartAge.Text = medExams.StartAge
            txtStartSA.Text = medExams.StartSumAssured
            txtEndAge.Text = medExams.EndAge
            txtEndSA.Text = medExams.EndSumAssured
            cmbModule.SelectedValue = medExams.ModuleSource
            cmbProductCode.SelectedValue = medExams.ProductCode
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()

        txtStartAge.Text = String.Empty
        txtStartSA.Text = String.Empty
        txtEndAge.Text = String.Empty
        txtEndSA.Text = String.Empty
        cmbModule.SelectedIndex = 0
        cmbProductCode.SelectedIndex = 0

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        medExams = CType(Session("medExams"), CustodianLife.Model.MedicalExams)
        medRepo = CType(Session("medRepo"), MedicalExamsRepository)
        medRepo.Delete(medExams)
        initializeFields()

    End Sub
End Class