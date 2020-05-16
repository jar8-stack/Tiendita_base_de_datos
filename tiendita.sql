-- Disparadores
-- - Para que al eliminar un producto de una venta, se vuelva a incluir al stock, los productos que estaban incluidos.
CREATE TRIGGER devolver_Stock AFTER DELETE
ON venta
FOR EACH ROW 
UPDATE producto SET stock= stock+ deleted.Cantidad
WHERE idProducto= (SELECT idProducto FROM venta_producto WHERE idVenta= deleted.idVenta);