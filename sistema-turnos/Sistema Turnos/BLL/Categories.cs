using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DAL;

namespace BLL
{
    public class CategoryCommands
    {
        public static string GET_CATEGORIES = "select id, show_name from categories";
    }

    public class Categories
    {
        DBConnectionManager connectionManager;

        public Categories()
        {
            connectionManager = new DBConnectionManager();
        }

        public DataSet GetCategoriesDataSource()
        {
            DataSet dataSet = connectionManager.GetCommandDataSource(CategoryCommands.GET_CATEGORIES);
            return dataSet;
        }
    }
}
