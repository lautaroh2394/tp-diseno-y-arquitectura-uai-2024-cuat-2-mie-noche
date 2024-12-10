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
        private object[] tabBuilders = {
            typeof(NextReservationsTabBuilder),
            typeof(SearchReservationsTabBuilder),
            typeof(MakeReservationsTabBuilder),
            typeof(AdminTabBuilder),
            typeof(ProfileTabBuilder),
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

            foreach (object tabBuilder in tabBuilders)
            {
                Type BuilderClass = (Type)tabBuilder;
                TabPageBuilder builder = (TabPageBuilder)Activator.CreateInstance(BuilderClass);
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
        protected string[] neededPermissions;
        protected string tabName;
        protected abstract UserControl BuildControl();

        public TabPage build(BE.User user)
        {
            TabPage newTabPage = new TabPage(tabName);
            UserControl built = this.BuildControl();
            newTabPage.Controls.Add(built);
            return newTabPage;
        }

        public bool ShouldBuild(BE.User user)
        {
            return neededPermissions.Count() == 0 || neededPermissions.All(p => user.HasPermissionById(p));
        }
    }

    internal class NextReservationsTabBuilder : TabPageBuilder
    {
        public NextReservationsTabBuilder()
        {
            neededPermissions = new string[] { "BUSQUEDA" };
            tabName = "Turnos del día";
        }

        protected override UserControl BuildControl()
        {
            return new NextReservationsControl();
        }
    }

    internal class SearchReservationsTabBuilder : TabPageBuilder
    {
        public SearchReservationsTabBuilder()
        {
            neededPermissions = new string[] { "BUSQUEDA" };
            tabName = "Buscar reservas";
        }

        protected override UserControl BuildControl()
        {
            return new SearchReservationsControl();
        }
    }

    internal class MakeReservationsTabBuilder : TabPageBuilder
    {
        public MakeReservationsTabBuilder()
        {
            neededPermissions = new string[] { "RESERVA" };
            tabName = "Crear reservas";
        }

        protected override UserControl BuildControl()
        {
            return new MakeReservationsControl();
        }
    }

    internal class AdminTabBuilder : TabPageBuilder
    {
        public AdminTabBuilder()
        {
            neededPermissions = new string[] { "ADMIN" };
            tabName = "Admin";
        }

        protected override UserControl BuildControl()
        {
            return new AdminControl();
        }
    }

    internal class ProfileTabBuilder : TabPageBuilder
    {
        public ProfileTabBuilder()
        {
            neededPermissions = new string[0];
            tabName = "Mi perfil";
        }

        protected override UserControl BuildControl()
        {
            return new ProfileControl();
        }
    }
}
