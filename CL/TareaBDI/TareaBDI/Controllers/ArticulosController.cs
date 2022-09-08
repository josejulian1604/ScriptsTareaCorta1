using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using TareaBDI.DataConnection;
using TareaBDI.Models;

namespace TareaBDI.Controllers
{
    public class ArticulosController : Controller
    {
        private Tarea1Entities db = new Tarea1Entities();
        private LlamadasSP sp = new LlamadasSP();

        // GET: Articulos
        public ActionResult Index()
        {
            var articulo = db.Articulo.Include(a => a.ClaseArticulo);
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre");
            return View(articulo.ToList());
        }

        // GET: Articulos/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Articulo articulo = db.Articulo.Find(id);
            if (articulo == null)
            {
                return HttpNotFound();
            }
            return View(articulo);
        }

        // GET: Articulos/Create
        public ActionResult Create()
        {
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre");
            return View();
        }

        // POST: Articulos/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id,IdClaseArticulo,Nombre,Precio")] Articulo articulo)
        {
            if (ModelState.IsValid)
            {
                db.Articulo.Add(articulo);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre", articulo.IdClaseArticulo);
            return View(articulo);
        }

        // GET: Articulos/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Articulo articulo = db.Articulo.Find(id);
            if (articulo == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre", articulo.IdClaseArticulo);
            return View(articulo);
        }

        // POST: Articulos/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,IdClaseArticulo,Nombre,Precio")] Articulo articulo)
        {
            if (ModelState.IsValid)
            {
                db.Entry(articulo).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre", articulo.IdClaseArticulo);
            return View(articulo);
        }

        // GET: Articulos/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Articulo articulo = db.Articulo.Find(id);
            if (articulo == null)
            {
                return HttpNotFound();
            }
            return View(articulo);
        }

        // POST: Articulos/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Articulo articulo = db.Articulo.Find(id);
            db.Articulo.Remove(articulo);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        // POST: Articulos/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult filtrarNombre(string nombre)
        {
            var lista = sp.consultarNombre(nombre);
            var articulos = lista.Select(x => new Articulo { id = x.id, ClaseArticulo = new ClaseArticulo {Nombre = x.ClaseArticulo },
                                                            Nombre = x.Articulo, Precio = Convert.ToDecimal(x.Precio)});
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre");
            return View("Index", articulos);
        }

        // POST: Articulos/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult filtrarCantidad(int cantidad)
        {
            var lista = sp.consultarCantidad(cantidad);
            var articulos = lista.Select(x => new Articulo
            {
                id = x.id,
                ClaseArticulo = new ClaseArticulo { Nombre = x.ClaseArticulo },
                Nombre = x.Articulo,
                Precio = Convert.ToDecimal(x.Precio)
            });
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre");
            return View("Index", articulos);
        }

        // POST: Articulos/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult filtrarClase(string clasesArticulo)
        {
            var lista = sp.consultarClase(clasesArticulo);
            var articulos = lista.Select(x => new Articulo
            {
                id = x.id,
                ClaseArticulo = new ClaseArticulo { Nombre = x.ClaseArticulo },
                Nombre = x.Articulo,
                Precio = Convert.ToDecimal(x.Precio)
            });
            ViewBag.IdClaseArticulo = new SelectList(db.ClaseArticulo, "id", "Nombre");
            return View("Index", articulos);
        }

        // POST: Articulos/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult validarInsertarArticulos(string clasesArticulo, string nombre, decimal precio) {
            ObjectResult<int?> idClaseArticulo = sp.obtenerIdClase(clasesArticulo);
            var resultado = sp.insertarArticulo(idClaseArticulo, nombre, precio);
            return View("Index");
        }
    }
}
