using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Certificados_CyS.DataAccess {
    public class Item {
        public string id, nombre, marca, modelo, rango, magnitud, alcanceMax, alcanceMin;
        public double resolucion;
    }
    class Cliente {
        public string NIT, empresa, contacto, cargo, mail, ciudad, direccion, password;
        public long telefono, fax;
    }
    class Administrativo {
        public string nombre, password;
        public long id;
    }
}
