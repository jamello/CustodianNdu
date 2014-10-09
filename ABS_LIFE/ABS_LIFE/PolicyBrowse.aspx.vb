Public Partial Class PolicyBrowse
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub grdView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdView.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            'assuming that the required value column is the second column in gridview
            CType(e.Row.FindControl("butSelect"), Button).Attributes.Add("Onclick", ("javascript:GetRowValue('" _
                            + (e.Row.Cells(1).Text + "," _
                            + e.Row.Cells(2).Text + "," _
                            + e.Row.Cells(3).Text + "," _
                            + e.Row.Cells(4).Text + "')")))
        End If

    End Sub

    Protected Sub grdView_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles grdView.SelectedIndexChanged

    End Sub

    Protected Sub butGO_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butGO.Click

    End Sub
End Class