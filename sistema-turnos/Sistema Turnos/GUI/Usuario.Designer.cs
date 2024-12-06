namespace GUI
{
    partial class Usuario
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.checkBoxBusqueda = new System.Windows.Forms.CheckBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.checkBoxReserva = new System.Windows.Forms.CheckBox();
            this.checkBoxCrearUsuario = new System.Windows.Forms.CheckBox();
            this.checkBoxEditarUsuario = new System.Windows.Forms.CheckBox();
            this.checkBoxVerUsuario = new System.Windows.Forms.CheckBox();
            this.button1 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(127, 23);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(100, 20);
            this.textBox1.TabIndex = 0;
            // 
            // textBox2
            // 
            this.textBox2.Location = new System.Drawing.Point(127, 49);
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(100, 20);
            this.textBox2.TabIndex = 1;
            // 
            // checkBoxBusqueda
            // 
            this.checkBoxBusqueda.AutoSize = true;
            this.checkBoxBusqueda.Location = new System.Drawing.Point(52, 16);
            this.checkBoxBusqueda.Name = "checkBoxBusqueda";
            this.checkBoxBusqueda.Size = new System.Drawing.Size(74, 17);
            this.checkBoxBusqueda.TabIndex = 2;
            this.checkBoxBusqueda.Text = "Búsqueda";
            this.checkBoxBusqueda.UseVisualStyleBackColor = true;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.checkBoxVerUsuario);
            this.panel1.Controls.Add(this.checkBoxEditarUsuario);
            this.panel1.Controls.Add(this.checkBoxCrearUsuario);
            this.panel1.Controls.Add(this.checkBoxReserva);
            this.panel1.Controls.Add(this.checkBoxBusqueda);
            this.panel1.Location = new System.Drawing.Point(35, 114);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(192, 162);
            this.panel1.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(41, 98);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(49, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Permisos";
            // 
            // checkBoxReserva
            // 
            this.checkBoxReserva.AutoSize = true;
            this.checkBoxReserva.Location = new System.Drawing.Point(52, 39);
            this.checkBoxReserva.Name = "checkBoxReserva";
            this.checkBoxReserva.Size = new System.Drawing.Size(66, 17);
            this.checkBoxReserva.TabIndex = 3;
            this.checkBoxReserva.Text = "Reserva";
            this.checkBoxReserva.UseVisualStyleBackColor = true;
            // 
            // checkBoxCrearUsuario
            // 
            this.checkBoxCrearUsuario.AutoSize = true;
            this.checkBoxCrearUsuario.Location = new System.Drawing.Point(52, 62);
            this.checkBoxCrearUsuario.Name = "checkBoxCrearUsuario";
            this.checkBoxCrearUsuario.Size = new System.Drawing.Size(88, 17);
            this.checkBoxCrearUsuario.TabIndex = 4;
            this.checkBoxCrearUsuario.Text = "Crear usuario";
            this.checkBoxCrearUsuario.UseVisualStyleBackColor = true;
            // 
            // checkBoxEditarUsuario
            // 
            this.checkBoxEditarUsuario.AutoSize = true;
            this.checkBoxEditarUsuario.Location = new System.Drawing.Point(52, 85);
            this.checkBoxEditarUsuario.Name = "checkBoxEditarUsuario";
            this.checkBoxEditarUsuario.Size = new System.Drawing.Size(90, 17);
            this.checkBoxEditarUsuario.TabIndex = 5;
            this.checkBoxEditarUsuario.Text = "Editar usuario";
            this.checkBoxEditarUsuario.UseVisualStyleBackColor = true;
            // 
            // checkBoxVerUsuario
            // 
            this.checkBoxVerUsuario.AutoSize = true;
            this.checkBoxVerUsuario.Location = new System.Drawing.Point(52, 108);
            this.checkBoxVerUsuario.Name = "checkBoxVerUsuario";
            this.checkBoxVerUsuario.Size = new System.Drawing.Size(79, 17);
            this.checkBoxVerUsuario.TabIndex = 6;
            this.checkBoxVerUsuario.Text = "Ver usuario";
            this.checkBoxVerUsuario.UseVisualStyleBackColor = true;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(127, 299);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 7;
            this.button1.Text = "Actualizar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(67, 26);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(43, 13);
            this.label2.TabIndex = 8;
            this.label2.Text = "Usuario";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(49, 52);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(61, 13);
            this.label3.TabIndex = 9;
            this.label3.Text = "Contraseña";
            // 
            // Usuario
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(267, 347);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.textBox2);
            this.Controls.Add(this.textBox1);
            this.Name = "Usuario";
            this.Text = "Usuario";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.CheckBox checkBoxBusqueda;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.CheckBox checkBoxVerUsuario;
        private System.Windows.Forms.CheckBox checkBoxEditarUsuario;
        private System.Windows.Forms.CheckBox checkBoxCrearUsuario;
        private System.Windows.Forms.CheckBox checkBoxReserva;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
    }
}