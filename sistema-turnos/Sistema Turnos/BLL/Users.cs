using BE;
using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class UserCommands
    {
        public static string GET_USER_PERMISSIONS = "get_user_permissions";
        public static string GET_USER_BY_ID = "SELECT TOP 1 * from users_view where id = @id";
        public static string GET_USER_PERMISSIONS_BY_USERNAME = "SELECT TOP 1 * from users_view where username = @username";
        public static string GET_ALL_USERS_FROM_VIEW = "SELECT * from users_view";
    }

    public class Users
    {
        DBConnectionManager connectionManager;
        public Users() 
        {
            this.connectionManager = new DBConnectionManager();
        }
        public BE.User GetUser(int id)
        {
            BE.User User = null;

            object[][] parametersData = new object[][] { new object[] { "id", id } };
            SqlParameter[] parameters = this.connectionManager.BuildParameters(parametersData);    
            SqlCommand GetUsersCommand = this.connectionManager.CreateSqlCommand(UserCommands.GET_USER_BY_ID, parameters);

            using (SqlConnection Connection = DBConnectionManager.CreateSqlConnection())
            {
                GetUsersCommand.Connection = Connection;
                Connection.Open();
                try
                {
                    SqlDataReader Reader = GetUsersCommand.ExecuteReader();
                    if (!Reader.HasRows) return null;
                    if (Reader.Read()) 
                    {
                        User = MapUser(Reader);
                    }
                }
                catch (Exception ex) { 
                    Console.WriteLine("Exception thrown", ex.Message);
                    throw ex;
                }
            }
            return User;
        }

        public BE.User GetUserByUserName(string username)
        {
            BE.User User = null;
            object[][] parametersData = new object[][] { new object[] { "username", username} };
            SqlParameter[] parameters = this.connectionManager.BuildParameters(parametersData);
            SqlCommand GetUsersCommand = this.connectionManager.CreateSqlCommand(UserCommands.GET_USER_PERMISSIONS_BY_USERNAME, parameters);

            using (SqlConnection Connection = DBConnectionManager.CreateSqlConnection())
            {
                GetUsersCommand.Connection = Connection;
                Connection.Open();
                try
                {
                    SqlDataReader Reader = GetUsersCommand.ExecuteReader();
                    if (!Reader.HasRows) return null;
                    if (Reader.Read())
                    {
                        User = MapUser(Reader);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception thrown", ex.Message);
                    throw ex;
                }
            }
            return User;
        }

        public List<BE.User> GetAllUsers()
        {
            List<BE.User> Users = new List<BE.User>();
            SqlCommand GetUsersCommand = this.connectionManager.CreateSqlCommand(UserCommands.GET_ALL_USERS_FROM_VIEW);

            using (SqlConnection Connection = DBConnectionManager.CreateSqlConnection())
            {
                GetUsersCommand.Connection = Connection;
                Connection.Open();
                try
                {
                    SqlDataReader Reader = GetUsersCommand.ExecuteReader();
                    while (Reader.Read())
                    {
                        BE.User user = MapUser(Reader);
                        Users.Add(user);
                    }

                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception thrown", ex.Message);
                    throw ex;
                }
            }
            return Users;
        }

        public DataSet GetAllUsersDataSource()
        {
            List<BE.User> Users = new List<BE.User>();
            DataSet ds = this.connectionManager.GetCommandDataSource(UserCommands.GET_ALL_USERS_FROM_VIEW);
            return ds;
        }

        public void CreateUser(User user)
        {
            // proc
        }

        public void UpdateUser(User user)
        {
            // proc
        }

        public List<BE.UserPermission> GetUserPermissions(long id)
        {
            List<BE.User> Users = new List<BE.User>();
            SqlParameter[] parameters = new SqlParameter[1];
            parameters[0] = new SqlParameter("@userId", id);
            SqlCommand GetUserPermissionsCommand = this.connectionManager.CreateStoredProcedureCommand(UserCommands.GET_USER_PERMISSIONS, parameters);

            List<BE.UserPermission> permissions = new List<BE.UserPermission>();
            using (SqlConnection Connection = DBConnectionManager.CreateSqlConnection())
            {
                GetUserPermissionsCommand.Connection = Connection;
                Connection.Open();
                try
                {
                    SqlDataReader Reader = GetUserPermissionsCommand.ExecuteReader();
                    while (Reader.Read())
                    {
                        permissions.Add(MapPermission(Reader));
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception thrown", ex.Message);
                    throw ex;
                }
            }
            return permissions;
        }

        public void AuthUser(string username, string password)
        {

        }

        private BE.User MapUser(SqlDataReader Reader)
        {
            long userId = Reader.GetInt64(Reader.GetOrdinal("id"));
            string username = Reader.GetString(Reader.GetOrdinal("username"));
            List<BE.UserPermission> permissions = GetUserPermissions(userId);
            return new BE.User(userId, username, permissions);
        }

        private BE.UserPermission MapPermission(SqlDataReader Reader)
        {
            string permissionId = Reader.GetString(Reader.GetOrdinal("id"));
            string permissionName = Reader.GetString(Reader.GetOrdinal("name"));
            string permissionShowName = Reader.GetString(Reader.GetOrdinal("show_name"));

            return new BE.UserPermission(permissionId, permissionName, permissionShowName);
        }
    }
}
