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

namespace GUI
{
    public partial class MainMenu : Form
    {
        public MainMenu()
        {
            InitializeComponent();

            TabControl tabControl = (new GUICreatorForUser()).CreateForUser(SessionManager.GetCurrentUser());
            this.Controls.Add(tabControl);
        }
    }
}
