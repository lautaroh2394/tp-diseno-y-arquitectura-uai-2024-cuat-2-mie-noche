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
        public static string ConnectionString;

        public static SqlConnection CreateSqlConnection()
        {
            return DBConnectionManager.GetInstance().InstanceCreateDBConnection();
        }

        public SqlConnection InstanceCreateDBConnection()
        {
            return new SqlConnection(DBConnectionManager.ConnectionString);
        } 

        public static void SetConnectionString(string connectionString)
        {
            DBConnectionManager.ConnectionString = connectionString;
        }

        public static DBConnectionManager GetInstance()
        {
            if (DBConnectionManager.instance == null)
            {
                DBConnectionManager.instance = new DBConnectionManager();
            }
            return DBConnectionManager.instance;
        }

        public SqlCommand CreateStoredProcedureCommand(
            string SPName, SqlParameter[] parameters
            )
        {
            SqlCommand SPCommand = new SqlCommand();
            SPCommand.CommandText = SPName;
            SPCommand.CommandType = CommandType.StoredProcedure;
            SPCommand.Parameters.AddRange(parameters);
            return SPCommand;
        }

        public SqlCommand CreateStoredProcedureCommandWithConnection(
            string SPName, SqlParameter[] parameters)
        {
            SqlCommand command = CreateStoredProcedureCommand(SPName, parameters);
            command.Connection = this.InstanceCreateDBConnection();
            return command;
        }

        public SqlCommand CreateSqlCommand(string command, SqlParameter[] parameters = null)
        {
            SqlCommand CreatedCommand = new SqlCommand(command);
            if (parameters != null) CreatedCommand.Parameters.AddRange(parameters);
            return CreatedCommand;

        }

        public SqlCommand CreateSqlCommandWithConnection(string command, SqlParameter[] parameters = null)
        {
            SqlCommand CreatedCommand = CreateSqlCommand(command, parameters);
            CreatedCommand.Connection = this.InstanceCreateDBConnection();
            return CreatedCommand;
        }

        public SqlParameter[] BuildParameters(object[][] parametersData)
        {
            SqlParameter[] parameters = new SqlParameter[parametersData.Length];
            int index = 0;
            foreach (object[] parameter in parametersData)
            {
                parameters[index] = new SqlParameter((string)parameter[0], parameter[1]);
                index = index + 1;
            }
            return parameters;
        }

        public DataSet GetDataSource(SqlCommand command)
        {
            DataSet dataSet = null;
            try
            {
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                dataSet = new DataSet();
                adapter.Fill(dataSet);
            }
            catch (Exception ex) {
                Console.WriteLine("GetDataSource error", ex.ToString());
                dataSet = null;
            }
            
            return dataSet;
        }

        public DataSet GetCommandDataSource(string commandText, SqlParameter[] parameters = null)
        {
            SqlCommand command = this.CreateSqlCommandWithConnection(commandText, parameters);
            return GetDataSource(command);
        }

        public DataSet GetProcedureDataSource(string commandText, SqlParameter[] parameters = null)
        {
            SqlCommand command = this.CreateStoredProcedureCommandWithConnection(commandText, parameters);
            return GetDataSource(command);
        }
    }
}
