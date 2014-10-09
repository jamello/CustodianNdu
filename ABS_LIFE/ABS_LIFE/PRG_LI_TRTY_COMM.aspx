<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_TRTY_COMM.aspx.vb" Inherits="ABS_LIFE.PRG_LI_TRTY_COMM" %>

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
    <form id="PRG_LI_TRTY_COMM" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>ReInsurance Treaty Commission Setup</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>System Module</td>
					<td><asp:Dropdownlist ID="cmbModuleID" runat="server" Width="270px">
        				<asp:ListItem Value="0" Text=" System Module"></asp:ListItem>
        				<asp:ListItem Value="I" Text="Individual"></asp:ListItem>
        				<asp:ListItem Value="G" Text="Group"></asp:ListItem>
        				<asp:ListItem Value="A" Text="Annuity"></asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Treaty Commission Year</td>
					<td><asp:TextBox ID="txtTreatyCommYear" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Treaty Type</td>
					<td><asp:Dropdownlist ID="cmbTreatyType" runat="server" Width="270px">
        				<asp:ListItem Value="0" Text=" Treaty Type"></asp:ListItem>
        				<asp:ListItem Value="1" Text="Ist Surplus"></asp:ListItem>
        				<asp:ListItem Value="2" Text="2nd Surplus"></asp:ListItem>
        				<asp:ListItem Value="3" Text="Quota"></asp:ListItem>
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Product Code</td>
					<td><asp:Dropdownlist ID="cmbProductCode" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Sum Assured Start Period</td>
					<td><asp:TextBox ID="txtStartSAPeriod" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Sum Assured End Period</td>
					<td><asp:TextBox ID="txtEndSAPeriod" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Sum Assured Start Amount</td>
					<td><asp:TextBox ID="txtStartSAAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Sum Assured End Amount</td>
					<td><asp:TextBox ID="txtEndSAAmt" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Commission Rate</td>
					<td><asp:TextBox ID="txtCommRate" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td></td><td>
                        <asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" 
                            style="height: 29px" />
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
                    <h2>ReInsurance Treaty Commission Listing </h2>
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
            
              <asp:HyperLinkField DataTextField="tcId" DataNavigateUrlFields="tcId,SystemModule,ProductCode"
         DataNavigateUrlFormatString="~/PRG_LI_TRTY_COMM.aspx?idd={0},{1},{2}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="SystemModule" HeaderText="Module"  />
                <asp:BoundField DataField="TreatyCommYear" HeaderText="Tty Yr"  />
                <asp:BoundField DataField="ProductCode" HeaderText="Prd Cd" />
                <asp:BoundField DataField="StartSumAssuredAmt" HeaderText="Start SA" />
                <asp:BoundField DataField="EndSumAssuredAmt" HeaderText="End SA" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="ReInsuranceTreatyCommissionDetails" TypeName="CustodianLife.Data.ReInsuranceTreatyCommissionRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
