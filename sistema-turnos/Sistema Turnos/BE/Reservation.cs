using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BE
{
    public class Reservation
    {
        public int duration;
        public DateTime start_date;
        public DateTime end_date;
        public string category_id;
        public string client_name;
        public int id;
        public int created_by;

        public Reservation(int id, DateTime start_date, DateTime end_date, string category_id, string client_name, int created_by) 
        {
            this.id = id;
            this.start_date = start_date;
            this.end_date = end_date;
            this.category_id = category_id;
            this.client_name = client_name;
            this.created_by = created_by;
        }
    }
}
