
Partial Class UC_BANP
    Inherits System.Web.UI.UserControl

    Protected STRPAGE_TITLE As String

    Protected STRCOMP_NAME As String

    Protected STRUSER_LOGIN_ID As String
    Protected STRUSER_LOGIN_NAME As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try
            STRCOMP_NAME = CType(Session("CL_COMP_NAME"), String).ToString
        Catch ex As Exception
            'STRCOMP_NAME = gnComp_Name
            STRCOMP_NAME = "ABC COMPANY LTD"
            STRCOMP_NAME = "Custodian Life Assurance Limited"
        End Try

        STRPAGE_TITLE = "LIFE APPLICATION SYSTEM"

        Try
            STRUSER_LOGIN_ID = CType(Session("MyUserIDX"), String).ToString
            STRUSER_LOGIN_NAME = CType(Session("MyUserName"), String).ToString
        Catch ex As Exception
            'UNLO=USER NOT LOG ON
            STRUSER_LOGIN_ID = "UNLO"
            STRUSER_LOGIN_NAME = "*** USER NOT LOGGED ON ***"
            'Response.Redirect("~/M_MENU.aspx")
        End Try

        If Trim(STRUSER_LOGIN_ID) = "" Or Trim(STRUSER_LOGIN_ID) = "UNLO" Then
            'Response.Redirect("~/LoginP.aspx")
            'Response.Redirect("~/LoginP.aspx?Goto=" & Page.Request.Path)
            'Exit Sub
        End If


        'If Not Page.IsPostBack Then
        'Call DoProc_Menu()
        'End If

    End Sub

End Class
