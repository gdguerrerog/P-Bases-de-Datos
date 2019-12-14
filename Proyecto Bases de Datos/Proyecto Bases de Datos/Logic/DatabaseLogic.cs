using Proyecto_Bases_de_Datos.DataAccess;
using System;
using System.Collections.Generic;
using System.Text;

namespace Proyecto_Bases_de_Datos.Logic
{
    class DatabaseLogic {
        private readonly IConnection connection;
        public DatabaseLogic(IConnection connection) {
            this.connection = connection;
        }
    }
}
