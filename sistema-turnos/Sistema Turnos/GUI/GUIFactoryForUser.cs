using BE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace GUI
{
    public class GUICreatorForUser
    {
        static public object[][] TAB_BUILDERS = {
            new object[] { "BUSQUEDA", new NextReservationsTabBuilder() }
            /*
            "RESERVA",
            "CREAR_USUARIO",
            "EDITAR_USUARIO",
            "VER_USUARIOS",
            "ADMIN"
            */
        };

        public TabControl CreateForUser(BE.User user)
        {
            TabPage[] tabPages = BuildTabPages(user).ToArray();
            TabControl tabControl = new TabControl();
            tabControl.Dock = DockStyle.Fill;
            tabControl.TabPages.AddRange(tabPages);

            return tabControl;
        }

        private List<TabPage> BuildTabPages(BE.User user)
        {
            List<TabPage> tabPages = new List<TabPage>();

            foreach (object[] TabBuilder in TAB_BUILDERS)
            {
                TabPageBuilder builder = (TabPageBuilder) TabBuilder[1];
                if (builder.ShouldBuild(user))
                {
                    TabPage control = builder.build(user);
                    tabPages.Add(control);
                }
            }
            return tabPages;
        }
    }

    internal abstract class TabPageBuilder
    {
        protected string[] NeededPermissions;
        protected string UsePermissionShowName;
        protected abstract UserControl BuildControl();

        public TabPage build(BE.User user)
        {
            string showName = GetTabShowName(user);
            TabPage newTabPage = new TabPage(showName);
            Control built = this.BuildControl();
            newTabPage.Controls.Add(built);
            return newTabPage;
        }

        public bool ShouldBuild(BE.User user)
        {
            return NeededPermissions.All(p => user.permissions.Any((BE.UserPermission up) => up.name.Equals(p)));
        }

        protected string GetTabShowName(BE.User user)
        {
            return user.permissions.Find(
                up => up.name.Equals(
                    UsePermissionShowName
                    )).showName;
        }
    }

    internal class NextReservationsTabBuilder
    {
        protected string[] NeededPermissions = { "BUSQUEDA" };
        protected string UsePermissionShowName = "BUSQUEDA";

        protected UserControl BuildControl() 
        {
            return new UserControl();
        }

    }
}
