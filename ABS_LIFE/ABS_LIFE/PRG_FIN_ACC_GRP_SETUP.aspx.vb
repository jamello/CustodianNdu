Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model

Partial Public Class PRG_FIN_ACC_GRP_SETUP
    Inherits System.Web.UI.Page
    Dim agRepo As AccountGroupsRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim polinfo As PolicyInfo
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim strSchKey As String
    Dim acGroup As CustodianLife.Model.AccountGroup
    Dim coyCdEnq As CompanyCodesRepository

    Protected publicMsgs As String = String.Empty


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            agRepo = New AccountGroupsRepository
            indLifeEnq = New IndLifeCodesRepository
            coyCdEnq = New CompanyCodesRepository

            Session("agRepo") = agRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("agId") = strKey

            'txtEntryDate.Text = Now.Date.ToString()
            'txtEntryDate.ReadOnly = True
            lblError.Visible = False


            SetComboBinding(cmbCoyCode, coyCdEnq.CompanyCodesDetails, "CompanyLongName", "CompanyCode")

            If strKey IsNot Nothing Then
                fillValues()
            Else
                agRepo = CType(Session("agRepo"), AccountGroupsRepository)
            End If

        Else 'post back

            Me.Validate()
            If (Not Me.IsValid) Then
                Dim msg As String
                ' Loop through all validation controls to see which 
                ' generated the error(s).
                Dim oValidator As IValidator
                For Each oValidator In Validators
                    If oValidator.IsValid = False Then
                        msg = msg & "\n" & oValidator.ErrorMessage
                    End If
                Next

                lblError.Text = msg
                lblError.Visible = True
                publicMsgs = "javascript:alert('" + msg + "')"
            End If
        End If


    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click, butSaveN.Click
        Dim msg As String = String.Empty
        Try
            If Me.IsValid Then

                'this routine will persist only one object. 
                '1. The Receipt object

                updateFlag = CType(Session("updateFlag"), Boolean)
                If Not updateFlag Then 'if new record

                    'create a new instance of the group object
                    acGroup = New CustodianLife.Model.AccountGroup
                    agRepo = New AccountGroupsRepository
                    lblError.Visible = False

                    With acGroup
                        .AccountGroupCode = txtGroupCode.Text
                        .AccountGroupLongDesc = txtLongDesc.Text
                        .AccountGroupShortDesc = txtShortDesc.Text
                        .MainGroupCode = txtMainGroupCode.Text
                        .MainGroupDesc = txtMainGroupDesc.Text
                        .LedgerType = cmbLedgerType.SelectedValue
                        .CompanyCode = cmbCoyCode.SelectedValue
                        .EntryDate = Date.Now()
                        .EntryFlag = "A"
                        .OperatorId = "001"
                    End With
                    agRepo.Save(acGroup)
                    Session("acGroup") = acGroup
                    msg = "Save Operation Successful"
                    lblError.Text = msg
                    lblError.Visible = True
                    publicMsgs = "javascript:alert('" + msg + "')"

                Else
                    acGroup = CType(Session("acGroup"), CustodianLife.Model.AccountGroup)
                    agRepo = CType(Session("agRepo"), AccountGroupsRepository)

                    With acGroup
                        .AccountGroupCode = txtGroupCode.Text
                        .AccountGroupLongDesc = txtLongDesc.Text
                        .AccountGroupShortDesc = txtShortDesc.Text
                        .MainGroupCode = txtMainGroupCode.Text
                        .MainGroupDesc = txtMainGroupDesc.Text
                        .LedgerType = cmbLedgerType.SelectedValue
                    End With
                    agRepo.Save(acGroup)
                    msg = "Save Operation Successful"
                    lblError.Text = msg
                    lblError.Visible = True
                    publicMsgs = "javascript:alert('" + msg + "')"
                End If

                initializeFields()


            End If
        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"

        End Try

    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub


    Private Sub fillValues()

        strKey = CType(Session("agId"), String)
        agRepo = CType(Session("agRepo"), AccountGroupsRepository)
        acGroup = agRepo.GetById(strKey)

        Session("acGroup") = acGroup
        If acGroup IsNot Nothing Then

            With acGroup
                txtGroupCode.Text = .AccountGroupCode
                txtLongDesc.Text = .AccountGroupLongDesc
                txtShortDesc.Text = .AccountGroupShortDesc
                txtMainGroupCode.Text = .MainGroupCode
                txtMainGroupDesc.Text = .MainGroupDesc
                cmbLedgerType.SelectedValue = .LedgerType
                cmbCoyCode.SelectedValue = .CompanyCode
            End With

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()


        txtGroupCode.Text = String.Empty
        txtLongDesc.Text = String.Empty
        txtMainGroupCode.Text = String.Empty
        txtMainGroupDesc.Text = String.Empty
        txtShortDesc.Text = String.Empty
        cmbCoyCode.SelectedIndex = 0
        cmbLedgerType.SelectedIndex = 0
        grdData.DataBind() 'refresh grid
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

    End Sub



    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        Dim msg As String = String.Empty
        acGroup = CType(Session("acGroup"), CustodianLife.Model.AccountGroup)
        agRepo = CType(Session("agRepo"), AccountGroupsRepository)
        Try
            agRepo.Delete(acGroup)
        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"
        End Try
        initializeFields()


    End Sub
End Class