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

        protected SqlCommand CreateSqlCommand(string command, SqlParameter[] parameters = null)
        {
            SqlCommand CreatedCommand = new SqlCommand(command);
            if (parameters != null) CreatedCommand.Parameters.AddRange(parameters);
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
    }
}
