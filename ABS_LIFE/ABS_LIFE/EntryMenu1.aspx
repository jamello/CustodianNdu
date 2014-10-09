<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EntryMenu1.aspx.vb" Inherits="ABS_LIFE.EntryMenu1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

    <script src="jquery-1.11.0.js" type="text/javascript"></script>

    <link href="AppServer.css" rel="stylesheet" type="text/css" />   
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="menu.css" rel="stylesheet"  type="text/css" />   
    <link href="grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   

<script type="text/javascript" src="ddaccordion.js">

/***********************************************
* Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
* Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
* This notice must stay intact for legal use
***********************************************/

</script>

<script type="text/javascript">

ddaccordion.init({
	headerclass: "headerbar", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "mouseover", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [0], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: true, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "selected"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "normal", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})

</script>
<script type="text/javascript">

    $(document).ready(function() {
        $(function() {

       // if ($.browser.msie && $.browser.version.substr(0, 1) < 7) {
          $('li').has('ul').mouseover(function() {
            $(this).children('ul').css('visibility', 'visible');
         }).mouseout(function() {
           $(this).children('ul').css('visibility', 'hidden');
         })
          }

         //}
         );

        // ajax call to load role permissions
        function LoadRolePermissions() {
            $.ajax({
                type: "POST",
                url: "EntryMenu1.aspx/GetRolePermissions",
                data: JSON.stringify({ _rolename: 'administrator' }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess_LoadRolePermissions,
                failure: OnFailure_LoadRolePermissions,
                error: OnError_LoadRolePermissions
            });
            // this avoids page refresh on button click
            return false;
        }
        // on sucess get the xml
        function OnSuccess_LoadRolePermissions(response) {
            //debugger;
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var permissions = xml.find("Table");
            retrieve_LoadRolePermissions(permissions)

        }
        // retrieve the values and
        function retrieve_LoadRolePermissions(permissions) {
            //debugger;
            $.each(permissions, function() {
                var permission = $(this);
                $('#CODESMASTERSSETUPU1').css('visibility', $(this).find("CODESMASTERSSETUPU1").text())
                $('#GENERALLEDGERU1').css('visibility', $(this).find("GENERALLEDGERU1").text())
                $('#RECEIVABLE').css('visibility', $(this).find("RECEIVABLEU1").text())
                $('#PAYABLES').css('visibility', $(this).find("PAYABLESU1").text())
            });
        }
        function OnFailure_LoadRolePermissions(response) {
            //debugger;
            //alert('Failure!!!' + '<br/>' + response.reponseText);
            alert('Data Retrieval Failed. Parameters sent is empty or invalid. Please Re-Confirm' + '<br/>');
        }

        function OnError_LoadRolePermissions(response) {
            //debugger;
            //var errorText = response.responseText;
            //alert('Error!!!' + '\n\n' + errorText);
            alert('Data Retrieval Failed. Parameters sent is empty or invalid. Please Re-Confirm' + '<br/>');
        }


        // loading screen functionality functions - this part is additional - start
        function OnAjaxStart() {
            //debugger;
            //alert('Starting...');
            $("#divLoading").css("display", "block");
        }
        function OnFailure(response) {
            //debugger;
            alert('Failure!!!' + '<br/>' + response.reponseText);
        }
        function OnError(response) {
            //debugger;
            var errorText = response.responseText;
            alert('Error!!!' + '\n\n' + errorText);
        }
        function OnAjaxError() {
            //debugger;
            alert('Error!: Invalid Ajax Call');
        }
        function OnAjaxSuccess() {
            //debugger;
            //alert('Sucess!!!');
            $("#divLoading").css("display", "none");
        }
        function OnAjaxStop() {
            //debugger;
            //alert('Stop!!!');
            $("#divLoading").css("display", "none");
        }
        function OnAjaxComplete() {
            //debugger;
            //alert('Completed!!!');
            $("#divLoading").css("display", "none");
        }


        //invoke the load permissions function on page load
        $(function() {
            //LoadRolePermissions();
        });




    });    //doc.ready end








</script>



</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper">
    <div class="rounded">
    <div class="top-outer">
           <div class="top-inner">
               <div class="top">
                </div>
            </div> 
           </div><!-- END top-outer -->
     <div class="mid-outer">
      <div class="mid-inner">
        <div class="mid">
        <div id="header">
                <a href="#">
                <img src="img/CAILogoN.jpg" class="logo"  alt="Custodian Life Insurance"
                    title="Custodian Life Insurance" />                                      </a>
                   <img src="img/acct_banner.jpg"  height="150px" alt="my image" width="800px"
                    title="my image" /> 

    <div id="nav1">
    <asp:Label runat="server" id="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
     <ul id="menu">
        <li id="Home"><a href="#">Home</a></li>
        <li id="CodesMastersSetup"><a href="#">Codes Masters Setup</a>
              <ul id="CODESMASTERSSETUPU1">
                    <li><a href="Prg_Fin_Comp_Code.Aspx" target="frame_a">Company Code Setup</a></li>
                    <li><a href="Prg_Fin_Comp_Code.Aspx" target="frame_a">Branch Code Setup</a></li>
                    <li><a href="Prg_Fin_Comp_Code.Aspx" target="frame_a">Department Code Setup</a></li>
                    <li><a href="#" target="frame_a">Branch Code Print</a></li>
                    <li><a href="#" target="frame_a">Department Code Print</a></li>
<!--                     
                    <li><a href="Prg_Li_Prd_Cat.Aspx" target="frame_a">Product Category Setup</a></li>
                    <li><a href="Prg_Li_Prd_Dtl.Aspx" target="frame_a">Product Details Setup</a></li>
                    <li><a href="Prg_Li_Codes.Aspx" target="frame_a">Product Codes Setup</a></li>
                    <li><a href="Prg_Li_Cov_Mst.Aspx" target="frame_a">Product Covers Master Setup</a></li>
                    <li><a href="Prg_Li_Plan_Mst.Aspx" target="frame_a">Product Plan Master Setup</a></li>
                    <li><a href="Pro_Li_Medical_Dtls.Aspx" target="frame_a"> Medical Examination Details Setup </a></li>
                    <li>
                        <a href="Prg_Li_Undw_Rate_Types.Aspx" target="frame_a">Rate Types Code Setup</a>

                    </li>
                    <li>
                        <a href="Prg_Li_Undw_Rates.Aspx" target="frame_a">Premium Rates Master Setup</a>

                    </li>
                    <li>
                        <a href="Prg_Li_Int_Rate.Aspx" target="frame_a">Interest Rate Setup</a>

                    </li>
                    <li>
                        <a href="Prg_Li_Bonus_Int_Rt.Aspx" target="frame_a">Bonus Interest Rate Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Li_Loan_Int_Rt.Aspx" target="frame_a">Loan Interest Rate Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Li_Agcy_Comm.Aspx" target="frame_a">Agency Standard Commission Rates Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Li_Agcy_Budget.Aspx" target="frame_a">Agency Production Budget Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Li_Brk_Comm.Aspx" target="frame_a">Brokers Commission Rate Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Li_Trty_Prptn.Aspx" target="frame_a">Treaty Proportion Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Li_Trty_Comm.Aspx" target="frame_a">Reinsurance Treaty Commission</a>
                    </li>
                    <li>
                        <a href="Prg_Fin_Actvty_Cd_Setup.Aspx" target="frame_a">Activity Code (Account) Setup</a>
                    </li>
                    <li>
                        <a href="Prg_Fin_Bank_Setup.Aspx" target="frame_a">Bank Account Code Setup</a>
                    </li>

                    <li>
                        <a href="Prg_Fin_Trans_Code.Aspx" target="frame_a">Transaction Code (Accounts) Setup</a>
                    </li>
-->              </ul>                
        </li>
  
        <li id="Generalledger" ><a href="#">General Ledger</a>
            <ul id="Generalledgeru1">
                    <li id="Glcodessetup"><a href="#" target="frame_a">Codes Setup >></a>
                        <ul id="Glcodessetupu1">
                            <li><a href="#" target="frame_a">Customer Category Code</a></li>
                            <li><a href="#" target="frame_a">Customer Details Code</a></li>
                            <li><a href="#" target="frame_a">Transaction Codes</a></li>
                            <li><a href="#" target="frame_a">Currency Codes</a></li>
                            <li><a href="#" target="frame_a">Exchange Rates</a></li>
                            <li><a <a href="ChartOfAccountsEntryBrowse.aspx" target="">Main/Sub Account Setup</a></li>
                            <li><a href="#" target="frame_a">Activity Codes</a></li>
                            <li><a href="#" target="frame_a">Undwrtng Xref To G/L</a></li>
                            <li><a href="#" target="frame_a">Budget Entry</a></li>
                            <li id="Glcodesprint"><a href="#" target="frame_a">G/L Codes Print >></a>
                                <ul id="Glcodesprintu1">
                                    <li><a href="#" target="frame_a">Customer Category</a></li>
                                    <li><a href="#" target="frame_a">Customer Details Code</a></li>
                                    <li><a href="#" target="frame_a">Transaction Codes</a></li>
                                    <li><a href="#" target="frame_a">Currency Codes</a></li>
                                    <li><a href="#" target="frame_a">Exchange Rates</a></li>
                                    <li><a href="ChartOfAccountsEntryBrowse.aspx" target="">Main/Sub Account</a></li>
                                    <li><a href="#" target="frame_a">Activity Codes</a></li>
                                    <li><a href="#" target="frame_a">Undwrtng Xref To G/L</a></li>
                                    <li><a href="#" target="frame_a">Budget Details</a></li>                                
                                </ul>
                            </li>
                        </ul>
                        
                    </li>
                    <li id="Gltrans"><a href="#" target="frame_a">Transactions >></a>
                        <ul id="Gltransu1" >
                            <li><a href="#">Trans Entry</a></li>
                            <li><a href="Receiptslist.aspx" target="">Individual Life Receipts</a></li>
                            <li><a href="Receiptotherslist.aspx?prgKey=receipt" target="">Accounts Receivable</a></li>
                            <li><a href="Receiptotherslist.aspx?prgKey=payment" target=""> Accounts Payable</a></li>
                            <li><a href="Receiptotherslist.aspx?prgKey=journal" target="">Journal</a></li>
                            <li><a href="PRG_FIN_CREDITORS_ENTRY.aspx" target="">Creditors Invoice</a></li>
                            <li>Trans Report</li>
                            <li><a href="Receiptslist.aspx" target="">Individual Life Receipts</a></li>
                            <li><a href="Receiptotherslist.aspx" target="frame_a">Accounts Receivable</a></li>
                            <li><a href="#" target="">Daily Receipt Details List</a></li>
                            <li><a href="#" target="">Posted Receipts List</a></li>
                            <li><a href="#" target="">Unposted Receipts List</a></li>
                            <li><a href="#" target="frame_a">Trans Det. By Batch </a></li>
                            <li><a href="#" target="frame_a">Trans Det. By Branch </a></li>
                            <li><a href="#" target="frame_a">Trans Det. By Acct No </a></li>
                            <li><a href="#" target="frame_a">Trans Det. By Trans Date </a></li>
                            <li><a href="#" target="frame_a">Trans Det. By Acct No </a></li>
                        </ul>
                    
                    </li>
                    
                    <li id="Gljournal"><a href="#" target="frame_a">Journal Processing >></a>
                        <ul id="Gljournalu1">
                            <li><a href="#" target="frame_a">Allocation Jv Processing</a></li>
                            <li><a href="#" target="frame_a">Allocation Jv Print</a></li>
                            <li><a href="#" target="frame_a">G/L Trans. Auto Reversal</a></li>
                        </ul>
                    </li>
                    
                    <li id="Glmasterupdate"><a href="#" target="frame_a">Master Files Update >></a>
                        <ul id="Glmasterupdateu1">
                            <li><a href="#" target="frame_a">Extract For Update</a></li>
                            <li><a href="#" target="frame_a">Extracted Trans Print</a></li>
                            <li><a href="#" target="frame_a">G/L Master Update</a></li>
                        </ul>
                    </li>
                    <li id="Glreports"><a href="#" target="frame_a">Reports >></a>
                        <ul id="Glreportsu1">
                            <li><a href="#" target="frame_a">Bank/Cash Book Det.</a></li>
                            <li><a href="#" target="frame_a">Bank/Cash Position</a></li>
                            <li><a href="#" target="frame_a">G/L Details List(Main)</a></li>
                            <li><a href="#" target="frame_a">G/L Details List(Sub)</a></li>
                            <li><a href="#" target="frame_a">Trial Balance(Main)</a></li>
                            <li><a href="#" target="frame_a">Trial Balance(Sub)</a></li>
                            <li><a href="#" target="frame_a">Trl Bal.(Main) By Brch/Dept</a></li>
                            <li><a href="#" target="frame_a">Budget Var. Report</a></li>
                            <li><a href="#" target="frame_a">Balance Sheet</a></li>
                            <li><a href="#" target="frame_a">Sch. To Balance Sheet</a></li>
                            <li><a href="#" target="frame_a">Sch. To Inc. & Exp.</a></li>
                            <li id="Finreportgroup"><a href="#" target="frame_a">Fin. Report Grouping >></a>
                                <ul id="Finreportgroupu1">                                
                                    <li><a href="#" target="frame_a">Inc. & Exp. Grouping Entry</a></li>
                                    <li><a href="#" target="frame_a">Inc. & Exp. Grouping Print</a></li>
                                    <li><a href="#" target="frame_a">Profit & Loss Grouping Entry</a></li>
                                    <li><a href="#" target="frame_a">Profit & Loss Grouping Print</a></li>
                                    <li><a href="#" target="frame_a">Bal. Sheet Grouping  Entry</a></li>
                                    <li><a href="#" target="frame_a">Bal. Sheet Grouping  Print</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li id="Glmonthend"><a href="#" target="frame_a">Month End Routine >></a>
                        <ul id="Glmonthendu1">
                            <li><a href="#" target="frame_a">Month End Processing</a></li>
                            <li><a href="#" target="frame_a">Month End Closing</a></li>
                            <li><a href="#" target="frame_a">Interest Generation</a></li>
                            <li><a href="#" target="frame_a">Managed Funds Extraction</a></li>
                            <li><a href="#" target="frame_a">Agency Commission Processing</a></li>
                        
                        </ul>
                    
                    </li>
                    
                    <li id="Glyearend"><a href="#" target="frame_a">Year End Routine >></a>
                        <ul id="Glyearendu1">
                            <li><a href="#" target="frame_a">Year End Mster Files Reset</a></li>
                            <li><a href="#" target="frame_a">Transfer Of Balance To New Year</a></li>
                        
                        </ul>
                    </li>
<!--                   
                    <li><a href="Prg_Li_Loan_Reqst.Aspx" target="frame_a">Loans Request Entry</a></li>
                    <li>
                        <a href="Prg_Li_Req_Entry.Aspx"target="frame_a">Claims Request Entry</a>
                    </li>
-->                                
            </ul>
         </li>
        <li id="Receivable"><a href="#">Receivable</a>
            <ul id="Receivableu1">
                    <li id="Recvcodessetup"><a href="#" target="frame_a">Codes Setup >></a>
                        <ul id="Recvcodessetupu1">
                            <li><a href="#" target="frame_a">Category Setup</a></li>
                            <li><a href="#" target="frame_a">Code Setup</a></li>
                            <li><a href="#" target="frame_a">Category Print</a></li>
                            <li><a href="#" target="frame_a">Code Print</a></li>
                            
                            
                        </ul>
                    </li>
                    <li id="Recdebentry"><a href="#" target="frame_a">Debtors Ledger Entry >></a>
                        <ul id="Recdebentryu1">
                            <li><a href="#">Accounts Receivable</a></li>
                            <li><a href="Receiptslist.aspx" target="">Receipts Entry (Ind. Life)</a></li>
                            <li><a href="Receiptotherslist.aspx" target="">Receipts Entry (Others)</a></li>
                            <li><a href="Receiptotherslist.aspx" target="">Accounts Payable Entry</a></li>
                            <li><a href="Receiptotherslist.aspx" target="">Journal Entry</a></li>
                        </ul>
                    </li>
                    
                    <li id="Recdebtransreport"><a href="#" target="frame_a">Debtors Ledger Trans Rep. >></a>
                        <ul id="Recdebtransreportu1">
                            <li><a href="#" target="">Receipts Print (Ind. Life)</a></li>
                            <li><a href="PRG_FIN_RECV_RECPT_PRINT.aspx" target="">Receipts Print (Others)</a></li>
                            <li><a href="#" target="frame_a">Daily Receipt Details</a></li>
                            <li><a href="#" target="frame_a">Trans. Details By Batch </a></li>
                            <li><a href="#" target="frame_a">Trans. Details By Acct No </a></li>
                            <li><a href="#" target="frame_a">Trans. Details By Date </a></li>
                            <li><a href="#" target="frame_a">Trans. Details By Branch </a></li>
                        </ul>
                    </li>
             
                    <li id="Recmasterupdate"><a href="#" target="frame_a">Debtors Ledger Master Update >></a>
                        <ul id="Recmasterupdateu1">
                            <li><a href="#" target="frame_a">Extract Trans. For Update</a></li>
                            <li><a href="#" target="frame_a"> Extracted Trans. Print</a></li>
                            <li><a href="#" target="frame_a">G/L Trans. Master Update</a></li>
                        </ul>
                    </li>                    
                    
                    <li id="Recdebtorreports"><a href="#" target="frame_a">Debtors Ledger Rep. >></a>
                        <ul id="Recdebtorreportsu1">
                            <li><a href="#"><B>Debtors Reports</B></a></li>
                            <li><a href="#" target="frame_a">Debtors Stmt By Date</a></li>
                            <li><a href="#" target="frame_a">Debtors Stmt By Ins.</a></li>
                            <li><a href="#" target="frame_a">Debtors Stmt By Pol.</a></li>
                            <li><a href="#" target="frame_a">Debtors Schedule</a></li>

                            <li><a href="#"><B>Debtors Outst. Reports</B></a></li>
                            <li><a href="#" target="frame_a">Outst Trans By Debit Note</a></li>
                            <li><a href="#" target="frame_a">Outst Trans By Policy</a></li>

                            <li><a href="#"><B>Aged Analysis Reports</B></a></li>
                            <li><a href="#" target="frame_a">Aged Analy. Det. By Account</a></li>
                            <li><a href="#" target="frame_a">Aged Analy. Summ. By Account</a></li>
                            <li><a href="#" target="frame_a">Aged Analy. Det. By Group</a></li>
                            <li><a href="#" target="frame_a">Aged Analy. Summ. By Group</a></li>
                            <li><a href="#" target="frame_a">Aged Analy. Det. By Cat.</a></li>
                            <li><a href="#" target="frame_a">Aged Analy. Summ. By Cat.</a></li>
                        <li><a href="#"><B>Debtors Matching Off Rep.</B></a></li>
                            <li><a href="#" target="frame_a">Debtors Matching Off Rep.</a></li>
                        </ul>
                    </li>
            </ul>
         </li>
         <li id="Payables"><a href="#">Payables</a>
             <ul id="Payablesu1">
               <li id="Paycodessetup"><a href="#" target="frame_a">Codes Setup >></a>
                        <ul id="Paycodessetupu1">
                            <li><a href="#" target="frame_a">Category Setup</a></li>
                            <li><a href="#" target="frame_a">Code Setup</a></li>
                            <li><a href="#" target="frame_a">Category Print</a></li>
                            <li><a href="#" target="frame_a">Code Print</a></li>
                        </ul>
                    </li>
                     <li id="Paycredtransentry"><a href="#" target="frame_a">Cred. Ledger Trans Entry >></a>
                        <ul id="Paycredtransentryu1">
                            <li><a href="#">Accounts Payable</a></li>
                            <li><a href="#" target="frame_a">Invoice Entry</a></li>
                            <li><a href="Receiptotherslist.aspx" target="">Accounts Payable Entry</a></li>
                            <li><a href="Receiptotherslist.aspx" target="">Journal Entry</a></li>
                        </ul>
                    </li>
                    <li id="Paycredtransrep"><a href="#" target="frame_a">Cred. Ledger Trans Report >></a>
                        <ul id="Paycredtransrepu1">
                            <li><a href="#" target="frame_a">Trans. Details By Batch </a></li>
                            <li><a href="#" target="frame_a">Trans. Details By Acct No </a></li>
                        </ul>
                    </li>
                    <li id="Paycreditorsreports"><a href="#" target="frame_a">Creditors Ledger Rep. >></a>
                        <ul id="Paycreditorsreportsu1">
                            <li><a href="#" target="frame_a">Creditors Statement Print </a></li>
                            <li><a href="#" target="frame_a">Creditors Schedule Print </a></li>
                            <li><a href="#" target="frame_a">Creditors Aged Analysis Print </a></li>
                            <li><a href="#" target="frame_a">Supplier Invoices List</a></li>
                            <li><a href="#" target="frame_a">Supplier Payments List</a></li>
                            <li><a href="#" target="frame_a">Supplier Outst. Invoices</a></li>
                        </ul>
                    </li>
             </ul>
  
         </li>
         <li id="Fixedassets">
         <a href="#">Fixed Assets</a>
             <ul id="Fixedassetsu1">
                 <li><a href="#"  target="frame_a"> Codes Setup</a></li>
                 <li><a href="#"  target="frame_a">Asset Profile Setup</a></li>
                 <li> <a href="#"  target="frame_a">Disposals</a></li>
                 <li> <a href="#"  target="frame_a">Depreciation Run</a></li>
                 <li id="Fareports"> <a href="#"  target="frame_a">Reports</a>
                     <ul id="Fareportsu1">
                       <li> <a href="#"  target="frame_a">Asset Schedule</a></li>
                       <li> <a href="#"  target="frame_a"></a></li>
   
                     </ul>
                 </li>

             </ul>
         </li>
         <li id="Investments">
         <a href="#">Investments</a>
             <ul id="Investmentsu1">
                 <li><a href="#"  target="frame_a"> Codes Setup</a></li>
                 <li><a href="#"  target="frame_a">Investment Profile Setup</a></li>
                 <li> <a href="#"  target="frame_a">Disposals</a></li>
                 <li> <a href="#"  target="frame_a">Additions</a></li>
                 <li id="Invreports"> <a href="#"  target="frame_a">Reports</a>
                     <ul id="Invreportsu1">
                       <li> <a href="#"  target="frame_a">Investment Schedule</a></li>
                       <li> <a href="#"  target="frame_a"></a></li>
   
                     </ul>
                 </li>

             </ul>
         </li>

     </ul>
       
       
       
       
	        </div><!-- END nav bar -->
        </div><!-- END Header -->
        <div id="content">
           
  
     <div id="main-features" class="sec">
                
       <div id="accountupdate" class="enumerated">
            
            <iframe id="frame_a" width="1000px" scrolling="yes" height="800px" frameborder="0" src="StartPage.aspx" name="frame_a">

            </iframe>
           </div>


            </div><!-- END toppy -->

     
              
          </div><!-- END Content-->
          </div><!-- END mid-->
          </div><!-- END mid-inner-->
          </div><!-- END mid-outer-->
          <div class="bottom-outer">
              <div class="bottom-inner">
                 <div class="bottom"></div>
               </div>
             </div>
    </div> <!-- END rounded-->
    </div> <!-- END Wrapper-->
     <div id="footer">

        <p> (c) 2014 Custodian and Allied Insurance PLC</p>

    </div><!-- END footer-->
    </form>
</body>
</html>
