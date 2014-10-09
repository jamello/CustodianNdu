Imports System
Imports System.Collections.Generic
Imports System.Collections
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports CustodianLife.Data
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Partial Public Class PRG_LI_LOAN_INT_RT
    Inherits System.Web.UI.Page
    Dim lntRepo As LoanInterestRepository
    Dim indLifeEnq As IndLifeCodesRepository
    Dim updateFlag As Boolean
    Dim strKey As String
    Dim LoanInt As CustodianLife.Model.LoanInterest

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoanInt = New CustodianLife.Model.LoanInterest
            lntRepo = New LoanInterestRepository
            indLifeEnq = New IndLifeCodesRepository
            Session("lntRepo") = lntRepo
            Session("LoanInt") = LoanInt
            updateFlag = False
            Session("updateFlag") = updateFlag

            strKey = Request.QueryString("idd")
            Session("Intid") = strKey

            Dim lstLifeCodes As IList = CType(indLifeEnq.GetById("L01", "018"), IList) ' these are codes for loan interests rate
            SetComboBinding(cmbLoanCodeID, lstLifeCodes, "CodeLongDesc", "CodeItem")

            If strKey IsNot Nothing Then
                fillValues()

            Else
                lntRepo = CType(Session("lntRepo"), LoanInterestRepository)
            End If
        Else
            lntRepo = CType(Session("lntRepo"), LoanInterestRepository)
            LoanInt = CType(Session("LoanInt"), CustodianLife.Model.LoanInterest)

        End If
    End Sub

    Protected Sub butSave_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butSave.Click
        'this routine will persist only one object. 
        '1. The LoanInterest object

        updateFlag = CType(Session("updateFlag"), Boolean)


        If Not updateFlag Then 'if new record

            lblError.Visible = False

            LoanInt.LoanCode = cmbLoanCodeID.SelectedValue
            LoanInt.StartLoanAmount = CType(txtStartLoanAmt.Text, Decimal)
            LoanInt.EndLoanAmount = CType(txtEndLoanAmt.Text, Decimal)
            LoanInt.LoanInterestRate = CType(txtInterestRate.Text, Decimal)
            LoanInt.LoanInterestRatePer = CType(txtInterestRatePer.Text, Decimal)

            lntRepo.Save(LoanInt)
            Session("LoanInt") = LoanInt
        Else
            'LoanInt = CType(Session("LoanInt"), CustodianLife.Model.LoanInterest)
            'lntRepo = CType(Session("lntRepo"), LoanInterestRepository)

            LoanInt.LoanCode = cmbLoanCodeID.SelectedValue
            LoanInt.StartLoanAmount = CType(txtStartLoanAmt.Text, Decimal)
            LoanInt.EndLoanAmount = CType(txtEndLoanAmt.Text, Decimal)
            LoanInt.LoanInterestRate = CType(txtInterestRate.Text, Decimal)
            LoanInt.LoanInterestRatePer = CType(txtInterestRatePer.Text, Decimal)

            lntRepo.Save(LoanInt)

        End If

        initializeFields()
    End Sub
    Private Sub SetComboBinding(ByVal toBind As ListControl, ByVal dataSource As Object, ByVal displayMember As String, ByVal valueMember As String)
        toBind.DataTextField = displayMember
        toBind.DataValueField = valueMember
        toBind.DataSource = dataSource
        toBind.DataBind()
    End Sub
    Private Sub fillValues()

        strKey = CType(Session("Intid"), String)
        lntRepo = CType(Session("lntRepo"), LoanInterestRepository)
        LoanInt = lntRepo.GetById(strKey)

        Session("LoanInt") = LoanInt
        If LoanInt IsNot Nothing Then
            cmbLoanCodeID.SelectedValue = LoanInt.LoanCode
            txtStartLoanAmt.Text = Math.Round(LoanInt.StartLoanAmount, 2)
            txtEndLoanAmt.Text = Math.Round(LoanInt.EndLoanAmount, 2)
            txtInterestRate.Text = Math.Round(LoanInt.LoanInterestRate, 2)
            txtInterestRatePer.Text = Math.Round(LoanInt.LoanInterestRatePer, 2)
            updateFlag = True
            Session("updateFlag") = updateFlag
        End If

    End Sub
    Protected Sub initializeFields()
        cmbLoanCodeID.SelectedIndex = 0
        txtInterestRate.Text = String.Empty
        txtInterestRatePer.Text = String.Empty
        updateFlag = False
        Session("updateFlag") = updateFlag 'ready for a new record

        grdData.DataBind()

    End Sub


    Protected Sub butDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles butDelete.Click
        LoanInt = CType(Session("LoanInt"), CustodianLife.Model.LoanInterest)
        lntRepo = CType(Session("lntRepo"), LoanInterestRepository)
        lntRepo.Delete(LoanInt)
        initializeFields()

    End Sub
End Class