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
            this.dataGridViewWithExport1.SetName("NextReservations");
            this.dataGridViewWithExport1.SetDoubleClickEvent(this.dataGridViewWithExport1_CellDoubleClick);
        }

        private void categoriesSelector1_CategoryChange(object sender, EventArgs e)
        {
            string categoryId = (string)categoriesSelector1.GetSelectedCategoryId();
            DataTable table = reservations.GetTodayReservationsDataSet(categoryId).Tables[0];
            table.Columns["duration"].ColumnName = "Duración";
            table.Columns["start_date"].ColumnName = "Fecha de inicio";
            table.Columns["end_date"].ColumnName = "Fecha de fin";
            table.Columns["client_name"].ColumnName = "Cliente";

            dataGridViewWithExport1.SetSource(table);
            dataGridViewWithExport1.GetDataGridView().Columns["id"].Visible = false;
            dataGridViewWithExport1.GetDataGridView().Columns["created_by"].Visible = false;
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
