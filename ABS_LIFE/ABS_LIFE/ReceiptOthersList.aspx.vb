Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class ReceiptOthersList
    Inherits System.Web.UI.Page
    Dim chRepo As ReceiptsRepository
    Dim prgKy As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            chRepo = New ReceiptsRepository

            Session("chRepo") = chRepo
            'updateFlag = False
            'Session("updateFlag") = updateFlag

            prgKy = Request.QueryString("prgKey")
            Session("prgKy") = prgKy
            txtProgType.Text = prgKy

        Else 'post back
            chRepo = CType(Session("chRepo"), ReceiptsRepository)

        End If


    End Sub

    Protected Sub butNew_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butNew.Click

        Response.Redirect("PRG_FIN_RECVBLE_ENTRY.aspx?prgKey=" + txtProgType.Text)

    End Sub

    Protected Sub butClose_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butClose.Click
        Response.Redirect("EntryMenu1.aspx")
    End Sub

    Protected Sub butGO_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butGO.Click

    End Sub

    Protected Sub grdData_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles grdData.SelectedIndexChanged

    End Sub
End Class