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
    public partial class CategoriesSelector : UserControl
    {
        public event EventHandler CategoryChange;

        public CategoriesSelector()
        {
            InitializeComponent();
            SetCategoriesOptions();
            comboBox1.SelectedIndex = 0;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);

        }

        private void SetCategoriesOptions() 
        {
            DataSet categoriesDs = new Categories().GetCategoriesDataSource();
            DataTable table = categoriesDs.Tables[0];
            DataRow newRow = table.NewRow();
            newRow["id"] = null;
            newRow["show_name"] = "-- Seleccione --";
            table.Rows.InsertAt(newRow, 0);

            comboBox1.DataSource = table;
            comboBox1.DisplayMember = "show_name";
            comboBox1.ValueMember = "id";
        }

        public string GetSelectedCategoryId()
        {
            if (comboBox1.SelectedIndex == 0) return null;
            return (string) comboBox1.SelectedValue;
        }

        public int GetSelectedIndex() 
        {
            return comboBox1.SelectedIndex;
        }
        
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            CategoryChange?.Invoke(this, EventArgs.Empty);
        }
    }
}
