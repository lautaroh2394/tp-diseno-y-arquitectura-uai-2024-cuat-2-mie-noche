using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using DAL;
namespace BLL
{
    public class ReservationCommands
    {
        static public string DATE_ISO_FORMAT = "yyyy-MM-dd HH:mm:ss";
        static public string GET_TODAY_RESERVATIONS = "get_today_reservations";
        static public string GET_RESERVATIONS = "get_reservations";
    }
    public class Reservations
    {
        private DBConnectionManager connectionManager;
        public Reservations() 
        {
            this.connectionManager = new DBConnectionManager();
        }

        public DataSet GetTodayReservationsDataSet(string categoryId = null)
        {
            SqlParameter[] parameters = new SqlParameter[0];
            if (categoryId != null) {
                connectionManager.BuildParameters(new object[][] { new object[] { "category_id", categoryId } });
            }

            DataSet dataSet = connectionManager.GetProcedureDataSource(ReservationCommands.GET_TODAY_RESERVATIONS, parameters);
            return dataSet;
        }

        public DataSet SearchReservations(
            DateTime startDate,
            DateTime endDate,
            string categoryId = null,
            string client = null
            )
        {
            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter startDateParam = new SqlParameter("start_date", startDate.ToString(ReservationCommands.DATE_ISO_FORMAT));
            parameters.Add(startDateParam);
            
            SqlParameter endDateParam = new SqlParameter("end_date", endDate.ToString(ReservationCommands.DATE_ISO_FORMAT));
            parameters.Add(endDateParam);

            if (categoryId != null)
            {
                SqlParameter categoryIdParam = new SqlParameter("category_id", categoryId);
                parameters.Add(categoryIdParam);
            }

            if (client != null)
            {
                SqlParameter categoryParam = new SqlParameter("client_name", client);
                parameters.Add(categoryParam);
            }

            DataSet dataSet = connectionManager.GetProcedureDataSource(ReservationCommands.GET_RESERVATIONS, parameters.ToArray());
            return dataSet;
        }
    }
}
