using Certificados_CyS.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Certificados_CyS.Logic
{

    enum UserType {
        CLIENTE, LABORATORISTA, ASESOR, GERENTE
    }
    class LogInResult {
        public readonly bool ok;
        public readonly UserType? userType;
        public readonly Cliente cliente;
        public readonly Administrativo administrativo;
        public LogInResult(bool ok, UserType? userType, Cliente cliente, Administrativo administrativo) {
            this.ok = ok; this.userType = userType; this.cliente = cliente; this.administrativo = administrativo;
        }
    }

    class DataBaseLogic
    {
        private readonly IConnection database;
        public DataBaseLogic(IConnection database) {
            this.database = database; 
        }

        public void Begin() {
            Exception ex = database.Connect();
            if (ex != null) Console.WriteLine("Error Connectiong to Database: " + ex.Message);
            else Console.WriteLine("Success Connetion");
        }

        public Item[] GetItems(){
            try { 
                return database.GetItems();
            } catch(Exception ex) {
                Console.WriteLine(ex);
                return new Item[] { };
            }
        }

        private Administrativo verifyLogInAdministrativo(string user, string password, Administrativo[] administrativos){
            foreach (Administrativo administrativo in administrativos) 
                if (administrativo.nombre.ToLower() == user && administrativo.password == password)
                    return administrativo;
                
            return null;
        }

        public LogInResult logIn(string user, string password)  {
            user = user.ToLower();

            Administrativo tmp = verifyLogInAdministrativo(user, password, database.GetGerentes());
            if (tmp != null) return new LogInResult(true, UserType.GERENTE, null, tmp);

            tmp = verifyLogInAdministrativo(user, password, database.GetAsesores());
            if (tmp != null) return new LogInResult(true, UserType.ASESOR, null, tmp);

            tmp = verifyLogInAdministrativo(user, password, database.GetLaboratoristas());
            if (tmp != null) return new LogInResult(true, UserType.LABORATORISTA, null, tmp);

            Cliente[] clientes = database.GetClientes();
            foreach (Cliente cliente in clientes)
                if (cliente.empresa.ToLower() == user && cliente.password == password)
                    return new LogInResult(true, UserType.LABORATORISTA, cliente, null);
            return new LogInResult(false, null, null, null); ;

        }   
    }
}
