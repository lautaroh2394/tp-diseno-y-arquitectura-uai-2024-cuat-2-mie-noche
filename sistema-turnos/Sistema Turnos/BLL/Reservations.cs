using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
using DAL;
using System.Runtime.InteropServices.ComTypes;
namespace BLL
{
    public class ReservationCommands
    {
        static public string DATE_ISO_FORMAT = "yyyy-MM-dd HH:mm:ss";
        static public string GET_TODAY_RESERVATIONS = "get_today_reservations";
        static public string GET_RESERVATIONS = "get_reservations";
        static public string SUGGEST_RESERVATION = "search_next_available_reservation";
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
    
        public BE.Reservation GetReservationSuggestion(string categoryId, DateTime start_date, DateTime end_date)
        {
            SqlParameter[] parameters = connectionManager.BuildParameters(new object[][]
            {
                new object[] {"category_id", categoryId},
                new object[] {"start_date",  start_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"end_date", end_date.ToString(ReservationCommands.DATE_ISO_FORMAT)}
            });
            SqlCommand command = connectionManager.CreateStoredProcedureCommandWithConnection(ReservationCommands.SUGGEST_RESERVATION, parameters);
            SqlDataReader reader = command.ExecuteReader();
            BE.Reservation suggestion = null;
            if (reader.Read())
            {
                DateTime startDateSuggestion = reader.GetDateTime(0);
                DateTime endDateSuggestion = reader.GetDateTime(1);
                suggestion = new BE.Reservation(-1, startDateSuggestion, endDateSuggestion, categoryId, null, -1);
            }
            reader.Close();
            return suggestion;
        }

        public BE.Reservation Create()
        {
            //todo - crear (llamar proc)
            return new BE.Reservation(0, DateTime.Now, DateTime.Now, "", "", 0);
        }

        public BE.Reservation Update(BE.Reservation reservation)
        {
            //todo - update (llamar proc)
            return new BE.Reservation(0, DateTime.Now, DateTime.Now, "", "", 0);
        }
    }
}
