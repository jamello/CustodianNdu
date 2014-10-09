<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_TRTY_PRPTN.aspx.vb" Inherits="ABS_LIFE.PRG_LI_TRTY_PRPTN" %>

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
    <form id="PRG_LI_TRTY_PRPTN" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Treaty Proportion Set</h2>
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
					<td>Treaty Year</td>
					<td><asp:TextBox ID="txtTreatyYear" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Treaty Company</td>
					<td><asp:TextBox ID="txtTreatyCoy" runat="server" Width="270px"></asp:TextBox></td>
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
					<td>Start Sum Assured Value </td>
					<td><asp:TextBox ID="txtStartSAValue" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Treaty Proportion </h2>
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
            
              <asp:HyperLinkField DataTextField="tpId" DataNavigateUrlFields="tpId,SystemModule"
         DataNavigateUrlFormatString="~/PRG_LI_TRTY_PRPTN.aspx?idd={0},{1}" HeaderText="Id"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="SystemModule" HeaderText="Module"  />
                <asp:BoundField DataField="TreatyYear" HeaderText="Tty Yr"  />
                <asp:BoundField DataField="TreatyCompany" HeaderText="Treaty Coy" />
                <asp:BoundField DataField="StartSumAssuredValue" HeaderText="Start SA" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="TreatyProportionDetails" TypeName="CustodianLife.Data.TreatyProportionRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
