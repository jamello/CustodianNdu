Public Partial Class ChartOfAccountsEntryBrowse
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub butNew_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butNew.Click
        Response.Redirect("PRG_FIN_ACCOUNTS_CHART.aspx")

    End Sub

    Protected Sub butClose_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butClose.Click
        Response.Redirect("EntryMenu1.aspx")

    End Sub
End Class