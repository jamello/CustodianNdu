Imports System.Web.Security

Partial Class LoginP
    Inherits System.Web.UI.Page

    'The Navigator-specific stop() method offers a scripted equivalent of clicking
    'the Stop button in the toolbar. Availability of this method allows you to create your
    'own toolbar on your page and hide the toolbar (in the main window with signed
    'scripts or in a subwindow). For example, if you have an image representing the Stop
    'button in your page, you can surround it with a link whose action stops loading, as
    'in the following:
    '   <A HREF=”javascript: void stop()”><IMG SRC=”myStop.gif” BORDER=0></A>
    'A script cannot stop its own document from loading, but it can stop loading of
    'another frame or window. Similarly, if the current document dynamically loads a
    'new image or a multimedia MIME type file as a separate action, the stop() method
    'can halt that process. Even though the stop() method is a window method, it is
    'not tied to any specific window or frame: Stop means stop.

    Protected strCopyRight As String
    Protected dteMydate As String = CType(Format(Now, "dd-MMM-yyyy"), String)

    Protected Structure TabItem
        Dim TabText As String
        Dim TabKey As String
    End Structure

    Protected MenuItems As New ArrayList()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        '***************************************************************************************************

        '' Define the name and type of the client scripts on the page.
        'Dim csname1 As String = "PopupScript"
        'Dim csname2 As String = "ButtonClickScript"
        Dim cstype As Type = Me.GetType()

        If Not (Page.IsPostBack) Then
            'obsolete
            'Page.RegisterStartupScript("starScript", "callKeywords('" + Name + "','Keyword',+'Region');")

            ''new

            'Response.Write("<script language='javascript' type='text/javascript'>myTest();</script>")

            'OK
            'Page.ClientScript.RegisterStartupScript(cstype, "starScript", "myShowDialogue('ade','dele');", True)

            'OK
            'ScriptManager.RegisterStartupScript(Me, cstype, "starScript", "myShowDialogue('ADE','DELE');", True)
            'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "starScript", "myShowDialogue('ADE','D E L E');", True)
            'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "starScript", "alert('Hello This is first function from code behind ');", True)


            'ok
            '' Get a ClientScriptManager reference from the Page class.
            'Dim cs As ClientScriptManager = Page.ClientScript

            ''ok
            '' Check to see if the startup script is already registered.
            'If (Not cs.IsStartupScriptRegistered(cstype, csname1)) Then

            '    Dim cstext1 As String = ""
            '    cstext1 = "alert('Hello World');"
            '    'cstext1 = "<script type='text/javascript'>myShowDialogue('ade','dele');</script>"
            '    cs.RegisterStartupScript(cstype, csname1, cstext1, True)

            'End If


            '' Check to see if the client script is already registered.
            'If (Not cs.IsClientScriptBlockRegistered(cstype, csname2)) Then
            '    'If (Not cs.IsStartupScriptRegistered(cstype, csname2)) Then

            '    Dim cstext2 As New StringBuilder()
            '    'cstext2.Append("<script type='text/javascript'> function myShowDialogue('ade','dele')")
            '    cstext2.Append("<script type='text/javascript'> function DoClick()")
            '    cstext2.Append("{ ")
            '    cstext2.Append("document.Form1.lblMessage.value='Text from client script.';")
            '    cstext2.Append("} ")
            '    cstext2.Append("</script>")
            '    cs.RegisterClientScriptBlock(cstype, csname2, cstext2.ToString(), False)
            '    'cs.RegisterStartupScript(cstype, csname2, cstext2.ToString(), True)

            'End If

            'ok
            'Dim strParam1 As String = "Oduwole"
            'Dim strParam2 As String = "Olasunkanmi"
            'lblJavaScript.Text = "<script type='text/javascript'>myShowDialogue('" & strParam1 & "','" & strParam2 & "'" & ");</script>"

        End If


        '***************************************************************************************************


        'mystrAPP_PATH = HttpRuntime.AppDomainAppPath
        'mystrAPP_PATH = HttpRuntime.AppDomainAppVirtualPath

        'Response.Write("<br />Path: " & HttpRuntime.AppDomainAppPath)
        'Response.Write("<br />Path: " & HttpRuntime.AppDomainAppVirtualPath)
        'Response.Write("<br />Path: " & Server.MapPath("LoginP.aspx"))

        ''CType(Me.GridView1.Rows(0).FindControl("chkSel"), CheckBox).Attributes.Add("onclick", "javascript:myproc('" & 123 & "')")
        'Me.cmdHelp.Attributes.Add("onclick", "javascript:myHelp('" & "./I_LIFE/PRG_LI_BRK_CAT.aspx" & "')")



        'Dim XX As String = HttpContext.Current.Request.Url.AbsolutePath.ToLowerInvariant()
        'Dim URL_That_LinkUp_To_Current_Page As System.Uri = HttpContext.Current.Request.UrlReferrer


        'MenuItems.Clear()
        'Dim myTab As New TabItem()
        'myTab.TabText = "Tab Caption"
        'myTab.TabKey = "Tab URL"
        'MenuItems.Add(myTab)

        'Me.DataList1.DataSource = MenuItems
        'Me.DataList1.DataBind()


        'strCopyRight = "Copyright &copy;" & Year(Now) & " " & STRCOMP_NAME
        strCopyRight = "Copyright &copy;" & Year(Now)

        If Not (Page.IsPostBack) Then
            Me.txtUserID.Enabled = True
            Me.txtUserID.Focus()
        End If

    End Sub

    Protected Sub LoginBtn_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LoginBtn.Click

        If Me.txtUserID.Text = "CRU" And Me.txtUser_PWD.Text = "CRU*123" Then
            Session("MyUserIDX") = Trim(Me.txtUserID.Text)
            Session("MyUserName") = "System Administrator"
            If Request.QueryString("Goto") <> "" Then
                Response.Redirect(Request.QueryString("Goto"))
            Else
                Response.Redirect("M_MENU.aspx?menu=HOME")
            End If
        Else
            Me.lblMessage.Text = "Login information is not correct. Enter Valid User ID and Password..."
            Me.txtUserID.Enabled = True
            Me.txtUserID.Focus()
        End If

    End Sub

    Protected Sub txtUserID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtUserID.TextChanged
        If Me.txtUserID.Text = "CRU" Then
            Me.txtUserName.Text = "System Administrator"
            Me.txtUser_PWD.Enabled = True
            Me.txtUser_PWD.Focus()
        Else
        End If

    End Sub

    'Private Sub Proc_FileUpload()
    '    UploadedFileLog.InnerHtml = ""
    '    If RadUpload1.FileName.Count > 0 Then
    '        For Each postedFile As FileUpload In RadUpload1.UploadedFiles
    '            UploadedFileLog.InnerHtml += "<b>Uploaded file inforamation</b>: <hr />"
    '            UploadedFileLog.InnerHtml += "<b>Nick name</b>: " + NickTextBox.Text
    '            If Not [Object].Equals(postedFile, Nothing) Then
    '                If postedFile.ContentLength > 0 Then
    '                    UploadedFileLog.InnerHtml += String.Format("<br /><b>Filename</b>: {0}", postedFile.FileName)
    '                    UploadedFileLog.InnerHtml += String.Format("<br /><b>File Size</b>: {0} bytes", postedFile.ContentLength)
    '                Else
    '                    UploadedFileLog.InnerHtml += "<br />No uploaded files yet."
    '                End If
    '            Else
    '                UploadedFileLog.InnerHtml += "<br />No uploaded files yet."
    '            End If
    '        Next
    '    End If
    'End Sub


    
End Class
