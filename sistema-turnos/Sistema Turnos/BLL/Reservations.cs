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
        static public string CREATE_RESERVATION = "create_reservation";
        static public string GET_RESERVATION = "get_reservation";
        static public string UPDATE_RESERVATION = "update_reservation";
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
                parameters = connectionManager.BuildParameters(new object[][] { new object[] { "category_id", categoryId } });
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

        public int Create(BE.Reservation reservation)
        {
	
	        SqlParameter[] parameters = connectionManager.BuildParameters(new object[][]
            {
                new object[] {"category_id", reservation.category_id},
                new object[] {"start_date",  reservation.start_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"end_date",  reservation.end_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"client_name", reservation.client_name},
                new object[] {"user_id", SessionManager.GetCurrentUser().id},
            });
            
            SqlCommand command = this.connectionManager.CreateStoredProcedureCommandWithConnection(ReservationCommands.CREATE_RESERVATION, parameters);
            SqlParameter outputParam = new SqlParameter("id", SqlDbType.BigInt)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);
            command.Connection.Open();
            int fa = command.ExecuteNonQuery();
            command.Connection.Close();
            int reservationId = Int32.Parse(outputParam.Value.ToString());
            return reservationId;
        }

        public int Update(BE.Reservation reservation)
        {
            SqlParameter[] parameters = connectionManager.BuildParameters(new object[][]
            {
                new object[] {"id", reservation.id},
                new object[] {"category_id", reservation.category_id},
                new object[] {"start_date",  reservation.start_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"end_date",  reservation.end_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"client_name", reservation.client_name.Trim()},
                new object[] {"user_id", SessionManager.GetCurrentUser().id},
            });

            SqlCommand command = this.connectionManager.CreateStoredProcedureCommandWithConnection(ReservationCommands.UPDATE_RESERVATION, parameters);
            
            command.Connection.Open();
            int fa = command.ExecuteNonQuery();
            command.Connection.Close();
            
            return fa;
        }

        public bool IsReservationPossible(BE.Reservation reservation)
        {
            SqlParameter[] parameters = connectionManager.BuildParameters(new object[][]
            {
                new object[] {"start_date",  reservation.start_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"end_date",  reservation.end_date.ToString(ReservationCommands.DATE_ISO_FORMAT)},
                new object[] {"category_id", reservation.category_id},
            });
            SqlCommand command = this.connectionManager.CreateSqlCommandWithConnection("select dbo.do_overlapping_reservations_exist(@start_date,@end_date,@category_id)", parameters);
            command.Connection.Open();
            bool matchExists = false;
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    matchExists = reader.GetBoolean(0);
                }

            } catch (Exception ex)
            {
                Console.WriteLine("Exception on IsReservationPosible", ex.ToString());
            }
            reader.Close();
            return !matchExists;
        }

        public BE.Reservation GetReservationById(int id) 
        {
            SqlParameter[] parameters = connectionManager.BuildParameters(new object[][]
            {
                new object[] {"id", id},
            });

            SqlCommand command = this.connectionManager.CreateStoredProcedureCommandWithConnection(ReservationCommands.GET_RESERVATION, parameters);
            SqlParameter outputParamDuration = new SqlParameter("duration", SqlDbType.Int) { Direction = ParameterDirection.Output };
            SqlParameter outputParamStartDate = new SqlParameter("start_date", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
            SqlParameter outputParamEndDate = new SqlParameter("end_date", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
            SqlParameter outputParamCategoryId = new SqlParameter("category_id", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
            SqlParameter outputParamClientName = new SqlParameter("client_name", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
            SqlParameter outputParamCreatedBy = new SqlParameter("created_by", SqlDbType.NVarChar, 50) { Direction = ParameterDirection.Output };
            
            command.Parameters.Add(outputParamDuration);
            command.Parameters.Add(outputParamStartDate);
            command.Parameters.Add(outputParamEndDate);
            command.Parameters.Add(outputParamCategoryId);
            command.Parameters.Add(outputParamClientName);
            command.Parameters.Add(outputParamCreatedBy);

            command.Connection.Open();

            int fa = command.ExecuteNonQuery();
            command.Connection.Close();
            BE.Reservation reservation = new BE.Reservation(
                id,
                DateTime.Parse(outputParamStartDate.Value.ToString()),
                DateTime.Parse(outputParamEndDate.Value.ToString()),
                outputParamCategoryId.Value.ToString(),
                outputParamClientName.Value.ToString(),
                Int32.Parse(outputParamCreatedBy.Value.ToString())
                );
            return reservation;
        }
    }
}
