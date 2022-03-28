using System;
using System.Collections.Generic;
using System.Text;

namespace PlatformWellActual.DataModel
{
    public class ConfigurationModel
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public URLModel APIURL { get; set; }
        public ConnectionStringModel ConnectionString { get; set; }
    }

    public class URLModel
    {
        public string Login { get; set; }
        public string PlatformWell { get; set; }
    }

    public class ConnectionStringModel
    {
        public string PlatformWellConnectionString { get; set; }
    }
}
