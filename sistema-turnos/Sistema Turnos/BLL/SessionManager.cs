using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SessionManager
    {
        private BE.User currentUser = null;
        private BLL.Users users;
        static private SessionManager instance;

        public static SessionManager GetInstance()
        {
            if (SessionManager.instance == null) SessionManager.instance = new SessionManager();
            return SessionManager.instance;
        }

        public static void SetCurrentUserByUsername(string username)
        {
            SessionManager.GetInstance().InstanceSetCurrentUser(username);
        }

        public static BE.User GetCurrentUser()
        {
            return SessionManager.GetInstance().InstanceGetCurrentUser();
        }

        public SessionManager()
        {
            users = new Users();
        }

        public void InstanceSetCurrentUser(string username)
        {
            currentUser = users.GetUserByUserName(username);
        }

        public BE.User InstanceGetCurrentUser()
        {
            return currentUser;
        }
    }
}
