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
        private CategoriesRepository categoriesRepository;
        private ReservationsRepository reservationsRepository;
        public NextReservationsControl()
        {
            InitializeComponent();
            categoriesRepository = new DAL.CategoriesRepository();
            reservationsRepository = new DAL.ReservationsRepository();
            SetComboBoxOptions();
        }

        private void SetComboBoxOptions()
        {
            DataSet categoriesDs = categoriesRepository.GetCategoriesDataSource();
            DataTable table = categoriesDs.Tables[0];
            DataRow newRow= table.NewRow();
            newRow["id"] = null;
            newRow["show_name"] = "-- Seleccione --";
            table.Rows.InsertAt(newRow, 0);

            reservationCategories.DataSource = table;
            reservationCategories.DisplayMember = "show_name";
            reservationCategories.ValueMember = "id";
        }

        private void reservationCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (reservationCategories.SelectedIndex != 0)
            {
                string categoryId = (string) reservationCategories.SelectedValue;
                DataTable table = reservationsRepository.GetTodayReservationsDataSet(categoryId).Tables[0];
                dataGridView1.DataSource = table;
                table.Columns["duration"].ColumnName = "Duración";
                table.Columns["start_date"].ColumnName = "Fecha de inicio";
                table.Columns["end_date"].ColumnName = "Fecha de fin";
                table.Columns["client_name"].ColumnName = "Cliente";
                dataGridView1.Columns["id"].Visible = false;
                dataGridView1.Columns["created_by"].Visible = false;

                labelTotal.Visible = true;
                labelTotal.Text = $"Total: {table.Rows.Count}";
            } else labelTotal.Visible = false;
        }
    }
}
