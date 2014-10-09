<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ReceiptPrint.aspx.vb" Inherits="ABS_LIFE.ReceiptPrint" %>

<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link href="/CrystalReportViewers10/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/CrystalReportWebFormViewer4/css/default.css" type="text/css" rel="Stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

    <table>
    <tr><td></td><td></td></tr>
    
    </table>



    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
            AutoDataBind="true" />
    </div>
    <div>
    <asp:Button ID="butView" runat="server" Text="View Report" />
    <asp:Button ID="butPrintList" runat="server" Text="View List"/>
    </div>
    </form>
</body>
</html>
