using BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI
{
    public partial class MakeReservationsControl : UserControl
    {
        Reservations reservations;
        public MakeReservationsControl()
        {
            InitializeComponent();
            reservations = new Reservations();
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string categoryId = this.categoriesSelector1.GetSelectedCategoryId();
            DateTime startDate = startDatePicker.Value;
            DateTime endDate = endDatePicker.Value;
            BE.Reservation suggestion = reservations.GetReservationSuggestion(categoryId, startDate, endDate);
            dateTimePicker1.Value = suggestion.start_date;
            dateTimePicker2.Value = suggestion.end_date;
            UpdateSuggestedDuration();
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {
            this.UpdateSuggestedDuration();
        }

        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            this.UpdateSuggestedDuration();
        }

        private void UpdateSuggestedDuration()
        {
            DateTime startDate = dateTimePicker1.Value;
            DateTime endDate = dateTimePicker2.Value;
            if (startDate == null || endDate == null) duration.Text = "";
            else duration.Text = (endDate - startDate).TotalMinutes.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            /*
            BE.Reservation reservation = 
            int fa = reservations.Create(newReservation);
            */
            //new GUI.Reservation(ReservationMode.Read, newReservation).Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DateTime date = dateTimePicker3.Value.Date;
            DateTime startDate = date.AddHours(startDatePicker.Value.Hour);
            startDate = startDate.AddMinutes(startDatePicker.Value.Minute);

            DateTime endDate = date.AddHours(endDatePicker.Value.Hour);
            endDate = endDate.AddMinutes(endDatePicker.Value.Minute);

            BE.Reservation newReservation = new BE.Reservation(0, startDate, endDate, categoriesSelector1.GetSelectedCategoryId(), clientNameText.Text,(int) SessionManager.GetCurrentUser().id);
            bool isPossible = reservations.IsReservationPossible(newReservation);
            if (!isPossible)
            {
                MessageBox.Show("No es posible reservar; se solapa el turno con otras reservas");
                return;
            }
            try
            {
                int id = reservations.Create(newReservation);
                MessageBox.Show("Reserva creada");
                ReservationMode mode = SessionManager.GetCurrentUser().CanEditReservations() ? ReservationMode.Edit : ReservationMode.Read;
                BE.Reservation reservation = reservations.GetReservationById(id);
                new Reservation(mode, reservation).ShowDialog();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo reservar");
            }
        }
    }
}
