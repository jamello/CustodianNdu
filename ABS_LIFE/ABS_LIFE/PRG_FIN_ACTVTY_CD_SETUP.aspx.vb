Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model

Partial Public Class PRG_FIN_ACTVTY_CD_SETUP
    Inherits System.Web.UI.Page
    Dim aaRepo As AccountsActivityCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim actyCode As CustodianLife.Model.AccountsActivityCodes
    Dim coyCdEnq As New CompanyCodesRepository()



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'create a new instance of the AccountsActivityCodes object
            actyCode = New CustodianLife.Model.AccountsActivityCodes()
            aaRepo = New AccountsActivityCodesRepository()

            Session("aaRepo") = aaRepo  'save the repository object in the session
            Session("actyCode") = actyCode ' save the company code object in the session

            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("aaid") = strKey

            Dim lstCoyCodes As IList = CType(coyCdEnq.CompanyCodesDetails(), IList) ' these are company codes

            SetComboBinding(cmbCoyCode, lstCoyCodes, "CompanyLongName", "CompanyCode")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                aaRepo = CType(Session("aaRepo"), AccountsActivityCodesRepository)
                actyCode = CType(Session("actyCode"), AccountsActivityCodes)
            End If
        Else
            aaRepo = CType(Session("aaRepo"), AccountsActivityCodesRepository)
            actyCode = CType(Session("actyCode"), AccountsActivityCodes)

        End If


    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The AccountsActivityCodes object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False
            actyCode.ActivityCode = txtActivityCode.Text
            actyCode.ActivityDescription = txtActivityCode.Text
            actyCode.CompanyCode = cmbCoyCode.SelectedValue


            actyCode.GLMainAccountCode = txtGLMainCode.Text
            actyCode.GLSubAccountCode = txtGLSubCode.Text

            aaRepo.Save(actyCode)
            Session("actyCode") = actyCode
        Else
            actyCode.ActivityCode = txtActivityCode.Text
            actyCode.ActivityDescription = txtActivityCode.Text
            actyCode.CompanyCode = cmbCoyCode.SelectedValue


            actyCode.GLMainAccountCode = txtGLMainCode.Text
            actyCode.GLSubAccountCode = txtGLSubCode.Text
            aaRepo.Save(actyCode)

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

        strKey = CType(Session("ccid"), String)
        aaRepo = CType(Session("aaRepo"), AccountsActivityCodesRepository)
        actyCode = aaRepo.GetById(strKey)

        Session("actyCode") = actyCode
        If actyCode IsNot Nothing Then

            txtActivityCode.Text = actyCode.ActivityCode
            txtActivityCode.Text = actyCode.ActivityDescription
            cmbCoyCode.SelectedValue = actyCode.CompanyCode


            txtGLMainCode.Text = actyCode.GLMainAccountCode
            txtGLSubCode.Text = actyCode.GLSubAccountCode

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtActivityCode.Text = String.Empty
        txtActivityCode.Text = String.Empty
        cmbCoyCode.SelectedIndex = 0


        txtGLMainCode.Text = String.Empty
        txtGLSubCode.Text = String.Empty


        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub

    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        actyCode = CType(Session("actyCode"), CustodianLife.Model.AccountsActivityCodes)
        aaRepo = CType(Session("aaRepo"), AccountsActivityCodesRepository)
        aaRepo.Delete(actyCode)
        initializeFields()

    End Sub
End Class