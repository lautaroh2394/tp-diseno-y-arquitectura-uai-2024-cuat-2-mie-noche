using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
            this.FormClosed += new FormClosedEventHandler(Login_FormClosed);
        }

        private void buttonLogIn_Click(object sender, EventArgs e)
        {
            if (BLL.Authenticator.Authenticate(inputUser.Text, inputPassword.Text))
            {
                BLL.SessionManager.SetCurrentUserByUsername(inputUser.Text);
                this.Close();
            }
            else
            {
                labelWrongCredentials.Show();
            }
        }

        // TODO - Al apretar X no cierra la aplicación (ahora esto no hace nada porque no se abre desde MainMenu)
        private void Login_FormClosed(object sender, EventArgs e)
        {
            //Application.Exit();
        }

        private void buttonCancel_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
