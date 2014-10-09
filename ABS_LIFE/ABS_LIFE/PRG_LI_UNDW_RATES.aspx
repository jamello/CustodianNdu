<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_UNDW_RATES.aspx.vb" Inherits="ABS_LIFE.PRG_LI_UNDW_RATES" %>

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
    <form id="PRG_LI_UNDW_RATES" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Premium Rates Master</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Module</td>
					<td><asp:Dropdownlist ID="cmbModule" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">Source Module</asp:ListItem>
	            <asp:ListItem value="I">Individual Life</asp:ListItem>
	            <asp:ListItem value="G">Group Life</asp:ListItem>
	            <asp:ListItem value="A">Annuity</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Product Code</td>
					<td><asp:Dropdownlist ID="cmbProductCodeID" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Rate Type</td>
					<td><asp:Dropdownlist ID="cmbRateType" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				
                <tr>
					<td>Start Policy Term</td>
					<td><asp:TextBox ID="txtStartPolicyTerm" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>End Policy Term</td>
					<td><asp:TextBox ID="txtEndPolicyTerm" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				 <tr>
					<td>Start Age</td>
					<td><asp:TextBox ID="txtStartAge" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>End Age</td>
					<td><asp:TextBox ID="txtEndAge" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Premium Rate</td>
					<td><asp:TextBox ID="txtPremiumRate" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Premium Rates </h2>
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
            
              <asp:HyperLinkField DataTextField="pmId" DataNavigateUrlFields="pmId,ModuleSource,ProductCode,RateTypeCode"
         DataNavigateUrlFormatString="~/PRG_LI_UNDW_RATES.aspx?idd={0},{1},{2},{3}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="ModuleSource" HeaderText="Module"  />
                <asp:BoundField DataField="ProductCode" HeaderText="Product Code"  />
                <asp:BoundField DataField="RateTypeCode" HeaderText="Rate Type"  />
                <asp:BoundField DataField="StartPolicyTerm" HeaderText="Start Term" />
                <asp:BoundField DataField="EndPolicyTerm" HeaderText="End Term" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="PremiumRatesDetails" TypeName="CustodianLife.Data.PremiumRateMasterRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
