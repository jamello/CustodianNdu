 <%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EntryMenu.aspx.vb" Inherits="ABS_LIFE.EntryMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
        <script type="text/javascript" src="jquery.min.js"></script>

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
                <img src="img/CAILogoN.jpg" class="logo" height="40px" width="70px" alt="my image"
                    title="my image" />                 </a>
    <div id="nav1">
     <ul class="top-level-menu" >
        <li><a href="#">Home</a></li>
        <li><a href="#">Codes Masters setup</a>
              <ul class="second-level-menu" >
                    <li><a href="PRG_FIN_COMP_CODE.ASPX" target="frame_a">COMPANY CODE SETUP</a></li>
                    <li><a href="PRG_FIN_COMP_CODE.ASPX" target="frame_a">BRANCH CODE SETUP</a></li>
                    <li><a href="PRG_FIN_COMP_CODE.ASPX" target="frame_a">DEPARTMENT CODE SETUP</a></li>
                    <li><a href="#" target="frame_a">BRANCH CODE PRINT</a></li>
                    <li><a href="#" target="frame_a">DEPARTMENT CODE PRINT</a></li>
<!--                     
                    <li><a href="PRG_LI_PRD_CAT.ASPX" target="frame_a">PRODUCT CATEGORY SETUP</a></li>
                    <li><a href="PRG_LI_PRD_DTL.ASPX" target="frame_a">PRODUCT DETAILS SETUP</a></li>
                    <li><a href="PRG_LI_CODES.ASPX" target="frame_a">PRODUCT CODES SETUP</a></li>
                    <li><a href="PRG_LI_COV_MST.ASPX" target="frame_a">PRODUCT COVERS MASTER SETUP</a></li>
                    <li><a href="PRG_LI_PLAN_MST.ASPX" target="frame_a">PRODUCT PLAN MASTER SETUP</a></li>
                    <li><a href="PRO_LI_MEDICAL_DTLS.ASPX" target="frame_a"> MEDICAL EXAMINATION DETAILS SETUP </a></li>
                    <li>
                        <a href="PRG_LI_UNDW_RATE_TYPES.ASPX" target="frame_a">RATE TYPES CODE SETUP</a>

                    </li>
                    <li>
                        <a href="PRG_LI_UNDW_RATES.aspx" target="frame_a">PREMIUM RATES MASTER SETUP</a>

                    </li>
                    <li>
                        <a href="PRG_LI_INT_RATE.ASPX" target="frame_a">INTEREST RATE SETUP</a>

                    </li>
                    <li>
                        <a href="PRG_LI_BONUS_INT_RT.ASPX" target="frame_a">BONUS INTEREST RATE SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_LI_LOAN_INT_RT.ASPX" target="frame_a">LOAN INTEREST RATE SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_LI_AGCY_COMM.ASPX" target="frame_a">AGENCY STANDARD COMMISSION RATES SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_LI_AGCY_BUDGET.ASPX" target="frame_a">AGENCY PRODUCTION BUDGET SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_LI_BRK_COMM.ASPX" target="frame_a">BROKERS COMMISSION RATE SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_LI_TRTY_PRPTN.ASPX" target="frame_a">TREATY PROPORTION SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_LI_TRTY_COMM.ASPX" target="frame_a">REINSURANCE TREATY COMMISSION</a>
                    </li>
                    <li>
                        <a href="PRG_FIN_ACTVTY_CD_SETUP.ASPX" target="frame_a">ACTIVITY CODE (ACCOUNT) SETUP</a>
                    </li>
                    <li>
                        <a href="PRG_FIN_BANK_SETUP.ASPX" target="frame_a">BANK ACCOUNT CODE SETUP</a>
                    </li>

                    <li>
                        <a href="PRG_FIN_TRANS_CODE.ASPX" target="frame_a">TRANSACTION CODE (ACCOUNTS) SETUP</a>
                    </li>
