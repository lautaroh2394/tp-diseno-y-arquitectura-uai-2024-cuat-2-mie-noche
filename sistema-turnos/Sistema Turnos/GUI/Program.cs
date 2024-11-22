using DAL;
using BE;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Cryptography;
using System.Text;

namespace GUI
{
    internal static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Login formLogin = new Login();
            bool debug = true;
            if (debug) DAL.SessionManager.SetCurrentUserByUsername("admin");
            else formLogin.ShowDialog();

            if (DAL.SessionManager.GetCurrentUser() == null) 
                Application.Exit();
            else Application.Run(new MainMenu());

            SqlConnection dbcn = DAL.DBConnectionManager.CreateSqlConnection();
            dbcn.Open();
            dbcn.Close();
            dbcn.Open();
            dbcn.Close();
            string value = DAL.ConfigManager.GetConfigValue(DAL.ConfigKeys.CONNECTION_STRING);
            Console.WriteLine("Value encontrado:");
            Console.WriteLine(value);
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = value;
            Console.WriteLine("value válido:");
            Console.WriteLine(value.Equals("Server=WINDOWS-J8OE48L\\SQLEXPRESS;Database=master;Trusted_Connection=True;"));
            cn.Open();
            cn.Close();
            Console.WriteLine("exito");
            List<BE.UserPermission> userPermissions = new UsersRepository().GetUserPermissions(87);
            Console.WriteLine($"userPermissions : {userPermissions.Count}, {String.Join(", ", userPermissions.Select(p => p.id))}");

            int sqlScriptReexecutions = 2;
            BE.User user = new UsersRepository().GetUser(127 + (sqlScriptReexecutions * 6));
            Console.WriteLine("username:");
            Console.WriteLine(user.username);
            Console.WriteLine($"permissions: {string.Join(", ",user.permissions.Select(p => p.showName))}");
            List<User> users = new UsersRepository().GetAllUsers();
            Console.WriteLine($"users: {users.Count}");
            bool isValid = Authenticator.Authenticate("buscador", "buscador");
            Console.WriteLine($"isValid: {isValid}");
            isValid = Authenticator.Authenticate("buscador", "no deberia autorizar");
            Console.WriteLine($"isValid: {isValid}");


        }            
    }
}
