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
            //formLogin.ShowDialog();
            DAL.SessionManager.SetCurrentUser("admin");

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

            BE.User user = new UsersRepository().GetUser(87);
            Console.WriteLine("username:");
            Console.WriteLine(user.username);
            List<User> users = new UsersRepository().GetAllUsers();
            Console.WriteLine($"users: {users.Count}");
            bool isValid = Authenticator.Authenticate("buscador", "buscador");
            Console.WriteLine($"isValid: {isValid}");
            isValid = Authenticator.Authenticate("buscador", "no deberia autorizar");
            Console.WriteLine($"isValid: {isValid}");


        }            
    }
}
