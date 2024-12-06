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
            textBox2.Enabled = false;
            categoriesSelector1.Disable();
            button1.Hide();

        }

        private void SetValues() 
        {
            dateTimePicker1.Value = reservation.start_date;
            dateTimePicker2.Value = reservation.end_date;
            textBox2.Text = reservation.client_name;
            categoriesSelector1.SetSelectedCategoryId(reservation.category_id);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Reservations reservations = new Reservations();
            reservations.Update(reservation);
            MessageBox.Show("Reserva actualizada");
            this.Close();
        }
    }
}
