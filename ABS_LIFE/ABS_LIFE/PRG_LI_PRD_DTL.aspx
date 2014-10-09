<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_LI_PRD_DTL.aspx.vb" Inherits="ABS_LIFE.PRG_LI_PRD_DTL" %>

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
    <form id="PRG_LI_PRD_DTL" runat="server">
<div>
     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Product Details</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Product System Module</td>
					<td><asp:Dropdownlist ID="cmbPrdSysModule" runat="server" Width="270px">
				        <asp:ListItem Selected="True" Value="0">System Module</asp:ListItem>
	                    <asp:ListItem value="I">Individual</asp:ListItem>
	                    <asp:ListItem value="G">Group Life</asp:ListItem>
	                    <asp:ListItem value="A">Annuity</asp:ListItem>

        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Product Category</td>
					<td><asp:Dropdownlist ID="cmbProductCategory" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Product Details Code</td>
					<td><asp:TextBox ID="txtProductDetailsCode" runat="server" Width="270px" MaxLength="3"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Details Description</td>
					<td><asp:TextBox ID="txtDetailsDesc" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Plan Code</td>
                    <td><asp:Dropdownlist ID="cmbPlanCd" runat="server" Width="270px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Age Calculation</td>
					<td><asp:DropDownList ID="cmbAgeCalc" runat="server">
				        <asp:ListItem Selected="True" Value="0">Age Calculation</asp:ListItem>
	                    <asp:ListItem value="P">Previous Birthday</asp:ListItem>
	                    <asp:ListItem value="N">Next Birthday</asp:ListItem>
	                    <asp:ListItem value="R">Nearest Birthday</asp:ListItem>
				</asp:Dropdownlist></td>				</tr>
				<tr>
					<td>Sum Assured Multiple Pay</td>
					<td><asp:DropDownList ID="cmbSumAssuredMultiplePay" runat="server">
				        <asp:ListItem Selected="True" Value="0">SA Multiple Pay?</asp:ListItem>
	                    <asp:ListItem value="Y">Yes</asp:ListItem>
	                    <asp:ListItem value="N">No</asp:ListItem>
                        </asp:DropDownList></td>
				</tr>
				<tr>
					<td>First Sum Assured Instal % Amt</td>
					<td><asp:TextBox ID="txtFirstSAInstallPcent" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>First Sum Assured Instal Pay Period </td>
					<td><asp:TextBox ID="txtFirstSAInstalPayPeriod" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				
				<tr>
					<td>Second Sum Assured Instal % Amt </td>
					<td><asp:TextBox ID="txtSecondSAInstalPcent" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Second Sum Assured Instal Pay Period </td>
					<td><asp:TextBox ID="txtSecondSAInstalPayPeriod" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Third Sum Assured Instal % Amt </td>
					<td><asp:TextBox ID="txtThirdSAInstalPcent" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Third Sum Assured Instal Pay Period </td>
					<td><asp:TextBox ID="txtThirdSAInstalPayPeriod" runat="server" Width="270px"></asp:TextBox></td>
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
                    <h2>Product Details Listing </h2>
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
                         <asp:HyperLinkField DataTextField="pdId" DataNavigateUrlFields="pdId,ProductDetailsModule"
                                 DataNavigateUrlFormatString="~/PRG_LI_PRD_DTL.aspx?idd={0},{1}" HeaderText="Id"  
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
                <asp:BoundField DataField="ProductDetailsModule" HeaderText="Module" />
                <asp:BoundField DataField="ProductCategory" HeaderText="Category" />
                <asp:BoundField DataField="ProductCode" HeaderText="Prod Code" />
                <asp:BoundField DataField="ProductDesc" HeaderText="Product Desc" />
                <asp:BoundField DataField="ProductPlanCode" HeaderText="Plan Code"/>
                <asp:BoundField DataField="ProductAgeCalc" HeaderText="Age Calc" />
               
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="ProductDetailInfo" TypeName="CustodianLife.Data.ProductDetailsRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</body>
</html>
