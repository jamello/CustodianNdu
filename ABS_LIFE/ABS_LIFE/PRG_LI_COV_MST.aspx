<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_COV_MST.aspx.vb" Inherits="ABS_LIFE.PRG_LI_COV_MST" %>

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
    <form id="PRG_LI_COV_MST" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Product Cover Details</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Module ID</td>
					<td><asp:Dropdownlist ID="cmbModuleID" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="000">--SELECT--</asp:ListItem>
	            <asp:ListItem value="I">Individual Life</asp:ListItem>
	            <asp:ListItem value="G">Group Life</asp:ListItem>
	            <asp:ListItem value="A">Annuity</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>

				<tr>
					<td>Product Code</td>
					<td><asp:Dropdownlist ID="cmbProductCode" runat="server" Width="270px">
				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Cover Code</td>
					<td><asp:TextBox ID="txtCoverCode" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Cover Desc</td>
					<td><asp:TextBox ID="txtCodeDesc" runat="server" Width="270px" TextMode=MultiLine></asp:TextBox></td>
				</tr>
				<tr>
					<td>Cover Type</td>
					<td><asp:Dropdownlist ID="cmbCoverType" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">--SELECT--</asp:ListItem>
	            <asp:ListItem value="B">Basic</asp:ListItem>
	            <asp:ListItem value="A">Anciliary</asp:ListItem>
	            <asp:ListItem value="S">Supplementary</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Cover On Basic Rate?</td>
					<td><asp:Dropdownlist ID="cmbBasicRate" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">--SELECT--</asp:ListItem>
	            <asp:ListItem value="Y">Basic</asp:ListItem>
	            <asp:ListItem value="N">Anciliary</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Cover Rate On</td>
					<td><asp:Dropdownlist ID="cmbCoverRateOn" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">--SELECT--</asp:ListItem>
	            <asp:ListItem value="B">Basic Premium</asp:ListItem>
	            <asp:ListItem value="S">Sum Assured</asp:ListItem>
				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>% Of Sum Assured</td>
					<td><asp:TextBox ID="txtSAPcent" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Minimum SA for Cover</td>
					<td><asp:TextBox ID="txtMinSACover" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Maximum SA for Cover</td>
					<td><asp:TextBox ID="txtMaxSACover" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Fund Type</td>
					<td><asp:Dropdownlist ID="cmbFundType" runat="server" Width="270px">
				<asp:ListItem Selected="True" Value="0">--SELECT--</asp:ListItem>
	            <asp:ListItem value="I">Investment</asp:ListItem>
	            <asp:ListItem value="R">Risk</asp:ListItem>
	            <asp:ListItem value="B">Both</asp:ListItem>
				</asp:Dropdownlist></td>
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
                    <h2>Product Cover Details</h2>
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
  
 
   <asp:HyperLinkField DataTextField="ProductCoverModule" DataNavigateUrlFields="pcId,ProductCoverModule,ProductCode,ProductCoverCode"
         DataNavigateUrlFormatString="~/PRG_LI_COV_MST.aspx?idd={0},{1},{2},{3}" HeaderText="Module"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
   <asp:HyperLinkField DataTextField="ProductCoverModule" DataNavigateUrlFields="pcId,ProductCoverModule,ProductCode,ProductCoverCode"
         DataNavigateUrlFormatString="~/PRG_LI_COV_MST.aspx?idd={0},{1},{2},{3}" HeaderText="Product"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
   <asp:HyperLinkField DataTextField="ProductCoverModule" DataNavigateUrlFields="pcId,ProductCoverModule,ProductCode,ProductCoverCode"
         DataNavigateUrlFormatString="~/PRG_LI_COV_MST.aspx?idd={0},{1},{2},{3}" HeaderText="Cover"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="ProductCoverDesc" HeaderText="Cover Descr" />
                <asp:BoundField DataField="ProductCoverSAPercent" HeaderText="SA %" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
        <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="ProductCovers" TypeName="CustodianLife.Data.ProductCoverDetailsRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
