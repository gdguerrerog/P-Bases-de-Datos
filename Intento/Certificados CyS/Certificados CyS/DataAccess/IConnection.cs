using System;
using System.Collections.Generic;
using System.Text;

namespace Proyecto_Bases_de_Datos.DataAccess
{
    interface IConnection
    {
        // Returns null if success connection, else returns the exception
        Exception Connect();
    }
}
