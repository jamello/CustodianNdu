<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductCategoriesEnq.aspx.cs" Inherits="CustodianLife.Web.ProductCategoriesEnq" %>

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
      <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>The Product Categories</h2>
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
  
 
   <asp:HyperLinkField DataTextField="pcId" DataNavigateUrlFields="PcId,ProductCatModule"
         DataNavigateUrlFormatString="~/ProductCategories.aspx?idd={0},{1}" HeaderText="PcId"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="ProductCatModule" HeaderText="Cat Module" />
                <asp:BoundField DataField="ProductCatCode" HeaderText="Cat Code" />
                <asp:BoundField DataField="ProductCatDesc" HeaderText="Long Descr" />
                <asp:BoundField DataField="ProductCatShortDesc" HeaderText="Short Descr" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="ProductCategories" TypeName="CustodianLife.Data.ProductCatRepository">
    </asp:ObjectDataSource>  
    </div>
    
    </form>
</body>
</html>
