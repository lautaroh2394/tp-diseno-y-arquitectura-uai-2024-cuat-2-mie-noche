using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;

namespace DAL
{
    public class DBConnectionManager
    {
        static private DBConnectionManager instance;
        public string ConnectionString;

        public static SqlConnection CreateSqlConnection()
        {
            if (DBConnectionManager.instance == null)
            {
                DBConnectionManager.instance = new DBConnectionManager();
            }

            return DBConnectionManager.instance.InstanceCreateDBConnection();
        }

        public DBConnectionManager() 
        {
            ConnectionString = ConfigManager.GetConfigValue(ConfigKeys.CONNECTION_STRING);
        }

        public SqlConnection InstanceCreateDBConnection()
        {
            return new SqlConnection(this.ConnectionString);
        } 
    }
}
