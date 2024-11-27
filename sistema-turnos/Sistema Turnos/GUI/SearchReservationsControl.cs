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
using static System.Windows.Forms.AxHost;

namespace GUI
{
    public partial class SearchReservationsControl : UserControl
    {
        private CategoriesRepository categoriesRepository;
        private ReservationsRepository reservationsRepository;

        public SearchReservationsControl()
        {
            InitializeComponent();
            categoriesRepository = new DAL.CategoriesRepository();
            reservationsRepository = new DAL.ReservationsRepository();
            SetComboBoxOptions();
            SetSearchDates();
        }

        private void SetComboBoxOptions()
        {
            DataSet categoriesDs = categoriesRepository.GetCategoriesDataSource();
            DataTable table = categoriesDs.Tables[0];
            DataRow newRow = table.NewRow();
            newRow["id"] = null;
            newRow["show_name"] = "-- Seleccione --";
            table.Rows.InsertAt(newRow, 0);

            reservationCategories.DataSource = table;
            reservationCategories.DisplayMember = "show_name";
            reservationCategories.ValueMember = "id";
        }

        private void SetSearchDates() 
        {
            startDatePicker.Value = DateTime.Now;
            startDatePicker.Text = startDatePicker.Value.ToString();
            startDatePicker.Refresh();

            endDatePicker.Value = DateTime.Now.AddMonths(1);
            endDatePicker.Text = endDatePicker.Value.ToString();
            endDatePicker.Refresh();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DateTime startDate = startDatePicker.Value.Date;
            DateTime endDate = endDatePicker.Value.AddDays(1).Date;
            string client = clientNameText.Text.Length > 0 ? clientNameText.Text : null;
            string categoryId = null;
            if (reservationCategories.SelectedIndex > 0) categoryId = (string) reservationCategories.SelectedValue;
            DataSet foundReservations = reservationsRepository.SearchReservations(
                startDate,
                endDate,
                categoryId,
                client
                );
            DataTable table = foundReservations.Tables[0];
            
            dataGridView1.DataSource = table;
        }
    }
}
