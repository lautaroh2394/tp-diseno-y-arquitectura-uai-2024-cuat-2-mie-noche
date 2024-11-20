using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class SessionManager
    {
        private BE.User currentUser = null;
        private DAL.UsersRepository usersRepository;
        static private SessionManager instance;

        public static SessionManager GetInstance()
        {
            if (SessionManager.instance == null) SessionManager.instance = new SessionManager();
            return SessionManager.instance;
        }

        public static void SetCurrentUser(string username)
        {
            SessionManager.GetInstance().InstanceSetCurrentUser(username);
        }

        public static BE.User GetCurrentUser()
        {
            return SessionManager.GetInstance().InstanceGetCurrentUser();
        }

        public SessionManager()
        {
            usersRepository = new UsersRepository();
        }

        public void InstanceSetCurrentUser(string username)
        {
            currentUser = usersRepository.GetUserByUserName(username);
        }

        public BE.User InstanceGetCurrentUser()
        {
            return currentUser;
        }
    }
}
