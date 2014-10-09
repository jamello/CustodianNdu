Imports Microsoft.VisualStudio.TestTools.UnitTesting

Imports CustodianLife.Data
Imports System.Data.Common
Imports System.Data
Imports System.Data.SqlClient
Imports CustodianLife.Model
Imports CustodianLife.Repositories
Imports NHibernate
Imports CustodianLife




'''<summary>
'''This is a test class for ReceiptsRepositoryTest and is intended
'''to contain all ReceiptsRepositoryTest Unit Tests
'''</summary>
<TestClass()> _
Public Class ReceiptsRepositoryTest


    Private testContextInstance As TestContext

    '''<summary>
    '''Gets or sets the test context which provides
    '''information about and functionality for the current test run.
    '''</summary>
    Public Property TestContext() As TestContext
        Get
            Return testContextInstance
        End Get
        Set(ByVal value As TestContext)
            testContextInstance = Value
        End Set
    End Property

#Region "Additional test attributes"
    '
    'You can use the following additional attributes as you write your tests:
    '
    'Use ClassInitialize to run code before running the first test in the class
    '<ClassInitialize()>  _
    'Public Shared Sub MyClassInitialize(ByVal testContext As TestContext)
    'End Sub
    '
    'Use ClassCleanup to run code after all tests in a class have run
    '<ClassCleanup()>  _
    'Public Shared Sub MyClassCleanup()
    'End Sub
    '
    'Use TestInitialize to run code before running each test
    '<TestInitialize()>  _
    'Public Sub MyTestInitialize()
    'End Sub
    '
    'Use TestCleanup to run code after each test has run
    '<TestCleanup()>  _
    'Public Sub MyTestCleanup()
    'End Sub
    '
#End Region


    '''<summary>
    '''A test for GetNextSerialNumber
    '''</summary>
    <TestMethod()> _
    Public Sub GetNextSerialNumberTest()
        Dim target As ReceiptsRepository = New ReceiptsRepository ' TODO: Initialize to an appropriate value
        Dim sys_id As String = "L01" ' ("L01", "001", "2", "2014", "rr", "12", "11")
        Dim sys_type As String = "001" ' TODO: Initialize to an appropriate value
        Dim sys_branch As String = "2" ' TODO: Initialize to an appropriate value
        Dim sys_year As String = "2014" ' TODO: Initialize to an appropriate value
        Dim sys_prefix As String = String.Empty ' TODO: Initialize to an appropriate value
        Dim sys_out_int As String = "12" ' TODO: Initialize to an appropriate value
        Dim sys_out_char As String = "11" ' TODO: Initialize to an appropriate value
        Dim expected As String = "0005" ' TODO: Initialize to an appropriate value
        Dim actual As String
        actual = target.GetNextSerialNumber(sys_id, sys_type, sys_branch, sys_year, sys_prefix, sys_out_int, sys_out_char)
        Assert.AreEqual(expected, actual)
        Assert.Inconclusive("Verify the correctness of this test method.")
    End Sub
End Class
