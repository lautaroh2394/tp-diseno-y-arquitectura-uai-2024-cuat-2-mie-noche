using BLL;
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
    public partial class UsuarioControl : UserControl
    {
        public event EventHandler CloseEvent;

        private BE.User usuario;
        private object[][] permissionBoxes;
        private UsuarioMode mode;

        public UsuarioControl() : this(UsuarioMode.Write, SessionManager.GetCurrentUser()) { }

        public UsuarioControl(UsuarioMode mode, BE.User usuario = null)
        {
            InitializeComponent();
            this.usuario = usuario;
            this.permissionBoxes = new object[][]{
                new object[] {"BUSQUEDA", this.checkBoxBusqueda },
                new object[] {"RESERVA", this.checkBoxReserva },
                new object[] {"CREAR_USUARIO", this.checkBoxCrearUsuario },
                new object[] {"EDITAR_USUARIO", this.checkBoxEditarUsuario },
                new object[] {"VER_USUARIOS", this.checkBoxVerUsuario },
                new object[] {"ADMIN", this.checkBoxAdmin}
            };
            this.mode = mode;
            if (mode == UsuarioMode.Read) Disable();
            if (mode == UsuarioMode.Write && !SessionManager.GetCurrentUser().CanEditUsers()) DisablePermissions();
            SetValues();
            SetEvents();
        }

        private void Disable()
        {
            textBox1.Enabled = false;
            textBox2.Enabled = false;

            foreach (var item in this.permissionBoxes)
            {
                CheckBox checkbox = (CheckBox)item[1];
                checkbox.Enabled = false;
            }

            button1.Hide();
        }

        private void DisablePermissions()
        {
            foreach (var item in this.permissionBoxes)
            {
                CheckBox checkbox = (CheckBox)item[1];
                checkbox.Enabled = false;
            }
        }

        private void SetValues()
        {
            if (this.usuario == null) 
            {
                button1.Text = "Crear usuario";
                return;
            };

            textBox1.Text = usuario.username;

            foreach (var item in permissionBoxes)
            {
                string permission = (string)item[0];
                CheckBox checkbox = (CheckBox)item[1];
                if (usuario.HasPermissionById(permission)) { checkbox.Checked = true; };
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            bool isNewUser = usuario == null;
            BE.User u;
            if (!this.Validate()) return;
            
            List<BE.UserPermission> permissions = new List<BE.UserPermission>();
            IEnumerable<BE.UserPermission> mappedPermissions = (
                permissionBoxes
                    .Where(p => ((CheckBox)p[1]).Checked)
                    .Select(p => new BE.UserPermission((string)p[0], (string)p[0], (string)p[0]))
            );
            foreach (BE.UserPermission permission in mappedPermissions) {permissions.Add(permission);}

            string password = textBox2.Text.Length > 0 ? Authenticator.GetInstance().HashPassword(textBox2.Text) : null;
            string username = textBox1.Text;

            if (isNewUser)
            {
                u = new BE.User(0, username, permissions, password);
                int fa = new BLL.Users().CreateUser(u);
                if (fa == 0) { MessageBox.Show("No se pudo actualizar"); return; }
                MessageBox.Show("Usuario creado");
            }
            else
            {
                u = new BE.User(usuario.id, username, permissions, password);
                int fa = new BLL.Users().UpdateUser(u);
                if (fa == 0) { MessageBox.Show("No se pudo actualizar"); return; }
                MessageBox.Show("Usuario actualizado");
            }
            this.Close();
        }

        private void Close()
        {
            CloseEvent?.Invoke(this, EventArgs.Empty);
        }

        private void SetEvents()
        {
            button1.Click += button1_Click;
        }

        private new bool Validate()
        {
            bool textEmpty = textBox1.Text.Length == 0;
            if (textEmpty) 
            {
                MessageBox.Show("Nombre de usuario inválido");
                return false;
            }

            bool passwordEmpty = usuario== null && textBox2.Text.Length == 0;
            if (passwordEmpty) {
                MessageBox.Show("Contraseña inválida");
                return false;
            }

            bool atLeastOnePermissionSelected = permissionBoxes.Where(p => ((CheckBox)p[1]).Checked).Count() > 0;
            if (!atLeastOnePermissionSelected) {
                MessageBox.Show("Al menos un permiso debe ser seleccionado");
                return false;
            }
            return true;
        }
    }
}
