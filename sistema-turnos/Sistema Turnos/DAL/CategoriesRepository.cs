using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DAL
{
    public class CategoryCommands
    {
        public static string GET_CATEGORIES = "select id, show_name from categories";
    }

    public class CategoriesRepository : SqlInteractor
    {
        public DataSet GetCategoriesDataSource()
        {
            DataSet dataSet = GetCommandDataSource(CategoryCommands.GET_CATEGORIES);
            return dataSet;
        }
    }
}
