﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using NHibernate;
using NHibernate.Cfg;
using NHibernate.Tool.hbm2ddl;

namespace CustodianLife.Data
{
    public class SessionProvider
    {
        private static ISessionFactory _sessionFactory;
        private static Configuration _config;

        public static ISessionFactory SessionFactory
        {
            get
            {
                if (_sessionFactory == null)
                {
                    _sessionFactory = CreateSessionFactory();
                }
                return _sessionFactory;
            }
        }
        public static Configuration Config
        {
            get
            {
                if (_config == null)
                {
                    _config = new Configuration();
                    _config.AddAssembly(Assembly.GetCallingAssembly());
                }
                return _config;
            }
        }

        private static ISessionFactory CreateSessionFactory()
        {
            return Config.BuildSessionFactory();
        }

        public static void RebuildSchema()
        {
            var schema = new SchemaExport(Config);
            schema.Create(true, true);
        }
    }
}
