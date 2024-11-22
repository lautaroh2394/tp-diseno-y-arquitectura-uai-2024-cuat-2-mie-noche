using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using BE;
using System.Security.Cryptography;
using System.Reflection;

namespace DAL
{
    public class AuthenticatorCommands 
    {
        public static string AUTHENTICATE_USER = "authenticate_user";
    }
    public class Authenticator : SqlInteractor
    {
        static public Authenticator instance;
        public static bool Authenticate(string name, string password) {
            return Authenticator.GetInstance().InstanceAuthenticate(name, password);
        }

        public static Authenticator GetInstance()
        {
            if (Authenticator.instance == null) { Authenticator.instance = new Authenticator(); } 
            return Authenticator.instance;
        }

        public bool InstanceAuthenticate(string name, string password)
        {
            SqlParameter[] parameters = { new SqlParameter("username", name), new SqlParameter("hashedPassword", HashPassword(password)) };
            SqlCommand AuthenticateUserCommand = CreateStoredProcedureCommand(AuthenticatorCommands.AUTHENTICATE_USER, parameters);

            bool isValid = false;
            using (SqlConnection connection = DBConnectionManager.CreateSqlConnection())
            {
                AuthenticateUserCommand.Connection = connection;
                connection.Open();
                try
                {
                    isValid = (bool) AuthenticateUserCommand.ExecuteScalar();
                }
                catch (Exception ex) 
                {
                    Console.WriteLine("Exception thrown", ex.Message);
                    return false;
                }

            }
            return isValid;
        }

        private string HashPassword(string password)
        {
            string hashedPassword;
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                hashedPassword = builder.ToString();
            }
            return hashedPassword;
        }
    }
}
