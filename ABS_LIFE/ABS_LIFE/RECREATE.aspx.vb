Imports CustodianLife.Data
Partial Public Class RECREATE

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SessionProvider.RebuildSchema()
    End Sub

End Class