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
        private BLL.Categories categories;
        private BLL.Reservations reservations;

        public SearchReservationsControl()
        {
            InitializeComponent();
            categories = new BLL.Categories();
            reservations = new BLL.Reservations();
            SetSearchDates();
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
            string categoryId = categoriesSelector1.GetSelectedCategoryId();
            DataSet foundReservations = reservations.SearchReservations(
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