-->              </ul>                
        </li>
  
        <li><a href="#">General Ledger</a>
            <ul class="second-level-menu">
           
                    <li><a href="#" target="frame_a">CODES SETUP >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">CUSTOMER CATEGORY CODE</a></li>
                            <li><a href="#" target="frame_a">CUSTOMER DETAILS CODE</a></li>
                            <li><a href="#" target="frame_a">TRANSACTION CODES</a></li>
                            <li><a href="#" target="frame_a">CURRENCY CODES</a></li>
                            <li><a href="#" target="frame_a">EXCHANGE RATES</a></li>
                            <li><a href="#" target="frame_a">MAIN/SUB ACCOUNT SETUP</a></li>
                            <li><a href="#" target="frame_a">ACTIVITY CODES</a></li>
                            <li><a href="#" target="frame_a">UNDWRTNG XREF TO G/L</a></li>
                            <li><a href="#" target="frame_a">BUDGET ENTRY</a></li>
                            <li><a href="#" target="frame_a">G/L CODES PRINT >></a>
                                <ul class="fourth-level-menu">
                                    <li><a href="#" target="frame_a">CUSTOMER CATEGORY</a></li>
                                    <li><a href="#" target="frame_a">CUSTOMER DETAILS CODE</a></li>
                                    <li><a href="#" target="frame_a">TRANSACTION CODES</a></li>
                                    <li><a href="#" target="frame_a">CURRENCY CODES</a></li>
                                    <li><a href="#" target="frame_a">EXCHANGE RATES</a></li>
                                    <li><a href="#" target="frame_a">MAIN/SUB ACCOUNT</a></li>
                                    <li><a href="#" target="frame_a">ACTIVITY CODES</a></li>
                                    <li><a href="#" target="frame_a">UNDWRTNG XREF TO G/L</a></li>
                                    <li><a href="#" target="frame_a">BUDGET DETAILS</a></li>                                
                                </ul>
                            </li>
                        </ul>
                        
                    </li>
                    <li><a href="#" target="frame_a">TRANSACTIONS >></a>
                        <ul class="third-level-menu">
                            <li>TRANS ENTRY</li>
                            <li><a href="ReceiptsList.aspx" target="frame_a">INDIVIDUAL LIFE RECEIPTS</a></li>
                            <li><a href="ReceiptOthersList.aspx" target="frame_a">ACCOUNTS RECEIVABLE</a></li>
                            <li><a href="#" target="frame_a"> ACCOUNTS PAYABLE</a></li>
                            <li><a href="#" target="frame_a">JOURNAL</a></li>
                            <li><a href="#" target="frame_a">CREDITORS INVOICE</a></li>
                            <li>TRANS REPORT</li>
                            <li><a href="#" target="frame_a">INDIVIDUAL LIFE RECEIPTS</a></li>
                            <li><a href="#" target="frame_a">ACCOUNTS RECEIVABLE</a></li>
                            <li><a href="#" target="frame_a">DAILY RECEIPT DETAILS LIST</a></li>
                            <li><a href="#" target="frame_a">POSTED RECEIPTS LIST</a></li>
                            <li><a href="#" target="frame_a">UNPOSTED RECEIPTS LIST</a></li>
                            <li><a href="#" target="frame_a">TRANS DET. BY BATCH </a></li>
                            <li><a href="#" target="frame_a">TRANS DET. BY BRANCH </a></li>
                            <li><a href="#" target="frame_a">TRANS DET. BY ACCT NO </a></li>
                            <li><a href="#" target="frame_a">TRANS DET. BY TRANS DATE </a></li>
                            <li><a href="#" target="frame_a">TRANS DET. BY ACCT NO </a></li>
                        </ul>
                    
                    </li>
                    
                    <li><a href="#" target="frame_a">JOURNAL PROCESSING >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">ALLOCATION JV PROCESSING</a></li>
                            <li><a href="#" target="frame_a">G/L TRANS. AUTO REVERSAL</a></li>
                        </ul>
                    </li>
                    
                    <li><a href="#" target="frame_a">MASTER FILES UPDATE >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">EXTRACT FOR UPDATE</a></li>
                            <li><a href="#" target="frame_a">EXTRACTED TRANS PRINT</a></li>
                            <li><a href="#" target="frame_a">G/L MASTER UPDATE</a></li>
                        </ul>
                    </li>
                    <li><a href="#" target="frame_a">REPORTS >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">BANK/CASH BOOK DET.</a></li>
                            <li><a href="#" target="frame_a">BANK/CASH POSITION</a></li>
                            <li><a href="#" target="frame_a">G/L DETAILS LIST(MAIN)</a></li>
                            <li><a href="#" target="frame_a">G/L DETAILS LIST(SUB)</a></li>
                            <li><a href="#" target="frame_a">TRIAL BALANCE(MAIN)</a></li>
                            <li><a href="#" target="frame_a">TRIAL BALANCE(SUB)</a></li>
                            <li><a href="#" target="frame_a">TRL BAL.(MAIN) BY BRCH/DEPT</a></li>
                            <li><a href="#" target="frame_a">BUDGET VAR. REPORT</a></li>
                            <li><a href="#" target="frame_a">BALANCE SHEET</a></li>
                            <li><a href="#" target="frame_a">SCH. TO BALANCE SHEET</a></li>
                            <li><a href="#" target="frame_a">SCH. TO INC. & EXP.</a></li>
                            <li><a href="#" target="frame_a">FIN. REPORT GROUPING >></a>
                                <ul class="fourth-level-menu">                                
                                    <li><a href="#" target="frame_a">INC. & EXP. GROUPING ENTRY</a></li>
                                    <li><a href="#" target="frame_a">INC. & EXP. GROUPING PRINT</a></li>
                                    <li><a href="#" target="frame_a">PROFIT & LOSS GROUPING ENTRY</a></li>
                                    <li><a href="#" target="frame_a">PROFIT & LOSS GROUPING PRINT</a></li>
                                    <li><a href="#" target="frame_a">BAL. SHEET GROUPING  ENTRY</a></li>
                                    <li><a href="#" target="frame_a">BAL. SHEET GROUPING  PRINT</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li><a href="#" target="frame_a">MONTH END ROUTINE >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">MONTH END PROCESSING</a></li>
                            <li><a href="#" target="frame_a">MONTH END CLOSING</a></li>
                            <li><a href="#" target="frame_a">INTEREST GENERATION</a></li>
                            <li><a href="#" target="frame_a">MANAGED FUNDS EXTRACTION</a></li>
                            <li><a href="#" target="frame_a">AGENCY COMMISSION PROCESSING</a></li>
                        
                        </ul>
                    
                    </li>
                    
                    <li><a href="#" target="frame_a">YEAR END ROUTINE >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">YEAR END MSTER FILES RESET</a></li>
                            <li><a href="#" target="frame_a">TRANSFER OF BALANCE TO NEW YEAR</a></li>
                        
                        </ul>
                    </li>
