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
            this.TurnCategory = new System.Windows.Forms.Label();
            this.categoriesSelector1 = new GUI.CategoriesSelector();
            this.dataGridViewWithExport1 = new GUI.Controles.DataGridViewWithExport();
            this.SuspendLayout();
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
            // categoriesSelector1
            // 
            this.categoriesSelector1.Location = new System.Drawing.Point(152, 31);
            this.categoriesSelector1.Name = "categoriesSelector1";
            this.categoriesSelector1.Size = new System.Drawing.Size(135, 21);
            this.categoriesSelector1.TabIndex = 11;
            // 
            // dataGridViewWithExport1
            // 
            this.dataGridViewWithExport1.Location = new System.Drawing.Point(6, 71);
            this.dataGridViewWithExport1.Name = "dataGridViewWithExport1";
            this.dataGridViewWithExport1.Size = new System.Drawing.Size(681, 281);
            this.dataGridViewWithExport1.TabIndex = 12;
            // 
            // NextReservationsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.dataGridViewWithExport1);
            this.Controls.Add(this.categoriesSelector1);
            this.Controls.Add(this.TurnCategory);
            this.Name = "NextReservationsControl";
            this.Size = new System.Drawing.Size(690, 352);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Label TurnCategory;
        private CategoriesSelector categoriesSelector1;
        private Controles.DataGridViewWithExport dataGridViewWithExport1;
    }
}
