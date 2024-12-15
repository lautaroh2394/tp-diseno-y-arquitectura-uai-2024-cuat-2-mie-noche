using BLL;
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
            this.dataGridViewWithExport1.SetName("SearchReservations");
            this.dataGridViewWithExport1.SetDoubleClickEvent(this.dataGridViewWithExport1_CellDoubleClick);
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
            
            dataGridViewWithExport1.SetSource(table);
        }

        private void dataGridViewWithExport1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                DataTable table = (DataTable)dataGridViewWithExport1.GetDataGridView().DataSource;
                int indexId = table.Columns.IndexOf("id");
                int id = Int32.Parse(dataGridViewWithExport1.GetDataGridView().Rows[e.RowIndex].Cells[indexId].Value.ToString());

                ReservationMode mode = SessionManager.GetCurrentUser().CanEditReservations() ? ReservationMode.Edit : ReservationMode.Read;
                BE.Reservation reservation = reservations.GetReservationById(id);
                new Reservation(mode, reservation).ShowDialog();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception on cell double click", ex.ToString());
            }
        }
    }
}
