<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PRG_FIN_RECPT_ISSUE.aspx.vb" Inherits="ABS_LIFE.PRG_FIN_RECPT_ISSUE" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>
   <script language="javascript" type="text/javascript" src="Script/ScriptJS.js"></script>	
   
 <link rel="Stylesheet" href="SS_ILIFE.css" type="text/css" />
	<link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />   
    <link href="css/grid.css" rel="stylesheet" type="text/css" />   
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />   
    <script src="jquery-1.11.0.js" type="text/javascript"></script>
    <script src="jquery.simplemodal.js" type="text/javascript"></script>
    
    <title></title>
    
<script type="text/javascript">

    //warn before browser is closed or location is changed
    window.onbeforeunload = confirmExit;
    function confirmExit() {
        window.event.returnValue = 'If you navigate away from this page any unsaved changes will be lost!';
    }

    function cancelEvent(event) {
        window[event] = function() { null }

    }


    // calling jquery functions once document is ready
    $(document).ready(function() {

        var resultValueDR;
        var resultValueCR;
        var resultValue;
        var resultDesc;

        //Refresh screen with post back values
        function checkMode() {
            switch ($('#cmbMode').val()) {
                case "C":
                    $('#ChequeRow').hide();
                    break;
                default:
                    $('#ChequeRow').show();
            }

        }

        function CheckReceiptType() {
            switch ($('#cmbReceiptType').val()) {
                case "D":
                    $('#lblRefNo').text('Proposal No');
                    break;
                case "P":
                    $('#lblRefNo').text('Policy No');
                    break;
                case "X":
                case "L":
                case "V":
                case "R":
                case "I":
                case "T":
                case "S":
                case "G":
                case "O":
                    $('#lblMainAcctCR').show();
                    $('#txtMainAcctCredit').show();
                    $('#txtMainAcctCreditDesc').show();
                    $('#MainAccountCreditSearch').show();
                    $('#lblSubAcctCR').show();
                    $('#txtSubAcctCredit').show();
                    $('#txtSubAcctCreditDesc').show();
                    break;
                default:
                    $('#lblMainAcctCR').hide();
                    $('#txtMainAcctCredit').hide();
                    $('#MainAcctCreditAdd').hide();
                    $('#txtMainAcctCreditDesc').hide();
                    $('#MainAccountCreditSearch').hide();
                    $('#lblSubAcctCR').hide();
                    $('#txtSubAcctCredit').hide();
                    $('#txtSubAcctCreditDesc').hide();
                    $('#SubAccountCreditSearch').hide();
                    $('#SubAcctCreditAdd').hide();
                    $('#lblRefNo').text('Ref No');
                    break;

            }

        }

        checkMode();
        CheckReceiptType();

        $('#txtReceiptAmtLC').on('focusout', function(e) {
            e.preventDefault();
            $('#txtReceiptAmtFC').attr('value', $('#txtReceiptAmtLC').val());
        });

        $('#cmbMode').on('focusout', function(e) {
            e.preventDefault();
            checkMode();

            //return false;
        });


        $('#cmbReceiptType, #cmbCommissions').on('focusout', function(e) {
            e.preventDefault();
            CheckReceiptType();
        });

        //retrieve data on focus loss
        $("#txtMainAcctDebit").on('focusout', function(e) {
            e.preventDefault();
        if ($("#txtMainAcctDebit").val() != "")
            LoadChartInfo("txtMainAcctDebit", "Main", "DR");
            //return false;
        });

        //retrieve data on focus loss
        $("#txtSubAcctDebit").on('focusout', function(e) {
        e.preventDefault();

        if ($("#txtSubAcctDebit").val() != "")
            LoadChartInfo("txtSubAcctDebit", "Sub", "DR");
            //return false;
        });


        //retrieve data on focus loss
        $("#txtMainAcctCredit").on('focusout', function(e) {
        e.preventDefault();
        if ($("#txtMainAcctCredit").val() != "")
            LoadChartInfo("txtMainAcctCredit", "Main", "CR");
            //return false;
        });

        //retrieve data on focus loss
        $("#txtSubAcctCredit").on('focusout', function(e) {
            e.preventDefault();

            if ($("#txtSubAcctCredit").val() != "")
                LoadChartInfo("txtSubAcctCredit", "Sub", "CR");
            //return false;
        });

        //retrieve data on focus loss
        $("#txtReceiptRefNo").on('focusout', function(e) {
        e.preventDefault();
        if ($("#txtReceiptRefNo").val() != "")
            LoadPolicyInfoObject();
            return false;
        });

        //retrieve data on focus loss branches

        $("#txtBranchCode").on('focusout', function(e) {
        e.preventDefault();
        if ($("#txtBranchCode").val() != "")
            LoadBranchInfoObject();
            //return false;
        });

        //call popup to browse the Policies
        $('#imgReceiptRefNo').click(function(e) {
            e.preventDefault();
            var src = "\PolicyBrowse.aspx";
            $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 500,
                    padding: 0,
                    width: 830
                },
                appendTo: 'form',
                persist: true,
                overlayClose: true,
                opacity: 30,
                overlayCss: { backgroundColor: "black" },
                onClose: function(dialog) {

                    var resultPolicy = $("iframe[src='PolicyBrowse.aspx']").contents().find("#txtValue").val();
                    var resultProposal = $("iframe[src='PolicyBrowse.aspx']").contents().find("#txtValue1").val();
                    switch ($('#cmbReceiptType').val()) {
                        case "D":
                            if (resultProposal.length > 0)
                                $('#txtReceiptRefNo').attr('value', resultProposal); // proposal code
                            
                            break;
                        case "P":

                            if (resultPolicy.length > 0)
                                $('#txtReceiptRefNo').attr('value', resultPolicy); // policy code
                            break;
                        default:
                            //$('#lblRefNo').text('Ref No');
                            break;
                    }


                    dialog.data.fadeOut('200', function() {
                        dialog.container.slideUp('200', function() {
                            dialog.overlay.fadeOut('200', function() {
                                $.modal.close();
                            });
                        });
                    });
                }
            });
        });


        //call print receipt popup 
        $('#butPrint').click (function(e) {
            e.preventDefault();
            //copy content of receipt number to the print dialog receipt number
            $('#txtRecptNo').attr('value', document.getElementById('txtReceiptNo').value)

            $('#PrintDialog').css({ display: true });
            $('#PrintDialog').modal({
                containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 400,
                    padding: 5,
                    width: 500
                },
                appendTo: 'form',
                persist: true,
                overlayClose: false,
                opacity: 40,
                overlayCss: { backgroundColor: "black" }

            }
              );
        });
        //call popup to add to the main account
        $('#MainAcctDebitAdd, #SubAcctDebitAdd,#MainAcctCreditAdd,#SubAcctCreditAdd').click(function(e) {
            e.preventDefault();
            var src = "\ChartOfAccountsEntryBrowse.aspx";
            $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="1100" style="border:0">', {
                closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 500,
                    padding: 0,
                    width: 1100
                },
                appendTo: 'form',
                persist: true,
                overlayClose: true,
                opacity: 50,
                overlayCss: { backgroundColor: "black" },
                onClose: function(dialog) {

                    dialog.data.fadeOut('200', function() {
                        dialog.container.slideUp('200', function() {
                            dialog.overlay.fadeOut('200', function() {
                                $.modal.close();
                            });
                        });
                    });
                }
            });
        });


        //call popup to browse the main account
        $('#MainAccountDebitSearch').click(function(e) {
            e.preventDefault();
            var src = "\AccountChartBrowse.aspx";
            $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 500,
                    padding: 0,
                    width: 830
                },
                appendTo: 'form',
                persist: true,
                overlayClose: true,
                opacity: 30,
                overlayCss: { backgroundColor: "black" },
                onClose: function(dialog) {

                    var resultValueDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue").val();
                    var resultDescDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc").val();
                    if (resultValueDR.length > 0)
                        $('#txtMainAcctDebit').attr('value', resultValueDR); // Main account code
                    if (resultDescDR.length > 0)
                        $('#txtMainAcctDebitDesc').attr('value', resultDescDR); // Main account description
                    

                    dialog.data.fadeOut('200', function() {
                        dialog.container.slideUp('200', function() {
                            dialog.overlay.fadeOut('200', function() {
                                $.modal.close();
                            });
                        });
                    });
                }
            });
        });

        //call popup to browse the sub account
        $('#SubAccountDebitSearch').click(function(e) {
            e.preventDefault();
            var src = "\AccountChartBrowse.aspx?MainAcct=" + $('#txtMainAcctDebit').val();
            $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 500,
                    padding: 0,
                    width: 830
                },
                appendTo: 'form',
                persist: true,
                overlayClose: true,
                opacity: 30,
                overlayCss: { backgroundColor: "black" },
                onClose: function(dialog) {

                    var resultValSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue1").val();
                    var resultDescSubDR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc1").val();
                    if (resultValSubDR.length > 0)
                        $('#txtSubAcctDebit').attr('value', resultValSubDR);
                    if (resultDescSubDR.length > 0)
                        $('#txtSubAcctDebitDesc').attr('value', resultDescSubDR);
                    
                    dialog.data.fadeOut('200', function() {
                        dialog.container.slideUp('200', function() {
                            dialog.overlay.fadeOut('200', function() {
                                $.modal.close();
                            });
                        });
                    });
                }
            });
        });

        //call popup to browse
        $('#MainAccountCreditSearch').click(function(e) {
            e.preventDefault();
            var src = "\AccountChartBrowse.aspx";
            $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                closeHTML: "<a  class='modalCloseImg' href='#'></a>",
                onOpen: function(dialog) {
                    dialog.overlay.fadeIn('slow', function() {
                        dialog.container.slideDown('100', function() {
                            dialog.data.fadeIn('fast');
                        });
                    });
                },
                preventDefault: true,
                containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 500,
                    padding: 0,
                    width: 830
                },
                appendTo: 'form',
                persist: true,
                overlayClose: true,
                opacity: 30,
                overlayCss: { backgroundColor: "black" },
                onClose: function(dialog) {

                    var resultValueCR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue").val();
                    var resultDescCR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc").val();
                    
                    if (resultValueCR.length > 0)
                        $('#txtMainAcctCredit').attr('value', resultValueCR);

                    if (resultDescCR.length > 0)
                        $('#txtMainAcctCreditDesc').attr('value', resultDescCR);
                    
                    var resultValSubCR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue1").val();
                    var resultDescSubCR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc1").val();

                    if (resultValSubCR.length > 0)
                        $('#txtSubAcctCredit').attr('value', resultValSubCR);

                    if (resultDescSubCR.length > 0)
                        $('#txtSubAcctCreditDesc').attr('value', resultDescSubCR);
                        
                    dialog.data.fadeOut('200', function() {
                        dialog.container.slideUp('200', function() {
                            dialog.overlay.fadeOut('200', function() {
                                $.modal.close();
                            });
                        });
                    });
                }
            });
        });

        //call popup to browse the sub account
        $('#SubAccountCreditSearch').click(function(e) {
            e.preventDefault();
            var src = "\AccountChartBrowse.aspx?MainAcct=" + $('#txtMainAcctCredit').val();
            var src = "\AccountChartBrowse.aspx";
            $.modal('<iframe id="simplemodal-container" src="' + src + '" height="500" width="830" style="border:0">', {
                closeHTML: "<a  class='modalCloseImg' href='#'></a>", containerCss: {
                    backgroundColor: "#fff",
                    borderColor: "#fff",
                    height: 500,
                    padding: 0,
                    width: 830
                },
                appendTo: 'form',
                persist: true,
                overlayClose: true,
                opacity: 30,
                overlayCss: { backgroundColor: "black" },
                onClose: function(dialog) {

                    var resultValSubCR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtValue1").val();
                    var resultDescSubCR = $("iframe[src='AccountChartBrowse.aspx']").contents().find("#txtDesc1").val();

                    if (resultValSubCR.length > 0)
                        $('#txtSubAcctCredit').attr('value', resultValSubCR);

                    if (resultDescSubCR.length > 0)
                        $('#txtSubAcctCreditDesc').attr('value', resultDescSubCR);
                        
                    dialog.data.fadeOut('200', function() {
                        dialog.container.slideUp('200', function() {
                            dialog.overlay.fadeOut('200', function() {
                                $.modal.close();
                            });
                        });
                    });
                }
            });
        });

        //retrieve data on focus loss
        $("#txtTransDesc1").on('focusout', function(e) {
        e.preventDefault();
        if ($("#txtTransDesc1").val() != "")
           // LoadPeriodsCover();
            return false;
        });

        //retrieve data on focus
        // $("#txtTransDesc1").on('focusout', function(e) {
        //var keyCode = e.keyCode || e.which;
        //trap the TAB key
        //if (keyCode == 9) {
        //    e.preventDefault();
        // call custom function here
        //LoadMOPPremium();
        // return false;
        //   }
        //});


        //loading screen functionality - this part is additional - start
        $("#divTable").ajaxStart(OnAjaxStart);
        $("#divTable").ajaxError(OnAjaxError);
        $("#divTable").ajaxSuccess(OnAjaxSuccess);
        $("#divTable").ajaxStop(OnAjaxStop);
        $("#divTable").ajaxComplete(OnAjaxComplete);
        //loading screen functionality - this part is additional - end
    });

    // ajax call to load account chart information
    function LoadChartInfo(accountcode, ctype, drcr) {
        $.ajax({
            type: "POST",
            url: "PRG_FIN_RECPT_ISSUE.aspx/GetAccountChartDetails",
            data: JSON.stringify({ _accountcode: document.getElementById(accountcode).value, _type: ctype}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success:   function (data) {
            var xmlDoc = $.parseXML(data.d);
            var xml = $(xmlDoc);
            var accountcharts = xml.find("Table");
            retrieve_AccountChartInfoValues(accountcharts, ctype, drcr)},
            failure: OnFailure,
            error: OnError_LoadChartInfo
        });
        // this avoids page refresh on button click
        return false;
    }
    // retrieve the values and
    function retrieve_AccountChartInfoValues(accountcharts, ctype, drcr) {
        //debugger;
        $.each(accountcharts, function() {
        var accountchart = $(this);

        if (ctype == "Main" && drcr == "DR") {

            document.getElementById('txtMainAcctDebitDesc').value = $(this).find("sMainDesc").text()
           // document.getElementById('txtSubAcctDebit').value = $(this).find("sSubCode").text()
           // document.getElementById('txtSubAcctDebitDesc').value = $(this).find("sSubDesc").text()
            }
        else if (ctype == "Main" && drcr == "CR") {
            document.getElementById('txtMainAcctCreditDesc').value = $(this).find("sMainDesc").text()
          //  document.getElementById('txtSubAcctCredit').value = $(this).find("sSubCode").text()
          //  document.getElementById('txtSubAcctCreditDesc').value = $(this).find("sSubDesc").text()
            }
        else if (ctype == "Sub" && drcr == "DR") {

            document.getElementById('txtSubAcctDebit').value = $(this).find("sSubCode").text()
            document.getElementById('txtSubAcctDebitDesc').value = $(this).find("sSubDesc").text()
            document.getElementById('txtMainAcctDebit').value = $(this).find("sMainCode").text()
            document.getElementById('txtMainAcctDebitDesc').value = $(this).find("sMainDesc").text()

        }
        else if (ctype == "Sub" && drcr == "CR") {
            document.getElementById('txtSubAcctCredit').value = $(this).find("sSubCode").text()
            document.getElementById('txtSubAcctCreditDesc').value = $(this).find("sSubDesc").text()
            document.getElementById('txtMainAcctCredit').value = $(this).find("sMainCode").text()
            document.getElementById('txtMainAcctCreditDesc').value = $(this).find("sMainDesc").text()
        }

        });
    }

    
    // ajax call to load policy information
    function LoadBranchInfoObject() {
        $.ajax({
            type: "POST",
            url: "PRG_FIN_RECPT_ISSUE.aspx/GetBranchInformation",
            data: JSON.stringify({ _branchcode: document.getElementById('txtBranchCode').value}),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess_LoadBranchInfoObject,
            failure: OnFailure,
            error: OnError_LoadBranchInfoObject
        });
        // this avoids page refresh on button click
        return false;
    }
    function OnSuccess_LoadBranchInfoObject(response) {
        //debugger;

        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        var branches = xml.find("Table");
        retrieve_BranchInfoValues(branches);

    }
    // retrieve the values for branch
    function retrieve_BranchInfoValues(branches) {
        //debugger;
        $.each(branches, function() {
        var branch = $(this);
        $("#cmbBranchCode").val($(this).find("sCode").text()) 
     });
    }


    // ajax call to load policy information
    function LoadPolicyInfoObject() {
        $.ajax({
            type: "POST",
            url: "PRG_FIN_RECPT_ISSUE.aspx/GetPolicyInformation",
            data: JSON.stringify({ _polnum: document.getElementById('txtReceiptRefNo').value, _type: document.getElementById('cmbReceiptType').value }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess_LoadPolicyInfoObject,
            failure: OnFailure,
            error: OnError_LoadPolicyInfoObject
        });
        // this avoids page refresh on button click
        return false;
    }
    // on sucess get the xml
    function OnSuccess_LoadPolicyInfoObject(response) {
        //debugger;
       
        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        var policyholders = xml.find("Table");
            retrieve_PolicyInfoValues(policyholders);
         
    }
    // retrieve the values and
    function retrieve_PolicyInfoValues(policyholders) {
        //debugger;
        $.each(policyholders, function() {
            var policyholder = $(this);

            document.getElementById('txtInsuredCode').value = $(this).find("TBIL_POLY_ASSRD_CD").text()
            document.getElementById('txtAgentCode').value = $(this).find("TBIL_POLY_AGCY_CODE").text()
            document.getElementById('txtAssuredName').value = $(this).find("Insured_Name").text()
            document.getElementById('txtAssuredAddress').value = $(this).find("Insured_Address").text()
            document.getElementById('txtPayeeName').value = $(this).find("Insured_Name").text()
            document.getElementById('txtAgentName').value = $(this).find("Agent_Name").text()
            document.getElementById('txtPolRegularContrib').value = $(this).find("TBIL_POL_PRM_DTL_MOP_PRM_LC").text()
            document.getElementById('txtMOP').value = $(this).find("Payment_Mode").text()
            document.getElementById('txtMOPDesc').value = $(this).find("Payment_Mode_Desc").text()
            document.getElementById('txtPolicyEffDate').value = $(this).find("TBIL_POLICY_EFF_DT").text()
                        
        });
     }

     // ajax call to load receipts cover details
     function LoadPeriodsCover() {
         $.ajax({
             type: "POST",
             url: "PRG_FIN_RECPT_ISSUE.aspx/PaymentsPeriodCover",
             data: JSON.stringify({_polnum: document.getElementById('txtReceiptRefNo').value,
                                   _mop: document.getElementById('txtMOP').value,
                                   _effdate: document.getElementById('txtPolicyEffDate').value,
                                   _contrib: document.getElementById('txtPolRegularContrib').value,
                                   _amtpaid: document.getElementById('txtReceiptAmtLC').value
                                 }),
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: OnSuccess_LoadPeriodsCover,
             failure: OnFailure_LoadPeriodsCover,
             error: OnError_LoadPeriodsCover
         });
         // this avoids page refresh on button click
         return false;
     }
     // on sucess get the xml
     function OnSuccess_LoadPeriodsCover(response) {
         //debugger;
         var xmlDoc = $.parseXML(response.d);
         var xml = $(xmlDoc);
         var coverdets = xml.find("Table");
          retrieve_LoadPeriodsCover(coverdets)

     }
     // retrieve the values and
     function retrieve_LoadPeriodsCover(coverdets) {
         //debugger;
         $.each(coverdets, function() {
         var coverdet = $(this);

             document.getElementById('txtTransDesc2').value = $(this).find("sPeriodsCoverRange").text()
         });
     }
     function OnFailure_LoadPeriodsCover(response) {
         //debugger;
         //alert('Failure!!!' + '<br/>' + response.reponseText);
         alert('Failure!: Periods Covered Failed. Parameters sent is empty or invalid. Please Re-Confirm' + '<br/>');
     }

     function OnError_LoadChartInfo(response) {
         //debugger;
         //var errorText = response.responseText;
         //alert('Error!!!' + '\n\n' + errorText);
         alert('Error!: Account Chart could not be Retrieved. Parameters sent is empty or invalid. Please Re-Confirm' + '<br/>');
     }
     function OnError_LoadBranchInfoObject(response) {
         //debugger;
         //var errorText = response.responseText;
         //alert('Error!!!' + '\n\n' + errorText);
         alert('Error!: Branch Infomation Not Found. Parameters Empty or Invalid. Please Re-Confirm' + '<br/>');
         $('#txtBranchCode').focus();
     }
     function OnError_LoadPolicyInfoObject(response) {
         //debugger;
         //var errorText = response.responseText;
         //alert('Error!!!' + '\n\n' + errorText);
         alert('Error!: Policy Infomation Not Found. Parameters Empty or Invalid. Please Re-Confirm' + '<br/>');
         $('#cmbMode').focus();
     }
     function OnError_LoadPeriodsCover(response) {
         //debugger;
         //var errorText = response.responseText;
         //alert('Error!!!' + '\n\n' + errorText);
         alert('Error!: Load Periods Cover Not Found. Parameters Empty or Invalid. Please Re-Confirm' + '<br/>');
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
    // loading screen functionality functions - this part is additional - end
</script>    

    

    <style type="text/css">
        .style1
        {
            height: 13px;
            width: 235px;
        }
        .style2
        {
            width: 235px;
        }
    </style>

    

</head>
<body onload="<%=publicMsgs%>"  onclick="return cancelEvent('onbeforeunload')">
    <form id="PRG_FIN_RECPT_ISSUE" runat="server"  SubmitDisabledControls="True">
    <div class="newpage">
<div>
<table>
<tr>
<td>
    <asp:Literal runat="server" Visible="false" ID="litMsgs"></asp:Literal>
<asp:Label runat="server" ID="Status" Font-Bold="true" ForeColor="Red" Visible="true" Text="Status:"> </asp:Label>
 <asp:Label runat="server" ID="lblError" Font-Bold="true" ForeColor="Red" Visible="false"> </asp:Label>
</td></tr>
</table>

     <div class="grid">
            <div class="rounded">
                <div class="top-outer"><div class="top-inner"><div class="top">
                    <h2>Individual Premium Reciepts Entry</h2>
                </div></div></div>
                <div class="mid-outer"><div class="mid-inner">
                <div class="mid">     
                	
			<table class="tbl_menu_new">
			    <tr><td colspan="4" class="myMenu_Title" align="center">Individual Premium Reciepts Entry </td><td></td><td></td><td></td></tr>
			    <tr><td>Receipt Number</td><td ><asp:TextBox ID="txtReceiptNo" runat="server" Width="150px" Enabled="False"></asp:TextBox> </td>					
			        <td>Entry Date</td>
				    <td><asp:TextBox ID="txtEntryDate" runat="server" Width="150px" Enabled="false"></asp:TextBox> </td>
                </tr>
				<tr>
					<td>Company Code</td>
					<td ><asp:TextBox ID="txtCompanyCode" runat="server" Width="150px"></asp:TextBox></td>
					<td>Serial Number</td>
					<td><asp:TextBox ID="txtSerialNo" runat="server" Width="150px"  Enabled="false" ></asp:TextBox></td>
				</tr>
				<tr>
					<td>Batch No</td>
					<td ><asp:TextBox ID="txtBatchNo" runat="server" Width="150px">0</asp:TextBox>(yyyymm)</td>
					<td>Transaction Type</td>
					<td><asp:Dropdownlist ID="cmbTransType" runat="server" Width="150px">
        				<asp:ListItem Value="R" Text="Receipt" Selected="True"></asp:ListItem>
        				</asp:Dropdownlist></td>

				</tr>
				
				<tr>
					<td>Temp. Receipt No</td>
					<td class="style1"><asp:TextBox ID="txtTempReceiptNo" runat="server" Width="150px"></asp:TextBox></td>
					<td>Effective Date</td>
					<td><asp:TextBox ID="txtEffectiveDate" runat="server" Width="150px"></asp:TextBox>
					<script language="JavaScript" type="text/javascript">
					    new tcal({ 'formname': 'PRG_FIN_RECPT_ISSUE', 'controlname': 'txtEffectiveDate' });</script>(dd/mm/yyyy) </td>

				</tr>

				<tr>
					<td>Receipt Mode</td>
					<td ><asp:Dropdownlist ID="cmbMode" runat="server" Width="150px">
        				<asp:ListItem Value="0" Text="Receipt Mode"></asp:ListItem>
        				<asp:ListItem Value="C" Text="Cash"></asp:ListItem>
        				<asp:ListItem Value="Q" Text="Cheque"></asp:ListItem>
        				<asp:ListItem Value="D" Text="Direct Payment"></asp:ListItem>
        				<asp:ListItem Value="T" Text="Teller"></asp:ListItem>
        				</asp:Dropdownlist></td>
					<td>Receipt Type</td>
					<td><asp:Dropdownlist ID="cmbReceiptType" runat="server" Width="150px">
        				<asp:ListItem Value="0" Text="Receipt Type"></asp:ListItem>
        				<asp:ListItem Value="D" Text="Premium Deposit"></asp:ListItem>
        				<asp:ListItem Value="P" Text="Regular Premium"></asp:ListItem>
        				<asp:ListItem Value="U" Text="Lumpsum"></asp:ListItem>
        				<asp:ListItem Value="F" Text="FAC"></asp:ListItem>
        				<asp:ListItem Value="C" Text="Co-Insurance"></asp:ListItem>
        				<asp:ListItem Value="L" Text="Lease"></asp:ListItem>
        				<asp:ListItem Value="X" Text="Cheque Exchange"></asp:ListItem>
        				<asp:ListItem Value="V" Text="Dividend"></asp:ListItem>
        				<asp:ListItem Value="R" Text="Refund"></asp:ListItem>
        				<asp:ListItem Value="Y" Text="Claim Recovery"></asp:ListItem>
        				<asp:ListItem Value="I" Text="Interest Received"></asp:ListItem>
        				<asp:ListItem Value="T" Text="Investment Income"></asp:ListItem>
        				<asp:ListItem Value="S" Text="Share Sale"></asp:ListItem>
        				<asp:ListItem Value="G" Text="Salvage"></asp:ListItem>
        				<asp:ListItem Value="O" Text="Others"></asp:ListItem>
        				</asp:Dropdownlist></td>

				</tr>
				<tr>
					<td><asp:Label ID="lblRefNo" runat="server" Text="Ref. No"> </asp:Label>  </td>
					<td><asp:TextBox ID="txtReceiptRefNo" runat="server" Width="250px"></asp:TextBox><img src="img/glass1.png" id="imgReceiptRefNo" alt="search" class="searchImage" />
					</td>
					<td>Insured Code </td>
					<td><asp:TextBox ID="txtInsuredCode" runat="server" Width="150px"></asp:TextBox>
					</td>

				</tr>
				<tr>
					<td>Teller No</td>
					<td><asp:TextBox ID="txtTellerNo" runat="server" Width="150px"></asp:TextBox></td>
					<td>Assured Address</td>
					<td><asp:TextBox ID="txtAssuredAddress" runat="server" Width="290px" Enabled="false" BorderStyle="None"></asp:TextBox>
  
                        </td>

				</tr>
				<tr>
				<td>Currency Type</td><td><asp:Dropdownlist ID="cmbCurrencyType" runat="server" Width="150px">
        				 <asp:ListItem Value="0" Text="Currency Type"></asp:ListItem>
        				    </asp:Dropdownlist>
                    <asp:CustomValidator ID="csValidateCurrencyType" runat="server"  
                        ErrorMessage="Please Select the Currency Type">*</asp:CustomValidator>
                    </td>					
					<td>Agent Code</td>
					<td><asp:TextBox ID="txtAgentCode" runat="server" Width="150px"></asp:TextBox>
					</td>

				</tr>
				<tr id="ChequeRow">
                    <td>Cheque Number</td>
					<td ><asp:TextBox ID="txtChequeNo" runat="server" Width="150px"></asp:TextBox></td>
                    <td>Cheque Date</td><td><asp:TextBox ID="txtChequeDate" runat="server" Width="150px"></asp:TextBox>					
                        <script language="JavaScript" type="text/javascript">
                            new tcal({ 'formname': 'PRG_FIN_RECPT_ISSUE', 'controlname': 'txtChequeDate' });</script> </td></tr>
				<tr>
					<td><asp:Label ID="Polyeffdate"  runat="server" CssClass="popupOffset"></asp:Label></td>
					<td class="style1">    <asp:TextBox ID="txtPolicyEffDate" runat="server"  Width="150px" CssClass="popupOffset">
                            </asp:TextBox></td>
				</tr>
				<tr>
					<td>Receipt Amount (LC)</td>
					<td ><asp:TextBox ID="txtReceiptAmtLC" runat="server" Width="150px" Text="0.00">
                        </asp:TextBox><asp:RegularExpressionValidator ID="rvDecimal" runat="server" 
                            ErrorMessage="Please Enter a Valid Receipt Amount" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtReceiptAmtLC">*</asp:RegularExpressionValidator></td>
					<td>Receipt Amount (FC)</td>
					<td><asp:TextBox ID="txtReceiptAmtFC" runat="server" Width="150px" Text="0.00"></asp:TextBox><asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ErrorMessage="Please Enter a Valid Receipt Amount" 
                                ValidationExpression="^(-)?\d+(\.\d\d)?$" ControlToValidate="txtReceiptAmtFC">*</asp:RegularExpressionValidator></td>

				</tr>

				<tr>
					<td>Payee Name</td>
					<td ><asp:TextBox ID="txtPayeeName" runat="server" Width="270px"></asp:TextBox></td>
					<td>Branch</td>
					<td><asp:TextBox ID="txtBranchCode" runat="server" Width="95px"></asp:TextBox>
                        <asp:Dropdownlist ID="cmbBranchCode" runat="server" Width="150px">
        				<asp:ListItem Value="0" Text="Branch Code"></asp:ListItem>
        				</asp:Dropdownlist></td>

				</tr>
				<tr>
					<td>Trans. Desc. 1</td>
					<td ><asp:TextBox ID="txtTransDesc1" runat="server" Width="270px"></asp:TextBox></td>
					<td><asp:Label ID="lblBankGLCode" runat="server" Text="Bank GL Code" CssClass="popupOffset"> </asp:Label>  </td>
					<td><asp:TextBox ID="txtBankGLCode" runat="server" Width="270px" CssClass="popupOffset"></asp:TextBox></td>

				</tr>
				<tr>
					<td>Trans. Desc. 2</td>
					<td ><asp:TextBox ID="txtTransDesc2" runat="server" Width="270px"></asp:TextBox></td>
					<td>Comm. Applicable?</td>
					<td><asp:Dropdownlist ID="cmbCommissions" runat="server" Width="100px">
        				<asp:ListItem Value="0" Text="Commissions Applicable?"></asp:ListItem>
        				<asp:ListItem Value="Y" Text="YES" Selected="True"></asp:ListItem>
        				<asp:ListItem Value="N" Text="NO"></asp:ListItem>
        				</asp:Dropdownlist>
                        <asp:CustomValidator ID="csValidateCommissions" runat="server" OnServerValidate="csValidateCommissions_ServerValidate"
                            ControlToValidate="cmbCommissions" ErrorMessage="Please Select Commission Applicable">*</asp:CustomValidator>
                    </td>

				</tr>
				<tr>
					<td>Policy Regular Contrib.</td>
					<td ><asp:TextBox ID="txtPolRegularContrib" runat="server" Width="150px" text=0.00></asp:TextBox></td>
					<td>Mode of Payment</td>
					<td><asp:TextBox ID="txtMOP" runat="server" Width="20px" Enabled="False"></asp:TextBox><asp:TextBox ID="txtMOPDesc" runat="server" Width="250px" Enabled="false" BorderStyle="None"></asp:TextBox></td>

				</tr>
                <tr>
					<td>Main Account (Debit)</td>
					<td ><asp:TextBox ID="txtMainAcctDebit" runat="server" Width="150px"></asp:TextBox>
					<img src="img/glass1.png" id="MainAccountDebitSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="MainAcctDebitAdd" alt="add record" class="searchImage" /></td>
					<td><asp:Label ID="lblMainAcctCR" runat="server" text="Main A/C (Credit)"></asp:Label></td><td><asp:TextBox ID="txtMainAcctCredit" runat="server" Width="150px"></asp:TextBox><img src="img/glass1.png" id="MainAccountCreditSearch"  alt="search" class="searchImage"  /><img src="img/plusimage.png" id="MainAcctCreditAdd" alt="add record" class="searchImage" />
                    </td>
				</tr>				
                <tr>
					<td>Sub Account (Debit)</td>
					<td ><asp:TextBox ID="txtSubAcctDebit" runat="server" Width="150px"></asp:TextBox>
					<img src="img/glass1.png" id="SubAccountDebitSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="SubAcctDebitAdd" alt="add record" class="searchImage" /></td>
					<td>  <asp:Label ID="lblSubAcctCR" runat="server" text="Sub A/C (Credit)"></asp:Label></td>
					<td><asp:TextBox ID="txtSubAcctCredit" runat="server" Width="150px"></asp:TextBox><img src="img/glass1.png" id="SubAccountCreditSearch" alt="search" class="searchImage" /><img src="img/plusimage.png" id="SubAcctCreditAdd" alt="add record" class="searchImage" />	
					</td>

				</tr>
				<tr>
				    <td><asp:TextBox ID="txtMainAcctDebitDesc" runat="server" Width="170px" BorderStyle="None" Enabled="false" > </asp:TextBox></td>
				    <td ><asp:TextBox ID="txtSubAcctDebitDesc" runat="server" Width="170px" BorderStyle="None" Enabled="false" ></asp:TextBox></td>
				    <td><asp:TextBox ID="txtMainAcctCreditDesc" runat="server" Width="170px" BorderStyle="None" Enabled="false" ></asp:TextBox></td>
				    <td><asp:TextBox ID="txtSubAcctCreditDesc" runat="server" Width="170px" BorderStyle="None" Enabled="false"> </asp:TextBox></td>
				</tr>				
				<tr>
					<td></td><td >
                        <asp:TextBox ID="txtAssuredName" runat="server" Width="270px" Enabled="false" BorderStyle="None"></asp:TextBox>
					</td>
                        <td>
					<asp:TextBox ID="txtAgentName" runat="server" Width="200px" Enabled="false" 
                                BorderStyle="None" ></asp:TextBox></td>
                        <td><asp:Button ID="butSave" runat="server" Text="Save" onclick="butSave_Click" Visible=false />
                        <asp:Button ID="butSaveN" runat="server" Text="Save" OnClientClick="JavaSave_Rtn()"  />
                        <asp:Button ID="butDelete" runat="server" Text="Delete"  />
                        <asp:Button ID="butPrint" runat="server" Text="Print" Visible="True" />
                        <asp:Button ID="butClose" runat="server" Text="Close" Visible="True" /></td>
				</tr>
			</table>
			
			                      </div></div></div>
            <div class="bottom-outer"><div class="bottom-inner">
            <div class="bottom"></div></div></div>                
        </div>      
    </div>
</div>
    <div id="divTable">
    
    </div>

<div id="PrintDialog" class="nodisplay">
    <table>
        <tr><td>Receipt Number</td>
			<td ><asp:TextBox ID="txtRecptNo" runat="server" Width="100px"></asp:TextBox></td></tr>
			        <tr><td></td><td><asp:Button ID="butPrintReceipt" runat="server" Text="Print" Visible="True" /></td></tr>
    </table>

</div>

</div>
		</form>
</body>
</html>
