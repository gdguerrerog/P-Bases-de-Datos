using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Certificados_CyS.DataAccess
{
    interface IConnection
    {
        // Returns null if success connection, else returns the exception
        Exception Connect();
        Exception Close();
        bool IsOpen();
        Item[] GetItems();
    }
}
