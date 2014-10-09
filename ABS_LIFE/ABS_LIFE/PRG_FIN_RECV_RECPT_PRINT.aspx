<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_RECV_RECPT_PRINT.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_RECV_RECPT_PRINT" %>

<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   

<head runat="server">
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     <div  class=newpage>
        <div class="grid">
                 <div class="rounded">
                    <div class="top-outer"><div class="top-inner"><div class="top">
                        <h2><asp:Label ID="lblDesc2" runat="server" Text="Print Services"></asp:Label>  </h2>
                    </div></div></div>
                    <div class="mid-outer"><div class="mid-inner">
                    <div class="mid">     
                    	
    <!-- grid end here-->
        <div id="PrintDialog">
        <table>
            <tr><td><asp:Label ID="lblPrintLabel" runat="server" Text="Doc Number"> </asp:Label> </td>
			    <td ><asp:TextBox ID="txtRecptNo" runat="server" Width="100px"></asp:TextBox></td></tr>
            <tr><td></td><td><asp:Button ID="butPrintReceipt" runat="server" Text="Go" Visible="True" /></td></tr>
        </table>
        </div>
    <div>    
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
    </div>
        
           
    
                           </div></div></div>
                <div class="bottom-outer"><div class="bottom-inner">
                <div class="bottom"></div></div></div>                
            </div>      
        </div>
    </div>
    
    
    
    


    </form>
</body>
</html>
