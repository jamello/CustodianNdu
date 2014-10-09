<%@ Control Language="VB" AutoEventWireup="false" CodeFile="UC_BANP.ascx.vb" Inherits="UC_BANP" %>

<table align="center" border="0" cellpadding="0" cellspacing="0" class="tablemax">
    <tr>
        <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0" style="width:100%;" class="tbl_header_banner">
   			    <tr>
   			        <td colspan="2" valign="top">
   			            <table border="0" width="100%">
   			                <tr>
            			        <td valign="top" align="left" class="td_comp_name">
			                        &nbsp;<%=STRCOMP_NAME%>
            			        </td>
			                    <td valign="top" align="right" class="td_user_name">
            			             User:&nbsp;<%=STRUSER_LOGIN_NAME%>
			                    </td>
   			                </tr>
   			            </table>
   			        </td>
			    </tr>
                <!--
			    <tr>
			        <td colspan="2" valign="top"><hr /></td>
			    </tr>
                -->
                
                <tr>
                    <td align="center" colspan="2" valign="top">
                        <table border="0" width="100%" class="tbl_logo_banner">
                            <tr>
                                <td align="center" colspan="1" valign="top">
                                    <img alt="Image" src="Images/CAILogoN.jpg" style="width: 250px; height: 140px" />
                                </td>
                                <td align="center" colspan="1" valign="top">
                                    <img alt="Image" src="Images/caibanner.jpg" style="width: 700px; height: 140px" />
                                </td>
                            </tr>
                        </table>                            
                    </td>
                </tr>


                <tr>
                    <td align="left" colspan="2" valign="top" class="td_page_title">
                            &nbsp;<%=STRPAGE_TITLE%>
                    </td>
                </tr>
			    			    
            </table>
        </td>
    </tr>
</table>

