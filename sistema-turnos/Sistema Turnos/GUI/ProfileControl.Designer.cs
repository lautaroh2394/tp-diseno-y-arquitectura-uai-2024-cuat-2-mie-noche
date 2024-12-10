namespace GUI
{
    partial class ProfileControl
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
            this.usuarioControl2 = new GUI.UsuarioControl();
            this.SuspendLayout();
            // 
            // usuarioControl2
            // 
            this.usuarioControl2.Location = new System.Drawing.Point(0, 0);
            this.usuarioControl2.Name = "usuarioControl2";
            this.usuarioControl2.Size = new System.Drawing.Size(205, 339);
            this.usuarioControl2.TabIndex = 0;
            // 
            // ProfileControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.usuarioControl2);
            this.Name = "ProfileControl";
            this.Size = new System.Drawing.Size(219, 350);
            this.ResumeLayout(false);

        }

        #endregion

        private UsuarioControl usuarioControl2;
    }
}
