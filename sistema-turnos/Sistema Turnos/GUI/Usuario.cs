using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace GUI
{
    public enum UsuarioMode
    {
        Read, Write
    }
    public partial class Usuario : Form
    {
        private BE.User usuario;
        private object[][] permissionBoxes;
        public Usuario(UsuarioMode mode, BE.User usuario = null)
        {
            InitializeComponent();
            this.usuario = usuario;
            this.permissionBoxes = new object[][]{
                new object[] {"BUSQUEDA", this.checkBoxBusqueda },
                new object[] {"RESERVA", this.checkBoxReserva },
                new object[] {"CREAR_USUARIO", this.checkBoxCrearUsuario },
                new object[] {"EDITAR_USUARIO", this.checkBoxEditarUsuario },
                new object[] {"VER_USUARIO", this.checkBoxVerUsuario }
            };
            if (mode == UsuarioMode.Read) Disable();
            SetValues();
        }

        private void Disable()
        {
            textBox1.Enabled = false;
            textBox2.Enabled = false;

            foreach (var item in this.permissionBoxes)
            {
                CheckBox checkbox = (CheckBox) item[1];
                checkbox.Enabled = false;
            }

            button1.Hide();
        }

        private void SetValues()
        {
            if (this.usuario == null) return;

            textBox1.Text = usuario.username;

            foreach (var item in permissionBoxes)
            {
                string permission = (string) item[0];
                CheckBox checkbox = (CheckBox) item[1];
                if (usuario.HasPermissionById(permission)) { checkbox.Checked = true; };
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            new BLL.Users().UpdateUser(usuario);
            MessageBox.Show("Usuario actualizado");
            this.Close();
        }
    }
}
