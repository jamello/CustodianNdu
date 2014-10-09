<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IndLifeCodes.aspx.vb" Inherits="CustodianLife.Webv._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   
    <title></title>
    
    
</head>
<body>
 <asp:Label runat=server ID=lblError Font-Bold=true ForeColor=Red Visible=false> </asp:Label>
    <form id="frmIndLifeCodes" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>The Individual Life Codes</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Code ID</td>
					<td><asp:Dropdownlist ID="cmbCodeID" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="000">Code Types</asp:ListItem>
	            <asp:ListItem value="L01">Underwriting Codes</asp:ListItem>
	            <asp:ListItem value="L02">Other Codes</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Code Type</td>
					<td><asp:TextBox ID="txtCodeType" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Code Item</td>
					<td><asp:TextBox ID="txtCodeItem" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Long Desc</td>
					<td><asp:TextBox ID="txtCodeLongDesc" runat="server" Width="270px" TextMode=MultiLine></asp:TextBox></td>
				</tr>
				<tr>
					<td>Short Desc</td>
					<td>
                        <asp:TextBox ID="txtCodeShortDesc" runat="server" Width="270px"></asp:TextBox>
                    </td>
				</tr>
				<tr>
					<td></td><td>
                        <asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" /></td>
				</tr>
			</table>
			
			                      </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
</div>
		</form>
</body>
</html>
