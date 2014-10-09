Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class EntryMenu1
    Inherits System.Web.UI.Page
    Dim rpRepo As RolePermissionsRepository
    Dim polinfo As PolicyInfo
    Dim objRole As CustodianLife.Model.RolePermissions
    Protected publicMsgs As String = String.Empty

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            rpRepo = New RolePermissionsRepository

            Session("rpRepo") = rpRepo


            lblError.Visible = False


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

    <System.Web.Services.WebMethod()> _
   Public Shared Function GetRolePermissions(ByVal _rolename As String) As String
        Dim rolperm As String
        Dim rpRepo As New RolePermissionsRepository()

        rolperm = rpRepo.GetRolePermissions(_rolename)
        Return rolperm

    End Function

End Class