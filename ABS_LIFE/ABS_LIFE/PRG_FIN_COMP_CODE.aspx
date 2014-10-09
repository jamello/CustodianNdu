<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_COMP_CODE.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_COMP_CODE" %>

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
 <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    <form id="PRG_FIN_COMP_CODE" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Company Code</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Company Code</td>
					<td><asp:TextBox ID="txtCoyCode" runat="server" Width="270px" MaxLength="3"></asp:TextBox></td>
				</tr>
				
				<tr>
					<td>Company Long Name</td>
					<td><asp:TextBox ID="txtLongName" runat="server" Width="270px" MaxLength="100"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Company Short Name</td>
					<td><asp:TextBox ID="txtShortName" runat="server" Width="270px" MaxLength="20"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Address Line 1</td>
					<td><asp:TextBox ID="txtAddress1" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Address Line 2</td>
					<td><asp:TextBox ID="txtAddress2" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Phone Number 1</td>
					<td><asp:TextBox ID="txtPhone1" runat="server" Width="270px" MaxLength="25"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Phone Number 2</td>
					<td><asp:TextBox ID="txtPhone2" runat="server" Width="270px" MaxLength="25"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Registration No</td>
					<td><asp:TextBox ID="txtRegNo" runat="server" Width="270px" MaxLength="20"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Email Address 1</td>
					<td><asp:TextBox ID="txtEmail1" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Email Address 2</td>
					<td><asp:TextBox ID="txtEmail2" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Status</td>
                    <td><asp:Dropdownlist ID="cmbStatus" runat="server" Width="150px">
				        <asp:ListItem Selected="True" Value="0">Status</asp:ListItem>
	                    <asp:ListItem value="G">Group</asp:ListItem>
	                    <asp:ListItem value="S">Subsidiary</asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Date Established</td>
					<td><asp:TextBox ID="txtDateEstablished" runat="server" Width="150px"></asp:TextBox>
					<script language="JavaScript" type="text/javascript">
					    new tcal({ 'formname': 'PRG_FIN_COMP_CODE', 'controlname': 'txtDateEstablished' });</script> </td>
    			</tr>
				<tr>
					<td></td><td>
                        <asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" />
                        <asp:Button ID="butDelete" runat="server" Text="Delete"  /></td>
				</tr>
			</table>
			
			                      </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
</div>

<div>
      <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Company Codes Listing </h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
<!-- grid end here-->       
<asp:GridView ID="grdData"  runat="server"  AutoGenerateColumns="False"
        DataSourceID="ods1" AllowSorting="True" CssClass="datatable"
        CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >
        <PagerStyle CssClass="pager-row" />
           <RowStyle CssClass="row" />
              <PagerSettings Mode="NumericFirstLast" PageButtonCount="7" FirstPageText="«" LastPageText="»" />      
            <Columns>
                         <asp:HyperLinkField DataTextField="ccId" DataNavigateUrlFields="ccId,CompanyCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_COMP_CODE.aspx?idd={0},{1}" HeaderText="Id"  
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
                                 
                         <asp:HyperLinkField DataTextField="CompanyCode" DataNavigateUrlFields="ccId,CompanyCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_COMP_CODE.aspx?idd={0},{1}" HeaderText="Coy Code"   
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />

                <asp:BoundField DataField="CompanyLongName" HeaderText="Coy Long Name " />
                <asp:BoundField DataField="PhoneNo1" HeaderText="Telephone" />
                <asp:BoundField DataField="EmailAddress1" HeaderText="Email" />
                <asp:BoundField DataField="EstablishDate"  HeaderText="Incorp. Date" />
               
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="CompanyCodesDetails" TypeName="CustodianLife.Data.CompanyCodesRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
