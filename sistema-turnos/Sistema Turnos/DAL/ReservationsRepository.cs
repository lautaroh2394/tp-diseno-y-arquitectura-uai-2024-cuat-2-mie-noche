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
        static public string GET_TODAY_RESERVATIONS = "get_today_reservations";
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
    }
}
