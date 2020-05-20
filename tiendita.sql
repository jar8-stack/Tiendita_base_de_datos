-- Disparadores
-- - Para que al eliminar un producto de una venta, se vuelva a incluir al stock, los productos que estaban incluidos.
CREATE TRIGGER devolver_Stock AFTER DELETE
ON venta
FOR EACH ROW 
UPDATE producto SET stock= stock+ deleted.Cantidad
WHERE idProducto= (SELECT idProducto FROM venta_producto WHERE idVenta= deleted.idVenta);

-- - Guardar en otra tabla los cambios de precio que tenga un producto. Cambios_precio (id, idProducto, precio_anterior, precio_nuevo).
SELECT * FROM producto;
UPDATE producto set precio=15 WHERE idProducto=2;

DROP TRIGGER cambio_Precio;

SELECT * FROM info_Cambio;

CREATE TABLE info_Cambio(
id_Product INT PRIMARY KEY,
precioCambio FLOAT
);
CREATE TRIGGER cambio_Precio AFTER UPDATE 
ON producto 
FOR EACH ROW 
INSERT INTO info_Cambio VALUES(OLD.idProducto, NEW.precio);
