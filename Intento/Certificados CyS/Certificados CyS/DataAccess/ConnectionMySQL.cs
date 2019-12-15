using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Certificados_CyS.DataAccess
{
    class ConnectionMySql: IConnection
    {
        const string HOST = "localhost";
        const string UID = "app";
        const string PASSWORD = "appPassword";
        const string DATABASE = "proyectocs";

        const string ITEM_TABLE = "item";
        const string GERENTES_TABLE = "gerente";
        const string CLIENTES_TABLE = "cliente";
        const string LABORATORISTA_TABLE = "laboratorista";
        const string ASESOR_TABLE = "asesor";


        private MySqlConnection connection;
        private bool open = false;

        public ConnectionMySql() {}


        public Exception Connect(){
            string connectionString = string.Format("server={0};uid={1};pwd={2};database={3};", HOST, UID, PASSWORD, DATABASE);
            try {
                connection = new MySqlConnection(connectionString);
                connection.Open();
                open = true;
                return null;
            } catch (Exception ex) {
                return ex;
            }
        }

        public Exception Close() {
            try{
                connection.Close();
                open = false;
                return null;
            } catch (Exception ex) {
                return ex;
            }
        }

        public bool IsOpen() {
            return open;
        }

        public Item[] GetItems(){
            MySqlCommand command = new MySqlCommand(ITEM_TABLE, connection);
            command.CommandType = System.Data.CommandType.TableDirect;
            MySqlDataReader reader = command.ExecuteReader();
            List<Item> items = new List<Item>();
            Item tmp;
            while (reader.Read())  {
                tmp = new Item();
                tmp.id = reader.GetString(0);
                tmp.nombre = reader.GetString(1);
                tmp.marca = reader.GetString(2);
                tmp.modelo = reader.GetString(3);
                tmp.rango = reader.GetString(4);
                tmp.magnitud = reader.GetString(5);
                tmp.alcanceMax = reader.GetString(6);
                tmp.alcanceMin = reader.GetString(7);
                tmp.resolucion = reader.GetDouble(8);

                items.Add(tmp);
            }
            reader.Close();
            return items.ToArray();
        }

        public Cliente[] GetClientes() {
            MySqlCommand command = new MySqlCommand(CLIENTES_TABLE, connection);
            command.CommandType = System.Data.CommandType.TableDirect;
            MySqlDataReader reader = command.ExecuteReader();
            List<Cliente> clients = new List<Cliente>();
            Cliente tmp;
            while (reader.Read()) {
                tmp = new Cliente();
                tmp.NIT = reader.GetString(0);
                tmp.empresa = reader.GetString(1);
                tmp.contacto = reader.GetString(2);
                tmp.cargo = reader.GetString(3);
                tmp.telefono = reader.GetInt64(4);
                tmp.fax = reader.GetInt64(5);
                tmp.mail = reader.GetString(6);
                tmp.ciudad = reader.GetString(7);
                tmp.direccion = reader.GetString(8);
                tmp.password = reader.GetString(9);

                clients.Add(tmp);
            }
            reader.Close();
            return clients.ToArray();
        }

        private Administrativo[] GetAdministrativos(String tableName) {
            MySqlCommand command = new MySqlCommand(tableName, connection);
            command.CommandType = System.Data.CommandType.TableDirect;
            MySqlDataReader reader = command.ExecuteReader();
            List<Administrativo> administativos = new List<Administrativo>();
            Administrativo tmp;
            while (reader.Read()) {
                tmp = new Administrativo();
                tmp.id = reader.GetInt64(0);
                tmp.nombre = reader.GetString(1);
                tmp.password = reader.GetString(2);

                administativos.Add(tmp);
            }
            reader.Close();
            return administativos.ToArray();
        }

        public Administrativo[] GetGerentes() { return GetAdministrativos(GERENTES_TABLE); }
        public Administrativo[] GetLaboratoristas() { return GetAdministrativos(LABORATORISTA_TABLE); }
        public Administrativo[] GetAsesores() { return GetAdministrativos(ASESOR_TABLE); }
    }
}
