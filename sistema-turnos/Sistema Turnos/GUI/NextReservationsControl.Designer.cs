namespace GUI
{
    partial class NextReservationsControl
    {
        /// <summary> 
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de componentes

        /// <summary> 
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.TurnCategory = new System.Windows.Forms.Label();
            this.labelTotal = new System.Windows.Forms.Label();
            this.categoriesSelector1 = new GUI.CategoriesSelector();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(3, 72);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(684, 221);
            this.dataGridView1.TabIndex = 7;
            // 
            // TurnCategory
            // 
            this.TurnCategory.AutoSize = true;
            this.TurnCategory.Cursor = System.Windows.Forms.Cursors.Default;
            this.TurnCategory.Location = new System.Drawing.Point(17, 34);
            this.TurnCategory.Name = "TurnCategory";
            this.TurnCategory.Size = new System.Drawing.Size(70, 13);
            this.TurnCategory.TabIndex = 9;
            this.TurnCategory.Text = "Tipo de turno";
            // 
            // labelTotal
            // 
            this.labelTotal.AutoSize = true;
            this.labelTotal.Location = new System.Drawing.Point(640, 296);
            this.labelTotal.Name = "labelTotal";
            this.labelTotal.Size = new System.Drawing.Size(47, 13);
            this.labelTotal.TabIndex = 10;
            this.labelTotal.Text = "asdfasdf";
            this.labelTotal.Visible = false;
            // 
            // categoriesSelector1
            // 
            this.categoriesSelector1.Location = new System.Drawing.Point(152, 31);
            this.categoriesSelector1.Name = "categoriesSelector1";
            this.categoriesSelector1.Size = new System.Drawing.Size(135, 21);
            this.categoriesSelector1.TabIndex = 11;
            // 
            // NextReservationsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.categoriesSelector1);
            this.Controls.Add(this.labelTotal);
            this.Controls.Add(this.TurnCategory);
            this.Controls.Add(this.dataGridView1);
            this.Name = "NextReservationsControl";
            this.Size = new System.Drawing.Size(690, 311);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Label TurnCategory;
        private System.Windows.Forms.Label labelTotal;
        private CategoriesSelector categoriesSelector1;
    }
}
