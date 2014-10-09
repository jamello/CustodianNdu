Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class AccountChartBrowse
    Inherits System.Web.UI.Page
    Dim strSchKey As String
    Dim chRepo As ReceiptsRepository

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.EnableViewState = True
        If Not Page.IsPostBack Then

            chRepo = New ReceiptsRepository

            Session("chRepo") = chRepo
            strSchKey = Request.QueryString("MainAcct")
            Session("MainAcct") = strSchKey
            txtParentCode.Text = strSchKey

            If strSchKey IsNot Nothing Then
                fillBrowseValues()
            Else
                chRepo = CType(Session("chRepo"), ReceiptsRepository)
            End If


            'updateFlag = False
            'Session("updateFlag") = updateFlag

        Else 'post back
            chRepo = CType(Session("chRepo"), ReceiptsRepository)
        End If


    End Sub

   

    Private Sub fillBrowseValues()
        txtSearch.Text = strSchKey
        cmbSearchAccount.SelectedIndex = 4




    End Sub

    Protected Sub GridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdView.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            'assuming that the required value column is the second column in gridview
            CType(e.Row.FindControl("butSelect"), Button).Attributes.Add("Onclick", ("javascript:GetRowValue('" _
                            + (e.Row.Cells(1).Text + "," _
                            + e.Row.Cells(2).Text + "," _
                            + e.Row.Cells(3).Text + "," _
                            + e.Row.Cells(4).Text + "," _
                            + e.Row.Cells(5).Text + "')")))
        End If
    End Sub


    Private Sub grdView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdView1.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            'assuming that the required value column is the second column in gridview
            CType(e.Row.FindControl("butSelect"), Button).Attributes.Add("Onclick", ("javascript:GetRowValue('" _
                          + (e.Row.Cells(1).Text + "," _
                            + e.Row.Cells(2).Text + "," _
                            + e.Row.Cells(3).Text + "," _
                            + e.Row.Cells(4).Text + "," _
                            + e.Row.Cells(5).Text + "')")))
        End If
    End Sub

    Protected Sub grdView_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles grdView.SelectedIndexChanged

    End Sub

    Protected Sub butGO_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butGO.Click

    End Sub
End Class