﻿using BLL;
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
    public partial class AdminControl : UserControl
    {
        private DataTable table;
        private Users users;
        public AdminControl()
        {
            InitializeComponent();
            this.dataGridView1.CellDoubleClick += this.dataGridView1_CellContentClick;
            users = new Users();
            if (!SessionManager.GetCurrentUser().CanSeeUsers()) {
                this.button2.Hide();
                this.dataGridView1.Hide();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            new Usuario(UsuarioMode.Write, null).ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DataSet ds = users.GetAllUsersDataSource();
            table = ds.Tables[0];
            dataGridView1.DataSource = table;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = Int32.Parse(dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString());
            BE.User user = users.GetUser(id);
            UsuarioMode mode = SessionManager.GetCurrentUser().CanEditUsers() ? UsuarioMode.Write : UsuarioMode.Read;
            new Usuario(mode, user).ShowDialog();
        }
    }
}
