<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IndLifeCodeEnq.aspx.vb" Inherits="CustodianLife.Webv.IndLifeCodeEnq" %>

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
                    <h2>The Individual Life Codes</h2>
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
  
 
   <asp:HyperLinkField DataTextField="CodeTabId" DataNavigateUrlFields="icId,CodeTabId,CodeType"
         DataNavigateUrlFormatString="~/IndLifeCodes.aspx?idd={0},{1},{2}" HeaderText="TabId"  
         HeaderStyle-CssClass="first" ItemStyle-CssClass="first"  />
         
                <asp:BoundField DataField="CodeType" HeaderText="Code Type" />
                <asp:BoundField DataField="CodeItem" HeaderText="Code Item" />
                <asp:BoundField DataField="CodeLongDesc" HeaderText="Long Descr" />
                <asp:BoundField DataField="CodeShortDesc" HeaderText="Short Descr" />
            </Columns>
            
        <HeaderStyle HorizontalAlign="Justify" VerticalAlign="Top" />
                <AlternatingRowStyle BackColor="#CDE4F1" />
        </asp:GridView>
                       </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
         <asp:ObjectDataSource ID="ods1" runat="server" SelectMethod="IndividualLifeCodes" TypeName="CustodianLife.Data.IndLifeCodesRepository">
    </asp:ObjectDataSource>  
    </div>
    
    </form>
</body>
</html>
