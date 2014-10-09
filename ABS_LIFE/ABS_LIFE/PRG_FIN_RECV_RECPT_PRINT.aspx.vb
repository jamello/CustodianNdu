Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Imports CrystalDecisions.Shared
Imports CrystalDecisions.Web
Imports CrystalDecisions.CrystalReports.Engine

Partial Public Class PRG_FIN_RECV_RECPT_PRINT
    Inherits System.Web.UI.Page
    Dim strPrtKey As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            strPrtKey = Request.QueryString("id")
            Session("strPrtKey") = strPrtKey
            txtRecptNo.Text = strPrtKey
        End If
    End Sub

    Protected Sub butPrintReceipt_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butPrintReceipt.Click

        Dim otherDocs As ReportDocument = New ReportDocument 'Instance of rpt file
        Dim reportpath As String = SiteGlobal.ReportPath
        Dim reportname As String = "Journal.rpt"

        reportpath = reportpath & reportname
        otherDocs.Load(reportpath)

        Dim intC As Integer = 0
        Dim intC2 As Integer = 0

        Dim cr_ds_conn As CrystalDecisions.Shared.DataSourceConnections = otherDocs.DataSourceConnections
        Dim cr_iconinfo As CrystalDecisions.Shared.IConnectionInfo
        For intC = 0 To cr_ds_conn.Count - 1
            cr_iconinfo = cr_ds_conn.Item(intC)
            With cr_iconinfo

                'do this for each distinct database connection, rather than for table

                ' for SQL Server
                'Response.Write("<br/>" & .ServerName)
                'Response.Write("<br/>" & .DatabaseName)
                'Response.Write("<br/>" & .UserID)
                'Response.Write("<br/>" & .Password)
                'Response.Write("<br/>" & .Type.ToString)
                'Response.Write("<br/>" & .Attributes.ToString)

                '.SetConnection(CStr(SiteGlobal.ReportServer), CStr(SiteGlobal.ReportDBR), CStr(SiteGlobal.DBUserR), CStr(SiteGlobal.DBPassWd))

            End With
        Next


        'otherDocs.DataSourceConnections.Clear()
        'otherDocs.DataSourceConnections(0).SetConnection(SiteGlobal.DSNNameR, SiteGlobal.ReportDBR, SiteGlobal.DBUserR, SiteGlobal.DBPassWd)

        'otherDocs.SetDatabaseLogon(SiteGlobal.DBUserR, SiteGlobal.DBPassWd, SiteGlobal.DSNNameR, SiteGlobal.ReportDBR)
        'otherDocs.SetDatabaseLogon("sa", "skyblue9000", "(local)", "CustodianLife_x", True)
        otherDocs.DataSourceConnections(0).SetConnection(CStr(SiteGlobal.DSNNameR), CStr(SiteGlobal.ReportDBR), CStr(SiteGlobal.DBUserR), CStr(SiteGlobal.DBPassWd))

        'otherDocs.SetParameterValue(0, txtRecptNo.Text)
        'otherDocs.SetParameterValue(1, "")
        'otherDocs.SetParameterValue(2, "")
        'otherDocs.SetParameterValue(3, "")


        Dim paramField As ParameterField = New ParameterField
        Dim paramField2 As ParameterField = New ParameterField
        Dim paramField3 As ParameterField = New ParameterField
        Dim paramField4 As ParameterField = New ParameterField
        Dim paramFields As ParameterFields = New ParameterFields
        Dim paramDiscreteValue As ParameterDiscreteValue = New ParameterDiscreteValue
        Dim paramDiscreteValue2 As ParameterDiscreteValue = New ParameterDiscreteValue
        Dim paramDiscreteValue3 As ParameterDiscreteValue = New ParameterDiscreteValue
        Dim paramDiscreteValue4 As ParameterDiscreteValue = New ParameterDiscreteValue
        'Set instances for input parameter 1 -  @pDocNo

        paramField.Name = "@pDocNo"
        paramDiscreteValue.Value = txtRecptNo.Text
        paramField.CurrentValues.Add(paramDiscreteValue)
        paramFields.Add(paramField)

        paramField2.Name = "@pParam1"
        paramDiscreteValue2.Value = ""
        paramField2.CurrentValues.Add(paramDiscreteValue2)
        paramFields.Add(paramField2)

        paramField3.Name = "@pParam2"
        paramDiscreteValue3.Value = ""
        paramField3.CurrentValues.Add(paramDiscreteValue3)
        paramFields.Add(paramField3)

        paramField4.Name = "@pParam3"
        paramDiscreteValue4.Value = ""
        paramField4.CurrentValues.Add(paramDiscreteValue4)
        paramFields.Add(paramField4)


        'Add the paramField to paramFields
        'paramFields.Add(paramField)
        'CrystalReportViewer1.ParameterFieldInfo = paramFields



        '6 view the report
        With CrystalReportViewer1
            .ParameterFieldInfo = paramFields
            .ReportSource = otherDocs
            '.RefreshReport()
            '.EnableDatabaseLogonPrompt = False
            '.EnableParameterPrompt = False
            .HasPrintButton = True
            .HasRefreshButton = True
            .HasRefreshButton = True
            .HasSearchButton = True
            .HasZoomFactorList = True
            .HasToggleGroupTreeButton = True
            .HasZoomFactorList = True
            .HasPageNavigationButtons = True
            .HasGotoPageButton = True
            .DisplayPage = True
            .DisplayToolbar = True
            .DisplayGroupTree = True
            .DataBind()

        End With

        ' MyShow_Report()


    End Sub

    Private Sub MyShow_Report(Optional ByVal pvCODE As String = "")

        Dim oConInfo As New CrystalDecisions.Shared.ConnectionInfo
        With oConInfo
            .AllowCustomConnection = True
            '.Type = ConnectionInfoType.SQL
            .Type = ConnectionInfoType.CRQE

            .ServerName = SiteGlobal.ReportServer
            .DatabaseName = SiteGlobal.ReportDBR
            .UserID = SiteGlobal.DBUserR
            .Password = SiteGlobal.DBPassWd

        End With



        Dim reportpath As String = SiteGlobal.ReportPath
        Dim reportname As String = "Journal.rpt"
        reportpath = reportpath & reportname

        Dim crdoc As ReportDocument = Nothing 'Instance of rpt file

        Try
            crdoc = New CrystalDecisions.CrystalReports.Engine.ReportDocument
            With crdoc
                .Load(reportpath)
                '.Refresh()

            End With

        Catch ex As Exception
            Response.Write("<br>Report File: " & reportpath)
            Response.Write("<br>Error has occured. <br />Reason:" & ex.Message.ToString)
            crdoc = Nothing
            Exit Sub
        End Try



        '========================================================
        '
        '========================================================
        Dim intC As Integer = 0
        Dim intC2 As Integer = 0

        Dim cr_ds_conn As CrystalDecisions.Shared.DataSourceConnections = crdoc.DataSourceConnections
        Dim cr_iconinfo As CrystalDecisions.Shared.IConnectionInfo
        For intC = 0 To cr_ds_conn.Count - 1
            cr_iconinfo = cr_ds_conn.Item(intC)
            With cr_iconinfo

                'do this for each distinct database connection, rather than for table

                ' for SQL Server
                .SetConnection(CStr(SiteGlobal.ReportServer), CStr(SiteGlobal.ReportDBR), CStr(SiteGlobal.DBUserR), CStr(SiteGlobal.DBPassWd))

            End With
        Next

        'crdoc.SetDataSource(gnGet_DataSet("abswt_bs_pl", "IFRS_BS"))

        Call SetDBTableLogon(oConInfo, Me.CrystalReportViewer1)

        Call SetDBLogon_Info(oConInfo, crdoc)

        Me.CrystalReportViewer1.ReportSource = crdoc


        Dim intDB As Integer = 0
        Dim intRPT As Integer = 0
        intC = 0

        Dim arrDB(15) As String
        arrDB(0) = txtRecptNo.Text
        arrDB(1) = String.Empty
        arrDB(2) = String.Empty
        arrDB(3) = String.Empty

        Dim ParamFlds As CrystalDecisions.Shared.ParameterFields
        'ParamFlds = crdoc.ParameterFields
        ParamFlds = Me.CrystalReportViewer1.ParameterFieldInfo

        For intC = 0 To ParamFlds.Count - 1


            Select Case ParamFlds.Item(intC).ParameterType.ToString
                Case "ReportParameter"      '0
                    intRPT = intRPT + 1
                    Select Case ParamFlds.Item(intC).Name
                        Case "crCompName"
                            'Call MyReport_Param(ParamFlds.Item(intC).Name, arrRPT(intRPT - 1), ParamFlds)
                        Case "crCompAddr1"
                        Case "crCompAddr2"
                        Case "crRegNum"
                        Case "crReportTitle"
                            'Me.lblMessage.Text = arrRPT(intRPT - 1)
                            'Call MyReport_Param(ParamFlds.Item(intC).Name, arrRPT(intRPT - 1), ParamFlds)
                        Case "crReportTitle2"
                            'Call MyReport_Param(ParamFlds.Item(intC).Name, arrRPT(intRPT - 1), ParamFlds)
                        Case Else
                    End Select

                Case "StoreProcedureParameter"      '1
                    intDB = intDB + 1
                    'Response.Write("<br>Database Parameter: " & intDB.ToString & " - Name: " & ParamFlds.Item(intC).Name & " - New Value: " & arrDB(intDB - 1))
                    Call MyReport_Param(ParamFlds.Item(intC).Name, arrDB(intDB - 1), ParamFlds)
                Case "QueryParameter"       '2
                Case "ConnectionParameter"  '3
                Case Else

            End Select


        Next


        'Setting Report Parameter field info with parameter collection object
        Me.CrystalReportViewer1.ParameterFieldInfo = ParamFlds

        ' export the document to the temporary file.
        'crdoc.Export()


        With Me.CrystalReportViewer1
            .EnableDatabaseLogonPrompt = False
            .EnableParameterPrompt = False
            .ReuseParameterValuesOnRefresh = True

            .DisplayGroupTree = True
            .DisplayPage = True
            '.HasRefreshButton = True
            .HasPrintButton = True

            .EnableViewState = True

            .HasCrystalLogo = False
            '.Zoom(100)

            .DataBind()

        End With


        ParamFlds = Nothing

        'crdoc.Close()
        'crdoc = Nothing


    End Sub

    Private Sub SetDBTableLogon(ByVal objConnInfo As CrystalDecisions.Shared.ConnectionInfo, ByVal objCRV1 As CrystalDecisions.Web.CrystalReportViewer)
        Dim myTableLogOnInfos As CrystalDecisions.Shared.TableLogOnInfos = Nothing

        myTableLogOnInfos = New CrystalDecisions.Shared.TableLogOnInfos
        myTableLogOnInfos = objCRV1.LogOnInfo
        For Each myTableLogOnInfo As TableLogOnInfo In myTableLogOnInfos
            'Dim myConnectionInfo As ConnectionInfo = New ConnectionInfo()
            myTableLogOnInfo.ConnectionInfo = objConnInfo
        Next

    End Sub

    Private Sub SetDBLogon_Info(ByVal myConnectionInfo As CrystalDecisions.Shared.ConnectionInfo, ByVal myReportDocument As CrystalDecisions.CrystalReports.Engine.ReportDocument)
        On Error GoTo Err_Rtn


        Dim myTables As CrystalDecisions.CrystalReports.Engine.Tables = myReportDocument.Database.Tables
        For Each myTable As CrystalDecisions.CrystalReports.Engine.Table In myTables
            Dim myTableLogonInfo As CrystalDecisions.Shared.TableLogOnInfo = myTable.LogOnInfo
            myTableLogonInfo.ConnectionInfo = myConnectionInfo
            'myTable.Location = myTable.Name
            myTable.Location = "[dbo].[CiSp_JournalDetails]"
            myTable.ApplyLogOnInfo(myTableLogonInfo)
        Next
        Exit Sub

