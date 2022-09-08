using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Web;
using TareaBDI.Models;

namespace TareaBDI.DataConnection {
    public class LlamadasSP {
        public List<FiltrarArticulosPorNombre_Result> consultarNombre(string nombre) {
            using (Tarea1Entities contexto = new Tarea1Entities()) {
                return contexto.FiltrarArticulosPorNombre(nombre).ToList();
            }
        }

        public List<FiltrarArticulosPorCantidad_Result> consultarCantidad(int cantidad) {
            using (Tarea1Entities contexto = new Tarea1Entities()) {
                return contexto.FiltrarArticulosPorCantidad(cantidad).ToList();
            }
        }

        public List<FiltrarArticulosPorClase_Result> consultarClase(string nombre) {
            using (Tarea1Entities contexto = new Tarea1Entities()) {
                return contexto.FiltrarArticulosPorClase(nombre).ToList();
            }
        }

        public ObjectResult<int?> insertarArticulo(ObjectResult<int?> idClaseArticulo, string nombre, decimal precio) {
            using (Tarea1Entities contexto = new Tarea1Entities()) {
                return contexto.InsertarArticulo(idClaseArticulo.FirstOrDefault(), nombre, precio);
            }
        }

        public ObjectResult<int?> obtenerIdClase(string nombre) {
            using (Tarea1Entities contexto = new Tarea1Entities()) {
                return contexto.obtainIdClaseArticulo(nombre);
            }
        }
        public int consultarUsuario(string userName, string password) {
            using (Tarea1Entities contexto = new Tarea1Entities()) {
                return contexto.ValidacionUsuario(userName, password);
            }
        }
    }
}