<!--                   
                    <li><a href="PRG_LI_LOAN_REQST.ASPX" target="frame_a">LOANS REQUEST ENTRY</a></li>
                    <li>
                        <a href="PRG_LI_REQ_ENTRY.ASPX"target="frame_a">CLAIMS REQUEST ENTRY</a>
                    </li>
-->                                
            </ul>
         </li>
        <li><a href="#">Receivable</a>
            <ul class="second-level-menu">
                    <li><a href="#" target="frame_a">CODES SETUP >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">CATEGORY SETUP</a></li>
                            <li><a href="#" target="frame_a">CODE SETUP</a></li>
                            <li><a href="#" target="frame_a">CATEGORY PRINT</a></li>
                            <li><a href="#" target="frame_a">CODE PRINT</a></li>
                            
                            
                        </ul>
                    </li>
                    <li><a href="#" target="frame_a">DEBTORS LEDGER ENTRY >></a>
                        <ul class="third-level-menu">
                            <li>ACCOUNTS RECEIVABLE</li>
                            <li><a href="ReceiptsList.aspx" target="frame_a">RECEIPTS ENTRY (Ind. Life)</a></li>
                            <li><a href="ReceiptOthersList.aspx" target="frame_a">RECEIPTS ENTRY (Others)</a></li>
                            <li><a href="#" target="frame_a">ACCOUNTS PAYABLE ENTRY</a></li>
                            <li><a href="#" target="frame_a">JOURNAL ENTRY</a></li>
                        </ul>
                    </li>
                    
                    <li><a href="#" target="frame_a">DEBTORS LEDGER TRANS REP. >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">RECEIPTS PRINT (Ind. Life)</a></li>
                            <li><a href="#" target="frame_a">RECEIPTS PRINT (Others)</a></li>
                            <li><a href="#" target="frame_a">DAILY RECEIPT DETAILS</a></li>
                            <li><a href="#" target="frame_a">TRANS. DETAILS BY BATCH </a></li>
                            <li><a href="#" target="frame_a">TRANS. DETAILS BY ACCT NO </a></li>
                            <li><a href="#" target="frame_a">TRANS. DETAILS BY DATE </a></li>
                            <li><a href="#" target="frame_a">TRANS. DETAILS BY BRANCH </a></li>
                        </ul>
                    </li>
             
                    <li><a href="#" target="frame_a">DEBTORS LEDGER MASTER UPDATE >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">EXTRACT TRANS. FOR UPDATE</a></li>
                            <li><a href="#" target="frame_a"> EXTRACTED TRANS. PRINT</a></li>
                            <li><a href="#" target="frame_a">G/L TRANS. MASTER UPDATE</a></li>
                        </ul>
                    </li>                    
                    
                    <li><a href="#" target="frame_a">DEBTORS LEDGER REP. >></a>
                        <ul class="third-level-menu">
                            <li><b>DEBTORS REPORTS</b></li>
                            <li><a href="#" target="frame_a">DEBTORS STMT BY DATE</a></li>
                            <li><a href="#" target="frame_a">DEBTORS STMT BY INS.</a></li>
                            <li><a href="#" target="frame_a">DEBTORS STMT BY POL.</a></li>
                            <li><a href="#" target="frame_a">DEBTORS SCHEDULE</a></li>

                            <li><b>DEBTORS OUTST. REPORTS</b></li>
                            <li><a href="#" target="frame_a">OUTST TRANS BY DEBIT NOTE</a></li>
                            <li><a href="#" target="frame_a">OUTST TRANS BY POLICY</a></li>

                            <li><b>AGED ANALYSIS REPORTS</b></li>
                            <li><a href="#" target="frame_a">AGED ANALY. DET. BY ACCOUNT</a></li>
                            <li><a href="#" target="frame_a">AGED ANALY. SUMM. BY ACCOUNT</a></li>
                            <li><a href="#" target="frame_a">AGED ANALY. DET. BY GROUP</a></li>
                            <li><a href="#" target="frame_a">AGED ANALY. SUMM. BY GROUP</a></li>
                            <li><a href="#" target="frame_a">AGED ANALY. DET. BY CAT.</a></li>
                            <li><a href="#" target="frame_a">AGED ANALY. SUMM. BY CAT.</a></li>
                        <li><b>DEBTORS MATCHING OFF REP.</b></li>
                            <li><a href="#" target="frame_a">DEBTORS MATCHING OFF REP.</a></li>
                        </ul>
                    </li>
            </ul>
         </li>
         <li><a href="#">Payables</a>
             <ul class="second-level-menu">
               <li><a href="#" target="frame_a">CODES SETUP >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">CATEGORY SETUP</a></li>
                            <li><a href="#" target="frame_a">CODE SETUP</a></li>
                            <li><a href="#" target="frame_a">CATEGORY PRINT</a></li>
                            <li><a href="#" target="frame_a">CODE PRINT</a></li>
                            
                            
                        </ul>
                    </li>
                     <li><a href="#" target="frame_a">CRED. LEDGER TRANS ENTRY >></a>
                        <ul class="third-level-menu">
                            <li>ACCOUNTS PAYABLE</li>
                            <li><a href="#" target="frame_a">INVOICE ENTRY</a></li>
                            <li><a href="#" target="frame_a">ACCOUNTS PAYABLE ENTRY</a></li>
                            <li><a href="#" target="frame_a">JOURNAL ENTRY</a></li>
                        </ul>
                    </li>
                    <li><a href="#" target="frame_a">CRED. LEDGER TRANS REPORT >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">TRANS. DETAILS BY BATCH </a></li>
                            <li><a href="#" target="frame_a">TRANS. DETAILS BY ACCT NO </a></li>
                        </ul>
                    </li>
                    <li><a href="#" target="frame_a">CREDITORS LEDGER REP. >></a>
                        <ul class="third-level-menu">
                            <li><a href="#" target="frame_a">CREDITORS STATEMENT PRINT </a></li>
                            <li><a href="#" target="frame_a">CREDITORS SCHEDULE PRINT </a></li>
                            <li><a href="#" target="frame_a">CREDITORS AGED ANALYSIS PRINT </a></li>
                            <li><a href="#" target="frame_a">SUPPLIER INVOICES LIST</a></li>
                            <li><a href="#" target="frame_a">SUPPLIER PAYMENTS LIST</a></li>
                            <li><a href="#" target="frame_a">SUPPLIER OUTST. INVOICES</a></li>
                        </ul>
                    </li>
             </ul>
  
         </li>
         <li>
         <a href="#">Fixed Asset</a>
         <ul class="second-level-menu">
         
         </ul>
         </li>

     </ul>
       
       
       
       
	        </div><!-- END nav bar -->
        </div><!-- END Header -->
        <div id="content">
           
  
            <div id="main-features" class="sec">
                
       <div id="accountupdate" class="enumerated">
            
            <iframe id="frame_a" width="1200px" scrolling="yes" height="700px" frameborder="0" src="StartPage.aspx" name="frame_a">

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
