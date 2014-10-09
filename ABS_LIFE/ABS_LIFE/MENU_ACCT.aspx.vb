Public Partial Class MENU_ACCT
    Inherits System.Web.UI.Page

    Protected STRMENU_TITLE As String
    Protected BufferStr As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If txtAction.Text = "Log_Out" Then
            Call DoProc_LogOut()
            txtAction.Text = ""
            'Response.Redirect("LoginP.aspx")
            'Response.Redirect(Request.ApplicationPath & "~/Default.aspx")
            Response.Redirect(Request.ApplicationPath & "~/m_menu.aspx?menu=home")
            Exit Sub
        End If


        'Put user code to initialize the page here
        Dim mKey As String
        Try
            mKey = Page.Request.QueryString("menu").ToString
            'mkey options = MKT UND CLM REIN CRCO ACC ADMIN
        Catch
            mKey = "HOME"
        End Try

        STRMENU_TITLE = "+++ Home Page +++ "
        BufferStr = ""
        Call DoProc_Menu(mKey)
    End Sub
    Private Sub DoProc_Menu(ByVal pvMenu As String)
        Select Case pvMenu.ToUpper
            Case "HOME"
                STRMENU_TITLE = "+++ Life Accounts Module+++ "
                'AddMenuItem("", "Welcome to ABS Web Accounts Manager", "MainM.aspx?menu=HOME")
                BufferStr += "<tr>"
                BufferStr += "<td align='center' valign='top'>"
                BufferStr += "&nbsp;<img alt='Image' src='../Images/Discussion.jpg' style='width: 800px; height: 500px' />&nbsp;"
                BufferStr += "</td>"
                BufferStr += "</tr>"

            Case "GEN"
                STRMENU_TITLE = "+++ Parameters Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=home")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Company Data Setup", "javascript:jsDoPopNew_Full('General/GEN110.aspx?TTYPE=COY')")
                AddMenuItem("", "Server Parameters Setup", "menu_il.aspx?menu=GEN")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=home")

            Case "GLP_CODE"
                STRMENU_TITLE = "+++ Master Setup Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=home")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("Master Setup", "Customer Category Setup", "acc_1110.aspx?optd=Cust_Category")
                AddMenuItem("", "Customer Master", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Transaction Codes Setup", "")
                AddMenuItem("", "Currency Codes Setup", "")
                AddMenuItem("", "Exchange Rate Setup", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Main Account Setup", "")
                AddMenuItem("", "Sub Account Setup", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Activity Codes Setup", "")
                AddMenuItem("", "Underwriting Codes Cross Ref to General Ledger", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Edit Report", "List of Transaction Codes", "")
                AddMenuItem("", "Chart of Accounts List", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=home")

            Case "GLP_MENU"
                STRMENU_TITLE = "+++ General Ledger Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=home")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("General Ledger", "General Ledger Transactions", "menu_acc.aspx?menu=glp_trn")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "General Ledger Processing", "menu_acc.aspx?menu=glp_process")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Queries", "menu_acc.aspx?menu=glp_query")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "General Report", "menu_acc.aspx?menu=glp_rpt")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=home")

            Case "GLP_TRN"
                STRMENU_TITLE = "+++ General Ledger Transactions Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Transactions", "Cash/Bank Receipt Entry", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Cash/Bank Payment Entry", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Journal Entry", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Edit Report", "List of Transaction - Status Wise", "")
                AddMenuItem("", "List of Posted/Unposted Transactions", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
            Case "GLP_PROCESS"
                STRMENU_TITLE = "+++ General Ledger Processing Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("Processing", "Transaction Processing", "")
                AddMenuItem("", "Allocation JV Processing", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Month End Processing", "")
                AddMenuItem("", "Month End Closing", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Year End Processing", "")
                AddMenuItem("", "Year End Closing", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
            Case "GLP_QUERY"
                STRMENU_TITLE = "+++ General Ledger Query Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("General Ledger Query", "Account Balance Query", "")
                AddMenuItem("", "Allocation JV Tracking", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")

            Case "GLP_RPT"
                STRMENU_TITLE = "+++ General Ledger Report Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Operational Report", "Bank/Cash Book Position", "")
                AddMenuItem("", "Bank/Cash Book Details", "")
                AddMenuItem("", "General Ledger Details List (Main Accounts)", "")
                AddMenuItem("", "General Ledger Details List (Sub Accounts)", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Trial Balance", "Main Accounts Trial Balance", "")
                AddMenuItem("", "Sub Accounts Trial Balance", "")
                AddMenuItem("", "Main Accounts Trial Balance by Branch/Department", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Final Accounts", "Income and Expenses Statement", "")
                AddMenuItem("", "Schedule to Income and Expenses Statement", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Balance Sheet", "")
                AddMenuItem("", "Schedule to Balance Sheet", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")

            Case "DEB_MENU"
                STRMENU_TITLE = "+++ Accounts Receivable Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Transactions", "Transaction Entry (Receipts/Journals)", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Processing", "Customer Debit Notes/Receipts Data Processing", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Report", "Customer Statement of Accounts", "")
                AddMenuItem("", "Customer Accounts Schedule", "")
                AddMenuItem("", "Customer Age Analysis", "")
                AddMenuItem("", "List of Outstanding Debit Notes", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "PUR_MENU"
                STRMENU_TITLE = "+++ Accounts Payable Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Transactions", "Suppliers Invoice Entry", "")
                AddMenuItem("", "Payment Transaction Entry", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Processing", "Supplier Invoices/Payments Processing", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Report", "Supplier Statement of Accounts", "")
                AddMenuItem("", "Supplier Accounts Schedule", "")
                AddMenuItem("", "Supplier Age Analysis", "")
                AddMenuItem("", "List of Outstanding Invoices", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "FAP_MENU"
                STRMENU_TITLE = "+++ Fixed Asset Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Asset Master Entry", "menu_acc.aspx?menu=fap_mast")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Asset Transactons", "menu_acc.aspx?menu=fap_trn")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Asset Processing", "menu_acc.aspx?menu=fap_process")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Setup", "menu_acc.aspx?menu=fap_setup")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Asset Reports", "menu_acc.aspx?menu=fap_rpt")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "FAP_MAST"
                STRMENU_TITLE = "+++ Fixed Asset Master Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("Masters", "Asset Master Entry", "")
                AddMenuItem("", "Asset Category Master", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "FAP_TRN"
                STRMENU_TITLE = "+++ Fixed Asset Transaction Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "FAP_PROCESS"
                STRMENU_TITLE = "+++ Fixed Asset Processing Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "FAP_RPT"
                STRMENU_TITLE = "+++ Fixed Asset Report Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=fap_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link

            Case "SEC"
                STRMENU_TITLE = "+++ Security Menu +++ "
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=glp_menu")
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Administrator Password Change", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "Create New User", "")
                AddMenuItem("", "User Password Change", "")
                AddMenuItem("", "", "") 'blank link
                AddMenuItem("", "UNDER_LINE", "") 'blank link
                AddMenuItem("", "Returns to Previous Page", "menu_acc.aspx?menu=il_acc")

        End Select

    End Sub

    Private Sub AddMenuItem(ByVal LeadItem As String, ByVal MenuItemText As String, ByVal LinkUrl As String)
        Dim myURL As String
        myURL = LinkUrl
        If Trim(myURL) = "" Then
            myURL = "'#'"
        Else
            myURL = "'" & myURL & "'"
        End If

        BufferStr += "<tr>"
        If LeadItem.Trim() = "" Then
            BufferStr += "<td nowrap align='left' valign='top'>&nbsp;&nbsp;</td>"
        Else
            BufferStr += "<td nowrap align='left' valign='top' class='a_sub_menu'>&nbsp;"
            BufferStr += "<img alt='Menu Image' src='../Images/ballred.gif' class='MY_IMG_LINK' />&nbsp;"
            BufferStr += LeadItem & "&nbsp;</td>"
        End If

        If MenuItemText.Trim = "" Then
            BufferStr += "<td nowrap align='left' valign='top'>&nbsp;</td>"
        ElseIf MenuItemText.Trim = "UNDER_LINE" Then
            BufferStr += "<td nowrap align='left' valign='top' class='td_under_line'>&nbsp;</td>"
        ElseIf MenuItemText.Trim = "Returns to Previous Page" Then
            BufferStr += "<td nowrap align='left' valign='top' class='td_return_menu'>"
            BufferStr += "<a href=" & myURL & " valign='top' class='a_return_menu'>" & MenuItemText & "</a>"
            BufferStr += "</td>"
        Else
            BufferStr += "<td nowrap align='left' valign='top' class='td_sub_menu2'>"
            BufferStr += "<img alt='Menu Image' src='../Images/ballredx.gif' class='MY_IMG_LINK' />&nbsp;"
            BufferStr += "<a href=" & myURL & " valign='top' class='a_sub_menu2'>" & MenuItemText & "</a>"
            BufferStr += "</td>"
        End If
        BufferStr += "</tr>"
    End Sub

    Protected Sub DoProc_LogOut()

        Dim strSess As String = ""
        Dim intC As Integer = 0
        Dim intCX As Integer = 0
        Dim MyArray(15) As String

        intC = 0
        intCX = 0
        Try
            'Session("STFID") = RTrim(Me.txtNum.Text)
            'Session("STFID") = RTrim("")

            'Session.Keys
            'Session.Count
            'LOOP THROUGH THE SESSION OBJECT
            '*******************************

            'For intC = 0 To Session.Count - 1
            'Response.Write("<br />" & "Item " & intC & " - Key: " & Session.Keys(intC).ToString & " - Value: : " & Session.Item(intC).ToString)
            '
            'Next

            'SAMPLE SESSION DATA
            '*******************
            ''Item 0 - Key: ActiveSess - Value: : 1
            ''Item 1 - Key: StartdDate - Value: : 06/14/2013 7:01:55 PM
            ''Item 2 - Key: connstr - Value: : Provider=SQLOLEDB;Data Source=ABS-PC;Initial Catalog=ABS;User ID=SA;Password=;
            ''Item 3 - Key: connstr_SQL - Value: : Data Source=ABS-PC;Initial Catalog=ABS;User ID=SA;Password=;
            ''Item 4 - Key: CL_COMP_NAME - Value: : CUSTODIAN AND ALLIED INSURANCE PLC
            ''Item(5 - Key) : MyUserIDX(-Value) : ADM()
            ''Item(6 - Key) : MyUserName(-Value) : System(Administrator)
            ''Item 7 - Key: MyUserLevelX - Value: : 0
            ''Item(8 - Key) : MyUserIDX_NIM(-Value) : ADM()
            ''Item(9 - Key) : MyUserName_NIM(-Value) : System(Administrator)
            ''Item 10 - Key: MyUserLevelX_NIM - Value: : 0
            ''Item 11 - Key: MyLogonTime - Value: : 06/14/2013 7:02:05 PM
            ''Item(12 - Key) : MyUserID(-Value) : ADM()


            'For Each strS As String In Session.Keys
            '    '    ' ...
            '    'Response.Write("<br /> Session ID: " & Session.SessionID & " - Key: " & strSess.ToString & " - Value: " & Session.Item(strSess).ToString)

            '    '    If UCase(strSess) = UCase("connstr") Or _
            '    '      UCase(strSess) = UCase("connstr_SQL") Or _
            '    '      UCase(strSess) = UCase("CL_COMP_NAME") Then
            '    '    Else
            '    '        'Session.Remove(strSess)
            '    '    End If
            '    strSess = strS
            '    Response.Write("<br />" & " - Key: " & strSess.ToString & " - Value: : " & Session.Item(strSess).ToString)
            'Next

            For intCX = 0 To Session.Count - 1

                strSess = Session.Keys(intCX).ToString

                If UCase(strSess) = UCase("connstr") Or _
                  UCase(strSess) = UCase("connstr_SQL") Or _
                  UCase(strSess) = UCase("CL_COMP_NAME") Or _
                  UCase(strSess) = UCase("ActiveSess") Or _
                  UCase(strSess) = UCase("StartdDate") Then
                Else
                    intC = intC + 1
                    MyArray(intC) = strSess
                    'Response.Write("<br />" & "Item " & intC & " - Key: " & strSess.ToString & " - Value: : " & Session.Item(strSess).ToString)

                End If

            Next

            'Response.Write("<br />" & "Item ubound(): " & UBound(MyArray).ToString)
            'Response.Write("<br />" & "Item Length: " & MyArray.Length)

            For intCX = 1 To intC

                strSess = MyArray(intCX).ToString

                Response.Write("<br />" & "Removing session Item " & intCX & " - Key: " & strSess.ToString & " - Value: : " & Session.Item(strSess).ToString)
                Session.Remove(strSess.ToString)
                'Session.Contents.Remove(strSess)

            Next

            'Session.Clear()

        Catch ex As Exception
            Response.Write("<br /> Error has Occured at key: " & strSess.ToString & " Reason: " & ex.Message.ToString)
            'Exit Try
        End Try


    End Sub
End Class