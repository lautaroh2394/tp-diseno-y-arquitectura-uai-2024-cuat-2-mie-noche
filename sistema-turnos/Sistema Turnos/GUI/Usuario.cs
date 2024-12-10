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
            InitializeUsuarioControl(mode, usuario);
            usuarioControl1.CloseEvent += this.CloseEvent;
        }

        private void InitializeUsuarioControl(UsuarioMode mode, BE.User usuario = null)
        {
            this.usuarioControl1 = new GUI.UsuarioControl(mode, usuario);
            this.usuarioControl1.Location = new System.Drawing.Point(48, 4);
            this.usuarioControl1.Name = "usuarioControl1";
            this.usuarioControl1.Size = new System.Drawing.Size(205, 339);
            this.usuarioControl1.TabIndex = 10;
            this.Controls.Add(this.usuarioControl1);
        }

        private void CloseEvent(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
