using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Security.Cryptography;
namespace DAL
{
    public class ReservationCommands
    {
        static public string DATE_ISO_FORMAT = "yyyy-MM-dd HH:mm:ss";
        static public string GET_TODAY_RESERVATIONS = "get_today_reservations";
        static public string GET_RESERVATIONS = "get_reservations";
    }
    public class ReservationsRepository : SqlInteractor
    {
        public DataSet GetTodayReservationsDataSet(string categoryId)
        {
            SqlParameter[] parameters = BuildParameters(new object[][] { new object[] { "category_id", categoryId } });
            // TODO: Mejorar las columnas que se devuelven
            DataSet dataSet = GetProcedureDataSource(ReservationCommands.GET_TODAY_RESERVATIONS, parameters);
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

            DataSet dataSet = GetProcedureDataSource(ReservationCommands.GET_RESERVATIONS, parameters.ToArray());
            return dataSet;
        }
    }
}
