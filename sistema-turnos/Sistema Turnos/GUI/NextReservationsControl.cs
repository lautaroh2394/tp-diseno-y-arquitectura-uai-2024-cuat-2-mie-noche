using DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace GUI
{
    public partial class NextReservationsControl : UserControl
    {
        private BLL.Categories categories;
        private BLL.Reservations reservations;
        public NextReservationsControl()
        {
            InitializeComponent();
            categories = new BLL.Categories();
            reservations = new BLL.Reservations();
            categoriesSelector1.CategoryChange += categoriesSelector1_CategoryChange;
        }

        private void categoriesSelector1_CategoryChange(object sender, EventArgs e)
        {
            string categoryId = (string)categoriesSelector1.GetSelectedCategoryId();
            DataTable table = reservations.GetTodayReservationsDataSet(categoryId).Tables[0];
            dataGridView1.DataSource = table;
            table.Columns["duration"].ColumnName = "Duración";
            table.Columns["start_date"].ColumnName = "Fecha de inicio";
            table.Columns["end_date"].ColumnName = "Fecha de fin";
            table.Columns["client_name"].ColumnName = "Cliente";
            dataGridView1.Columns["id"].Visible = false;
            dataGridView1.Columns["created_by"].Visible = false;

            labelTotal.Visible = true;
            labelTotal.Text = $"Total: {table.Rows.Count}";
        }
    }
}
