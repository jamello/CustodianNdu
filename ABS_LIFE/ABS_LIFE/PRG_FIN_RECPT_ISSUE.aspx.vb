Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Imports System.Xml.Serialization
Imports System.Xml
Imports System.IO


Partial Public Class PRG_FIN_RECPT_ISSUE
    Inherits System.Web.UI.Page
    Dim rcRepo As ReceiptsRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim prodEnq As ProductDetailsRepository
    Dim polinfo As PolicyInfo
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim strSchKey As String
    Dim Rceipt As CustodianLife.Model.Receipts
    Protected publicMsgs As String = String.Empty
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        txtMOP.Attributes.Add("disabled", "disabled")
        txtMOPDesc.Attributes.Add("disabled", "disabled")
        txtTransDesc2.Attributes.Add("disabled", "disabled")
        txtAgentCode.Attributes.Add("disabled", "disabled")
        txtPolRegularContrib.Attributes.Add("disabled", "disabled")
        txtInsuredCode.Attributes.Add("disabled", "disabled")

        If Not Page.IsPostBack Then
            rcRepo = New ReceiptsRepository
            indLifeEnq = New IndLifeCodesRepository
            prodEnq = New ProductDetailsRepository

            Session("rcRepo") = rcRepo
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("rcId") = strKey

            'Company code value to be filled from login
            txtCompanyCode.Text = "001"
            txtEntryDate.Text = Now.Date.ToString()
            txtEntryDate.ReadOnly = True
            lblError.Visible = False


            SetComboBinding(cmbBranchCode, indLifeEnq.GetById("L02", "003"), "CodeLongDesc", "CodeItem")
            SetComboBinding(cmbCurrencyType, indLifeEnq.GetById("L02", "017"), "CodeLongDesc", "CodeItem")

            If strKey IsNot Nothing Then
                fillValues()
            Else
                rcRepo = CType(Session("rcRepo"), ReceiptsRepository)
            End If

        Else 'post back

            Me.Validate()
            If (Not Me.IsValid) Then
                Dim msg As String
                ' Loop through all validation controls to see which 
                ' generated the error(s).
                Dim oValidator As IValidator
                For Each oValidator In Validators
                    If oValidator.IsValid = False Then
                        msg = msg & "\n" & oValidator.ErrorMessage
                    End If
                Next

                lblError.Text = msg
                lblError.Visible = True
                publicMsgs = "javascript:alert('" + msg + "')"
            End If
        End If

    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click, butSaveN.Click
        Dim msg As String = String.Empty
        Try
            If Me.IsValid Then

                'this routine will persist only one object. 
                '1. The Receipt object

                updateFlag = CType(Session("updateFlag"), Boolean)
                If Not updateFlag Then 'if new record

                    'create a new instance of the Receipt object
                    Rceipt = New CustodianLife.Model.Receipts()
                    rcRepo = New ReceiptsRepository()
                    lblError.Visible = False
                    txtAgentCode.Enabled = True
                    Rceipt.AgentCode = txtAgentCode.Text
                    'txtAgentCode.Enabled = False

                    Rceipt.AmountFC = CType(txtReceiptAmtFC.Text, Decimal)
                    Rceipt.AmountLC = CType(txtReceiptAmtLC.Text, Decimal)

                    Rceipt.BankCode = txtBankGLCode.Text
                    Rceipt.BatchNo = CType(txtBatchNo.Text, Int32)
                    Rceipt.BranchCode = cmbBranchCode.SelectedValue.ToString
                    If Trim(txtChequeDate.Text).Length() > 0 Then
                        Rceipt.ChequeDate = ValidDate(txtChequeDate.Text)
                    Else
                        Rceipt.ChequeDate = #1/1/2014#
                    End If

                    Rceipt.ChequeInwardNo = txtChequeNo.Text
                    Rceipt.ChequeTellerNo = txtTellerNo.Text
                    Rceipt.CommissionApplicable = cmbCommissions.SelectedValue
                    Rceipt.CompanyCode = txtCompanyCode.Text

                    Rceipt.CurrencyType = cmbReceiptType.SelectedValue
                    Rceipt.EntryDate = Now.Date
                    Rceipt.InsuredCode = txtInsuredCode.Text

                    Rceipt.MainAccountCredit = txtMainAcctCredit.Text
                    Rceipt.MainAccountDebit = txtMainAcctDebit.Text
                    Rceipt.PayeeName = txtPayeeName.Text
                    Rceipt.PolicyPaymentMode = cmbMode.SelectedValue
                    Rceipt.PolicyRegularContribution = CType(txtPolRegularContrib.Text, Decimal)

                    Rceipt.PolicyPaymentMode = txtMOP.Text
                    Rceipt.ReceiptType = cmbReceiptType.SelectedValue
                    Rceipt.ReferenceNo = txtReceiptRefNo.Text

                    Dim docMonth As String = Right(txtBatchNo.Text, 2)
                    Dim docYear As String = Left(txtBatchNo.Text, 4)

                    'get new serial number
                    Dim newSerialNum As String = rcRepo.GetNextSerialNumber("L01", "001", docMonth, docYear, " ", "12", "11")


                    'get new receipt number
                    Dim newReceiptNo As String = rcRepo.GetNextSerialNumber("RCN", "002", "001", docYear, "IL-BR-", "12", "11")

                    txtSerialNo.Text = newSerialNum
                    Rceipt.SerialNo = CType(newSerialNum, Int64)
                    Rceipt.SubAccountCredit = txtSubAcctCredit.Text
                    Rceipt.SubAccountDebit = txtSubAcctDebit.Text
                    Rceipt.DocNo = Trim(newReceiptNo)

                    Rceipt.TempTransNo = txtTempReceiptNo.Text
                    Rceipt.TranDescription1 = txtTransDesc1.Text
                    Rceipt.TranDescription2 = txtTransDesc2.Text
                    Rceipt.TransDate = ValidDate(txtEffectiveDate.Text)
                    Rceipt.TransMode = cmbMode.SelectedValue
                    Rceipt.TransType = cmbTransType.SelectedValue
                    Rceipt.CurrencyType = cmbCurrencyType.SelectedValue
                    Rceipt.LedgerTypeCredit = "T"

                    'msg = "Values to be saved  agent code" _
                    '       & Rceipt.AgentCode _
                    '       & " amt fc: " & Rceipt.AmountFC _
                    '       & " amt lc: " & Rceipt.AmountLC _
                    '       & " branch code: " & Rceipt.BranchCode _
                    '       & " bank code: " & Rceipt.BankCode _
                    '       & " Batch no: " & Rceipt.BatchNo _
                    '       & " Chque date: " & Rceipt.ChequeDate _
                    '       & " chq no: " & Rceipt.ChequeInwardNo _
                    '       & " curr type: " & Rceipt.CurrencyType _
                    '       & " tella no: " & Rceipt.ChequeTellerNo _
                    '       & " com applic: " & Rceipt.CommissionApplicable _
                    '       & " Doc no: " & Rceipt.DocNo _
                    '       & " coy code: " & Rceipt.CompanyCode _
                    '       & " Entry date: " & Rceipt.EntryDate _
                    '       & " insure code: " & Rceipt.InsuredCode _
                    '       & " ledger type cr: " & Rceipt.LedgerTypeCredit _
                    '       & " main acct cr: " & Rceipt.MainAccountCredit _
                    '       & " main acct dr : " & Rceipt.MainAccountDebit _
                    '       & " payee name: " & Rceipt.PayeeName _
                    '       & " MOP mode: " & Rceipt.PolicyPaymentMode _
                    '       & " regular contrib : " & Rceipt.PolicyRegularContribution _
                    '       & " product code: " & Rceipt.ProductCode _
                    '       & " receipt type : " & Rceipt.ReceiptType _
                    '       & " Ref no: " & Rceipt.ReferenceNo _
                    '       & " id: " & Rceipt.rtId _
                    '       & " Serial no: " & Rceipt.SerialNo _
                    '       & " sub acct cr: " & Rceipt.SubAccountCredit _
                    '       & " sub acct dr: " & Rceipt.SubAccountDebit _
                    '       & " temp recpt no: " & Rceipt.TempTransNo _
                    '       & " trans desc1: " & Rceipt.TranDescription1 _
                    '       & " trans desc2 : " & Rceipt.TranDescription2 _
                    '       & " Trans date: " & Rceipt.TransDate _
                    '       & " Trans Mode: " & Rceipt.TransMode _
                    '       & " trans type : " & Rceipt.TransType
                    'publicMsgs = "javascript:alert('" + msg + "')"



                    rcRepo.Save(Rceipt)
                    Session("Rceipt") = Rceipt
                    msg = "Save Operation Successful"
                    lblError.Text = msg
                    lblError.Visible = True
                    publicMsgs = "javascript:alert('" + msg + "')"

                Else
                    Rceipt = CType(Session("Rceipt"), CustodianLife.Model.Receipts)
                    rcRepo = CType(Session("rcRepo"), ReceiptsRepository)

                    txtAgentCode.Enabled = True
                    Rceipt.AgentCode = txtAgentCode.Text
                    txtAgentCode.Enabled = False
                    Rceipt.AmountFC = CType(txtReceiptAmtFC.Text, Decimal)
                    Rceipt.AmountLC = CType(txtReceiptAmtLC.Text, Decimal)

                    Rceipt.BankCode = txtBankGLCode.Text
                    Rceipt.BatchNo = CType(txtBatchNo.Text, Int32)
                    Rceipt.BranchCode = cmbBranchCode.SelectedValue.ToString
                    If Trim(txtChequeDate.Text).Length() > 0 Then
                        Rceipt.ChequeDate = ValidDate(txtChequeDate.Text)
                    Else
                        Rceipt.ChequeDate = #1/1/2014#
                    End If


                    Rceipt.ChequeInwardNo = txtChequeNo.Text
                    Rceipt.ChequeTellerNo = txtTellerNo.Text
                    Rceipt.CommissionApplicable = cmbCommissions.SelectedValue
                    Rceipt.CompanyCode = txtCompanyCode.Text

                    Rceipt.CurrencyType = cmbReceiptType.SelectedValue
                    '  Rceipt.EntryDate = CType(txtEntryDate.Text, Date)
                    Rceipt.InsuredCode = txtInsuredCode.Text


                    Rceipt.MainAccountCredit = txtMainAcctCredit.Text
                    Rceipt.MainAccountDebit = txtMainAcctDebit.Text
                    Rceipt.PayeeName = txtPayeeName.Text
                    Rceipt.PolicyPaymentMode = cmbMode.SelectedValue
                    Rceipt.PolicyRegularContribution = CType(txtPolRegularContrib.Text, Decimal)

                    Rceipt.PolicyPaymentMode = txtMOP.Text
                    Rceipt.ReceiptType = cmbReceiptType.SelectedValue
                    Rceipt.ReferenceNo = txtReceiptRefNo.Text
                    Rceipt.SubAccountCredit = txtSubAcctCredit.Text
                    Rceipt.SubAccountDebit = txtSubAcctDebit.Text

                    Rceipt.TempTransNo = txtTempReceiptNo.Text
                    Rceipt.TranDescription1 = txtTransDesc1.Text
                    Rceipt.TranDescription2 = txtTransDesc2.Text
                    Rceipt.TransDate = ValidDate(txtEffectiveDate.Text)
                    Rceipt.TransMode = cmbMode.SelectedValue
                    Rceipt.TransType = cmbTransType.SelectedValue
                    Rceipt.CurrencyType = cmbCurrencyType.SelectedValue
                    Rceipt.LedgerTypeCredit = "T"

                    ''msg = "Values to be saved  agent code" _
                    ''                           & Rceipt.AgentCode _
                    ''                           & " amt fc: " & Rceipt.AmountFC _
                    ''                           & " amt lc: " & Rceipt.AmountLC _
                    ''                           & " branch code: " & Rceipt.BranchCode _
                    ''                           & " bank code: " & Rceipt.BankCode _
                    ''                           & " Batch no: " & Rceipt.BatchNo _
                    ''                           & " Chque date: " & Rceipt.ChequeDate _
                    ''                           & " chq no: " & Rceipt.ChequeInwardNo _
                    ''                           & " curr type: " & Rceipt.CurrencyType _
                    ''                           & " tella no: " & Rceipt.ChequeTellerNo _
                    ''                           & " com applic: " & Rceipt.CommissionApplicable _
                    ''                           & " Doc no: " & Rceipt.DocNo _
                    ''                           & " coy code: " & Rceipt.CompanyCode _
                    ''                           & " Entry date: " & Rceipt.EntryDate _
                    ''                           & " insure code: " & Rceipt.InsuredCode _
                    ''                           & " ledger type cr: " & Rceipt.LedgerTypeCredit _
                    ''                           & " main acct cr: " & Rceipt.MainAccountCredit _
                    ''                           & " main acct dr : " & Rceipt.MainAccountDebit _
                    ''                           & " payee name: " & Rceipt.PayeeName _
                    ''                           & " receipt mode: " & Rceipt.PolicyPaymentMode _
                    ''                           & " regular contrib : " & Rceipt.PolicyRegularContribution _
                    ''                           & " product code: " & Rceipt.ProductCode _
                    ''                           & " receipt type : " & Rceipt.ReceiptType _
                    ''                           & " Ref no: " & Rceipt.ReferenceNo _
                    ''                           & " id: " & Rceipt.rtId _
                    ''                           & " Serial no: " & Rceipt.SerialNo _
                    ''                           & " sub acct cr: " & Rceipt.SubAccountCredit _
                    ''                           & " sub acct dr: " & Rceipt.SubAccountDebit _
                    ''                           & " temp recpt no: " & Rceipt.TempTransNo _
                    ''                           & " trans desc1: " & Rceipt.TranDescription1 _
                    ''                           & " Sub serial : " & Rceipt.TranDescription2 _
                    ''                           & " Trans date: " & Rceipt.TransDate _
                    ''                           & " trans type : " & Rceipt.TransType
                    ''publicMsgs = "javascript:alert('" + msg + "')"


                    rcRepo.Save(Rceipt)
                    msg = "Save Operation Successful"
                    lblError.Text = msg
                    lblError.Visible = True
                    publicMsgs = "javascript:alert('" + msg + "')"
                End If

                initializeFields()


            End If
        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"

        End Try
    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub


    Private Sub fillValues()

        strKey = CType(Session("rcId"), String)
        rcRepo = CType(Session("rcRepo"), ReceiptsRepository)
        Rceipt = rcRepo.GetById(strKey)

        Session("Rceipt") = Rceipt
        If Rceipt IsNot Nothing Then
            txtReceiptNo.Enabled = True

            txtAgentCode.Text = Rceipt.AgentCode
            txtReceiptAmtFC.Text = Math.Round(Rceipt.AmountFC, 2).ToString()
            txtReceiptAmtLC.Text = Math.Round(Rceipt.AmountLC, 2).ToString()

            txtBankGLCode.Text = Rceipt.BankCode
            txtBatchNo.Text = Rceipt.BatchNo
            cmbBranchCode.SelectedValue = Rceipt.BranchCode
            txtChequeDate.Text = ValidDateFromDB(Rceipt.ChequeDate)


            txtChequeNo.Text = Rceipt.ChequeInwardNo
            txtTellerNo.Text = Rceipt.ChequeTellerNo
            cmbCommissions.SelectedValue = Rceipt.CommissionApplicable
            txtCompanyCode.Text = Rceipt.CompanyCode

            cmbReceiptType.SelectedValue = Rceipt.CurrencyType
            txtEntryDate.Text = ValidDateFromDB(Rceipt.EntryDate)
            txtInsuredCode.Text = Rceipt.InsuredCode

            txtMainAcctCredit.Text = Rceipt.MainAccountCredit
            txtMainAcctDebit.Text = Rceipt.MainAccountDebit
            txtPayeeName.Text = Rceipt.PayeeName
            cmbMode.SelectedValue = Rceipt.PolicyPaymentMode
            txtPolRegularContrib.Text = Math.Round(Rceipt.PolicyRegularContribution, 2)

            txtMOP.Text = Rceipt.PolicyPaymentMode
            cmbReceiptType.SelectedValue = Rceipt.ReceiptType
            txtReceiptRefNo.Text = Rceipt.ReferenceNo
            txtReceiptNo.Text = Rceipt.DocNo


            txtSerialNo.Text = Rceipt.SerialNo
            txtSubAcctCredit.Text = Rceipt.SubAccountCredit
            txtSubAcctDebit.Text = Rceipt.SubAccountDebit

            txtTempReceiptNo.Text = Rceipt.TempTransNo
            txtTransDesc1.Text = Rceipt.TranDescription1
            txtTransDesc2.Text = Rceipt.TranDescription2
            txtEffectiveDate.Text = ValidDateFromDB(Rceipt.TransDate)
            cmbMode.SelectedValue = Rceipt.TransMode
            cmbTransType.SelectedValue = Rceipt.TransType
            cmbCurrencyType.SelectedValue = Rceipt.CurrencyType

            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        txtReceiptNo.Enabled = False

        txtAgentCode.Text = String.Empty
        txtReceiptAmtFC.Text = String.Empty
        txtReceiptAmtLC.Text = String.Empty

        txtBankGLCode.Text = String.Empty
        txtBatchNo.Text = String.Empty
        cmbBranchCode.SelectedIndex = 0
        txtChequeDate.Text = String.Empty


        txtChequeNo.Text = String.Empty
        txtTellerNo.Text = String.Empty
        cmbCommissions.SelectedIndex = 0
        txtCompanyCode.Text = "001"

        cmbReceiptType.Text = String.Empty
        txtReceiptRefNo.Text = String.Empty
        ' txtEntryDate.Text = String.Empty
        txtInsuredCode.Text = String.Empty

        txtMainAcctCredit.Text = String.Empty
        txtMainAcctDebit.Text = String.Empty
        txtPayeeName.Text = String.Empty
        cmbMode.SelectedIndex = 0
        txtPolRegularContrib.Text = String.Empty

        txtMOP.Text = String.Empty
        cmbReceiptType.SelectedIndex = 0
        txtReceiptRefNo.Text = String.Empty
        txtSerialNo.Text = String.Empty
        txtSubAcctCredit.Text = String.Empty
        txtSubAcctDebit.Text = String.Empty

        txtTempReceiptNo.Text = String.Empty
        txtTransDesc1.Text = String.Empty
        txtTransDesc2.Text = String.Empty
        txtEffectiveDate.Text = String.Empty
        cmbTransType.SelectedIndex = 0
        cmbCurrencyType.SelectedIndex = 0

        txtReceiptNo.Text = String.Empty
        txtSubAcctDebitDesc.Text = String.Empty
        txtSubAcctCreditDesc.Text = String.Empty

        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        ' grdData.DataBind()

    End Sub



    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        Dim msg As String = String.Empty
        Rceipt = CType(Session("Rceipt"), CustodianLife.Model.Receipts)
        rcRepo = CType(Session("rcRepo"), ReceiptsRepository)
        Try
            rcRepo.Delete(Rceipt)
        Catch ex As Exception
            msg = ex.Message
            lblError.Text = msg
            lblError.Visible = True
            publicMsgs = "javascript:alert('" + msg + "')"
        End Try
        initializeFields()


    End Sub

    Protected Sub txtReceiptRefNo_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtReceiptRefNo.TextChanged

    End Sub
    Private Function ValidDate(ByVal DateValue As String) As DateTime
        Dim dateparts() As String = DateValue.Split(Microsoft.VisualBasic.ChrW(47))
        Dim strDateTest As String = dateparts(1) & "/" & dateparts(0) & "/" & dateparts(2)
        Dim dateIn As Date = Format(CDate(strDateTest), "MM/dd/yyyy")
        Return dateIn
    End Function
    Private Function ValidDateFromDB(ByVal DateValue As Date) As String
        Dim dateparts() As String = DateValue.Date.ToString.Split(Microsoft.VisualBasic.ChrW(47))
        Dim strDateTest As String = dateparts(1) & "/" & dateparts(0) & "/" & Left(dateparts(2), 4)
        Return strDateTest
    End Function


    <System.Web.Services.WebMethod()> _
    Public Shared Function PaymentsPeriodCover(ByVal _polnum As String, ByVal _mop As String, ByVal _effdate As String, ByVal _contrib As String, ByVal _amtpaid As String) As String
        Dim paycover As String = String.Empty
        Dim rRepo As New ReceiptsRepository()

        Try
            paycover = rRepo.GetPaymentCover(_polnum, _mop, _effdate, _contrib, _amtpaid)
            Return paycover
        Finally
            If paycover = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try

    End Function
    <System.Web.Services.WebMethod()> _
    Public Shared Function GetBranchInformation(ByVal _branchcode As String) As String
        Dim branchinfo As String = String.Empty
        Dim recRepo As New ReceiptsRepository()
        'Dim crit As String = 

        Try
            branchinfo = recRepo.GetBranchInfo(_branchcode)
            Return branchinfo
        Finally
            If branchinfo = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try

    End Function

    <System.Web.Services.WebMethod()> _
    Public Shared Function GetPolicyInformation(ByVal _polnum As String, ByVal _type As String) As String
        Dim polinfos As String = String.Empty
        Dim recRepo As New ReceiptsRepository()
        'Dim crit As String = 

        Try
            polinfos = recRepo.GetPolicyInfo(_polnum, _type)
            Return polinfos
        Finally
            If polinfos = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try

    End Function

    <System.Web.Services.WebMethod()> _
    Public Shared Function GetAccountChartDetails(ByVal _accountcode As String, ByVal _type As String) As String
        Dim acodes As String = String.Empty
        Dim recRepo As New ReceiptsRepository()
        'Dim crit As String = 

        Try
            acodes = recRepo.GetAccountChartDetails(_accountcode, _type)
            Return acodes
        Finally
            If acodes = "<NewDataSet />" Then
                Throw New Exception()
            End If
        End Try

    End Function


    Protected Sub csValidateCommissions_ServerValidate(ByVal source As Object, _
                                                       ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) _
                                                       Handles csValidateCommissions.ServerValidate
        If (cmbReceiptType.SelectedValue = "P" Or cmbReceiptType.SelectedValue = "D") Then
            If cmbCommissions.SelectedValue = "0" Then
                args.IsValid = False
            End If
        End If
    End Sub

    Protected Sub txtPolRegularContrib_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtPolRegularContrib.TextChanged

    End Sub

    Protected Sub txtTransDesc1_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtTransDesc1.TextChanged

    End Sub

    Protected Sub butClose_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butClose.Click
        Response.Redirect("ReceiptsList.aspx")
    End Sub

    Protected Sub csValidateCurrencyType_ServerValidate(ByVal source As Object, _
                                                        ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) _
                                                        Handles csValidateCurrencyType.ServerValidate
        If (cmbCurrencyType.SelectedValue = "0") Then
            args.IsValid = False
        End If
    End Sub

    Protected Sub butPrintReceipt_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butPrintReceipt.Click
        If Len(Trim(txtRecptNo.Text)) = 0 Then
            publicMsgs = "javascript:alert('Error! Please enter a valid receipt number')"
        Else
            Session("rcPrintNo") = txtRecptNo.Text
            Response.Redirect("ReceiptPrint.aspx")
        End If
    End Sub

    Protected Sub txtMainAcctCreditDesc_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtMainAcctCreditDesc.TextChanged

    End Sub

    Protected Sub txtMainAcctDebitDesc_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtMainAcctDebitDesc.TextChanged

    End Sub

    Protected Sub txtReceiptNo_TextChanged(ByVal sender As Object, ByVal e As EventArgs) Handles txtReceiptNo.TextChanged

    End Sub
End Class