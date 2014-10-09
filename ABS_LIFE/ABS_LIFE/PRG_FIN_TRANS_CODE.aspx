<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_TRANS_CODE.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_TRANS_CODE" %>

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
    <div class="">
 <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
    <form id="PRG_FIN_TRANS_CODE" runat="server">
<div>
     <div class="gridp">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Transaction Codes</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table>
				<tr>
					<td>Company Code</td>
                    <td><asp:Dropdownlist ID="cmbCoyCode" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				
				<tr>
					<td>Transaction Code</td>
					<td><asp:TextBox ID="txtTransCode" runat="server" Width="270px" ></asp:TextBox></td>
				</tr>
				<tr>
					<td>Trans Code Description</td>
					<td><asp:TextBox ID="txtTransCodeDesc" runat="server" Width="270px"></asp:TextBox></td>
				</tr>
				<tr>
					<td>Branch</td>
                    <td><asp:Dropdownlist ID="cmbBranch" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>
				<tr>
					<td>Department</td>
                    <td><asp:Dropdownlist ID="cmbDepts" runat="server" Width="150px">
        				</asp:Dropdownlist></td>
				</tr>

				<tr>
					<td></td><td>
                        <asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" style="height: 26px" />
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
      <div class="gridp">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Transaction Codes Listing </h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
<!-- grid end here-->       
<asp:GridView ID="grdData"  runat="server"  AutoGenerateColumns="False"
        DataSourceID="ods1" AllowSorting="True" CssClass="datatable" AllowPaging="True" PageSize=10
        CellPadding="0" BorderWidth="0px" AlternatingRowStyle-BackColor="#CDE4F1" GridLines="None" HeaderStyle-BackColor="#099cc" ShowFooter="True" >
        <PagerStyle CssClass="pager-row" />
           <RowStyle CssClass="row" />
              <PagerSettings Mode="NumericFirstLast" PageButtonCount="7" FirstPageText="«" LastPageText="»" />      
            <Columns>
                         <asp:HyperLinkField DataTextField="ttId" DataNavigateUrlFields="ttId,CompanyCode,TransactionCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_TRANS_CODE.aspx?idd={0},{1},{2}" HeaderText="Id"  
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
                                 
                         <asp:HyperLinkField DataTextField="CompanyCode" DataNavigateUrlFields="ttId,CompanyCode,TransactionCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_TRANS_CODE.aspx?idd={0},{1},{2}" HeaderText="Coy Code"   
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />

                         <asp:HyperLinkField DataTextField="TransactionCode" DataNavigateUrlFields="ttId,CompanyCode,TransactionCode"
                                 DataNavigateUrlFormatString="~/PRG_FIN_TRANS_CODE.aspx?idd={0},{1},{2}" HeaderText="Trans Code"   
                                 HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />

                <asp:BoundField DataField="Description" HeaderText="Description" />
               
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="TransactionTypesDetails" TypeName="CustodianLife.Data.TransactionTypesRepository">
    </asp:ObjectDataSource>  
    </div>
		</form>
</div>
</body>
</html>
