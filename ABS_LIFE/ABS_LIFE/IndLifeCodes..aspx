<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IndLifeCodes..aspx.vb" Inherits="ABS_LIFE.IndLifeCodes_" %>

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
	            <asp:ListItem value="L02">Underwriting Codes</asp:ListItem>
	            <asp:ListItem value="L01">Other Codes</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Code Type</td>
					<td><asp:Dropdownlist ID="cmbCodeType" runat="server" Width="270px">
					<asp:ListItem Selected="True" Value="000">Code Types</asp:ListItem>
    	            <asp:ListItem value="001">Disabililty Types</asp:ListItem>
	                <asp:ListItem value="002">Health Status</asp:ListItem>
	                <asp:ListItem value="003">Medical Exam </asp:ListItem>
	                <asp:ListItem value="004">Loading</asp:ListItem>
	                <asp:ListItem value="005">Discount</asp:ListItem>
	                <asp:ListItem value="006">Mortality</asp:ListItem>
	                <asp:ListItem value="007">Medical Illness</asp:ListItem>
	                <asp:ListItem value="008">Medical Clinic</asp:ListItem>
	                <asp:ListItem value="009">Policy Condition</asp:ListItem>
	                <asp:ListItem value="010">Loss Type</asp:ListItem>
	                <asp:ListItem value="011">Treaty Type</asp:ListItem>
	                <asp:ListItem value="012">Loan Codes</asp:ListItem>
	                </asp:Dropdownlist></td>
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
