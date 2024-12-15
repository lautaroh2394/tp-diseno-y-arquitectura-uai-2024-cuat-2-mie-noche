using BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI.Controles
{
    public partial class DataGridViewWithExport : UserControl
    {
        public event EventHandler CellDoubleClick;

        private string exportName;
        public DataGridViewWithExport()
        {
            InitializeComponent();
            this.dataGridView1.CellDoubleClick += this.dataGridView1_CellDoubleClick;
            this.label1.Visible = false;
        }

        public void SetName(string name)
        {
            this.exportName = name;
        }

        public DataGridView GetDataGridView()
        {
            return this.dataGridView1;
        }

        public void SetSource(DataTable t)
        {
            this.dataGridView1.DataSource = t;
            this.UpdateLabel($"Total: {t.Rows.Count}");
        }

        public void UpdateLabel(string text)
        {
            this.label1.Text = text;
            this.label1.Visible = true;
        }

        public void SetDoubleClickEvent(DataGridViewCellEventHandler callback)
        {
            this.dataGridView1.CellDoubleClick += callback;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DataSet ds =new DataSet();
            ds.Tables.Add(((DataTable) dataGridView1.DataSource).Copy());
            ds.WriteXml(".\\" + this.exportName);
            MessageBox.Show("XML exportado");
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            CellDoubleClick?.Invoke(this, e);
        }
    }
}
