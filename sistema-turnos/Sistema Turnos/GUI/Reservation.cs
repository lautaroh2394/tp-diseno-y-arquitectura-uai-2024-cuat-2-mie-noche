using BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI
{
    public enum ReservationMode
    {
        Read,
        Edit
    }

    public partial class Reservation : Form
    {
        private BE.Reservation reservation;
        public Reservation(ReservationMode mode, BE.Reservation reservation)
        {
            InitializeComponent();
            this.reservation = reservation;
            if (mode == ReservationMode.Read) Disable();
            SetValues();
        }

        private void Disable()
        {
            dateTimePicker1.Enabled = false;
            dateTimePicker2.Enabled = false;
            dateTimePicker3.Enabled = false;
            textBox2.Enabled = false;
            categoriesSelector1.Disable();
            button1.Hide();

        }

        private void SetValues() 
        {
            dateTimePicker1.Value = reservation.start_date;
            dateTimePicker2.Value = reservation.end_date;
            dateTimePicker3.Value = reservation.start_date.Date;
            textBox2.Text = reservation.client_name.Trim();
            categoriesSelector1.SetSelectedCategoryId(reservation.category_id);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (!Validate()) { MessageBox.Show("valores inválidos"); return; }
            Reservations reservations = new Reservations();
            int fa;
            DateTime startDate = dateTimePicker3.Value.AddMinutes(dateTimePicker1.Value.Minute).AddHours(dateTimePicker1.Value.Hour);
            DateTime endDate = dateTimePicker3.Value.AddMinutes(dateTimePicker2.Value.Minute).AddHours(dateTimePicker2.Value.Hour);
            string categoryId = categoriesSelector1.GetSelectedCategoryId();
            string clientName = textBox2.Text.Trim();

            BE.Reservation updatedReservation = new BE.Reservation(reservation.id, startDate, endDate, categoryId, clientName, reservation.created_by);

            if (!reservations.IsReservationPossible(updatedReservation)) { MessageBox.Show("No se puede crear la reserva: se solapa con otras"); return; };

            try
            {
                 fa = reservations.Update(updatedReservation);
            }
            catch (Exception ex) { fa = 0; }
            if (fa > 0)
            {
                MessageBox.Show("Reserva actualizada");
                this.Close();
            }
            else MessageBox.Show("Hubo un problema al actualizar");
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string url = "http://localhost:8080/reservations/" + reservation.id;
            Process.Start(new ProcessStartInfo(url) { UseShellExecute = true });
        }

        new private bool Validate()
        {
            DateTime startDate = dateTimePicker3.Value.AddMinutes(dateTimePicker1.Value.Minute).AddHours(dateTimePicker1.Value.Hour);
            DateTime endDate = dateTimePicker3.Value.AddMinutes(dateTimePicker2.Value.Minute).AddHours(dateTimePicker2.Value.Hour);

            if (startDate == null || endDate == null || startDate >= endDate) return false;

            string categoryId = categoriesSelector1.GetSelectedCategoryId();
            if (categoryId == null) return false;

            string clientName = textBox2.Text.Trim();
            if (clientName.Length == 0 || clientName == null) return false;
            return true;
        }
    }
}
