using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class User
    {
        public long id;
        public string username;
        public List<UserPermission> permissions;

        public User(long id, string username, List<UserPermission> permissions)
        {
            this.id = id;
            this.username = username;
            this.permissions = permissions;
        }
    }

    public class UserPermission
    {
        public string id;
        public string name;
        public string showName;

        public UserPermission(string id, string name, string showName)
        {
            this.id = id;
            this.name = name;
            this.showName = showName;
        }
    }
}