Err_Rtn:
        Response.Write("<br />*** Database logon error. <br />Error: " & Err.Number & " - " & Err.Description & "<br>")
        Err.Clear()
    End Sub

    Private Sub MyReport_Param(ByVal Param_Name As String, ByVal Param_Value As String, ByVal rptPrm_Fields As CrystalDecisions.Shared.ParameterFields)

        Try
            Dim rptPrm_Fld As CrystalDecisions.Shared.ParameterField
            rptPrm_Fld = New CrystalDecisions.Shared.ParameterField
            rptPrm_Fld.ParameterFieldName = Param_Name

            Dim rptDiscrete_Val As CrystalDecisions.Shared.ParameterDiscreteValue
            rptDiscrete_Val = New CrystalDecisions.Shared.ParameterDiscreteValue
            rptDiscrete_Val.Value = Param_Value

            rptPrm_Fld.CurrentValues.Add(rptDiscrete_Val)
            rptPrm_Fields.Add(rptPrm_Fld)

            rptDiscrete_Val = Nothing
            rptPrm_Fld = Nothing

            'Me.lblMessage.Text = Me.lblMessage.Text & "<BR /> Setting report parameters successful - " & Param_Name & " - " & Param_Value & "<BR />"
            Exit Sub

        Catch ex As Exception
            'Me.lblMsg.Text = Me.lblMsg.Text & "<BR /> Error while setting report parameter: " & Param_Name & " - " & Param_Value & "<br />" & "Reason: " & ex.Message.ToString & "<br />"
            Exit Sub
        End Try

    End Sub


End Class