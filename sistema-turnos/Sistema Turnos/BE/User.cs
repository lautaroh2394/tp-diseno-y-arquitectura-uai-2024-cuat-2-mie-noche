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
        public string password;
        public List<UserPermission> permissions;

        public User(long id, string username, List<UserPermission> permissions, string password = null)
        {
            this.id = id;
            this.username = username;
            this.permissions = permissions;
            this.password = password;
        }

        public bool HasPermissionById(string permission) 
        {
            return this.permissions.Any(p => p.id.Equals(permission));
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
