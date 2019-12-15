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

                Console.WriteLine(tmp.marca);

                items.Add(tmp);
            }
            return items.ToArray();
        }
    }
}
