using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public abstract class SqlInteractor
    {
        protected SqlCommand CreateStoredProcedureCommand(
            string SPName, SqlParameter[] parameters
            )
        {
            SqlCommand SPCommand = new SqlCommand();
            SPCommand.CommandText = SPName;
            SPCommand.CommandType = CommandType.StoredProcedure;
            SPCommand.Parameters.AddRange(parameters);
            return SPCommand;
        }

        protected SqlCommand CreateStoredProcedureCommandWithConnection(
            string SPName, SqlParameter[] parameters)
        {
            SqlCommand command = CreateStoredProcedureCommand(SPName, parameters);
            command.Connection = DBConnectionManager.CreateSqlConnection();
            return command;
        }

        protected SqlCommand CreateSqlCommand(string command, SqlParameter[] parameters = null)
        {
            SqlCommand CreatedCommand = new SqlCommand(command);
            if (parameters != null) CreatedCommand.Parameters.AddRange(parameters);
            return CreatedCommand;

        }

        protected SqlCommand CreateSqlCommandWithConnection(string command, SqlParameter[] parameters = null)
        {
            SqlCommand CreatedCommand = CreateSqlCommand(command, parameters);
            CreatedCommand.Connection = DBConnectionManager.CreateSqlConnection();
            return CreatedCommand;
        }

        protected SqlParameter[] BuildParameters(object[][] parametersData)
        {
            SqlParameter[] parameters = new SqlParameter[parametersData.Length];
            int index = 0;
            foreach (object[] parameter in parametersData)
            {
                parameters[index] = new SqlParameter((string)parameter[0], parameter[1]);
            }
            return parameters;
        }

        protected DataSet GetDataSource(SqlCommand command)
        {
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataSet dataSet = new DataSet();
            adapter.Fill(dataSet);
            return dataSet;
        }

        protected DataSet GetCommandDataSource(string commandText, SqlParameter[] parameters = null)
        {
            SqlCommand command = this.CreateSqlCommandWithConnection(commandText, parameters);
            return GetDataSource(command);
        }

        protected DataSet GetProcedureDataSource(string commandText, SqlParameter[] parameters = null)
        {
            SqlCommand command = this.CreateStoredProcedureCommandWithConnection(commandText, parameters);
            return GetDataSource(command);
        }
    }
}
