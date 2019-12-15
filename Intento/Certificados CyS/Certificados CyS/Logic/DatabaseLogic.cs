using Certificados_CyS.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Certificados_CyS.Logic
{
    class DataBaseLogic
    {
        private readonly IConnection connection;
        public DataBaseLogic(IConnection connection) {
            this.connection = connection;
        }

        public void Begin() {
            Exception ex = connection.Connect();
            if (ex != null) Console.WriteLine("Error Connectiong to Database: " + ex.Message);
            else Console.WriteLine("Success Connetion");
        }

        public Item[] GetItems(){
            try { 
                return connection.GetItems();
            } catch(Exception ex) {
                Console.WriteLine(ex);
                return new Item[] { };
            }
        }
    }
}
