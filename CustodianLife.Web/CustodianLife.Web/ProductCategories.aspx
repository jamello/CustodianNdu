<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductCategories.aspx.cs" Inherits="CustodianLife.Web.ProductCategories" %>

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
    <form id="form1" runat="server">
    <div>
     <asp:Label runat=server ID=lblError Font-Bold=true ForeColor=Red Visible=false> </asp:Label>

     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Product Categories</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Category Module</td>
					<td><asp:Dropdownlist ID="cmbModule" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">Category Module</asp:ListItem>
	            <asp:ListItem value="I">Individual Life</asp:ListItem>
	            <asp:ListItem value="G">Group Life</asp:ListItem>
	            <asp:ListItem value="A">Annuity</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Category Code</td>
					<td><asp:Dropdownlist ID="cmbCatCode" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">Category Module</asp:ListItem>
	            <asp:ListItem value="I">Investment</asp:ListItem>
	            <asp:ListItem value="P">Protection</asp:ListItem>
	            <asp:ListItem value="E">Endowment</asp:ListItem>
	            <asp:ListItem value="F">Funeral</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Category Description</td>
					<td><asp:TextBox ID="txtCodeLongDesc" runat="server" Width="270px" TextMode=MultiLine></asp:TextBox></td>
				</tr>
				<tr>
					<td>Category Short Desc</td>
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
