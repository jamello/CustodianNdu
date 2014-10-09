Imports System
Imports System.Web
Imports System.Web.Configuration
Public Class SiteGlobal
    Shared reppath As String
    Shared dbuser As String
    Shared dbpassword As String
    Shared dsnname As String
    Shared reportdb As String
    Shared reporsvr As String


    ''' <summary>
    ''' Full site title tag at root.
    ''' </summary>
    Public Shared Property ReportPath() As String
        Get
            Return reppath
        End Get
        Set(ByVal value As String)
            reppath = value
        End Set

    End Property

    Public Shared Property DBUserR() As String
        Get
            Return dbuser
        End Get
        Set(ByVal value As String)
            dbuser = value
        End Set

    End Property
    Public Shared Property DBPassWd() As String
        Get
            Return dbpassword
        End Get
        Set(ByVal value As String)
            dbpassword = value
        End Set

    End Property
    Public Shared Property DSNNameR() As String
        Get
            Return dsnname
        End Get
        Set(ByVal value As String)
            dsnname = value
        End Set

    End Property
    Public Shared Property ReportDBR() As String
        Get
            Return reportdb
        End Get
        Set(ByVal value As String)
            reportdb = value
        End Set

    End Property
    Public Shared Property ReportServer() As String
        Get
            Return reporsvr
        End Get
        Set(ByVal value As String)
            reporsvr = value
        End Set

    End Property

    Shared Sub New()
        ' Cache all these values in static properties.
        ReportServer = WebConfigurationManager.AppSettings("App_Report_Server")
        ReportPath = WebConfigurationManager.AppSettings("App_Report_Path")
        ReportDBR = WebConfigurationManager.AppSettings("App_Report_DB")
        DSNNameR = WebConfigurationManager.AppSettings("App_Report_DSN")
        DBUserR = WebConfigurationManager.AppSettings("App_Report_User")
        DBPassWd = WebConfigurationManager.AppSettings("App_Report_PassWd")

    End Sub

End Class
