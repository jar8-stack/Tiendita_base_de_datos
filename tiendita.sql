-- Disparadores
-- - Para que al eliminar un producto de una venta, se vuelva a incluir al stock, los productos que estaban incluidos.
CREATE TRIGGER devolver_Stock AFTER DELETE
ON venta
FOR EACH ROW 
UPDATE producto SET stock= stock+ deleted.Cantidad
WHERE idProducto= (SELECT idProducto FROM venta_producto WHERE idVenta= deleted.idVenta);


-- ---------------------------------- procedimientos almacenados - hannita --------------------------------------------------


-- ------------------------------------------------------- PRODUCTO --

-- Procedimiento almacenado para Buscar Producto

create procedure Busca_Prod
@id int
as
select * from Producto
where idProducto = @id;
 
-- Procedimiento almacenado para Editar Producto

create procedure Edita_Prod
@id int 
@precio float(2)
@stock int
as
update Producto set Precio=@precio, Stock=@stock
where idProducto = @id;


-- Procedimiento almacenado para Eliminar Producto

create procedure Elimina_Prod
@id int
as
delete from Venta_Producto where idProducto=@id;
delete from Producto where idProducto=@id;

-- ------------------------------------------------------ PROVEEDOR --


-- Procedimiento almacenado para Buscar Proveedor
create procedure Busca_Prove
@id int
as
select * from Proveedor
where idProveedor = @id;


-- Procedimiento almacenado para Editar Proveedor

create procedure Edita_Prove
@id int 
@nombre varchar(45)
@contacto varchar(45)
as
update Proveedor set Nombre=@nombre, Contacto=@contacto
where idProveedor = @id;


-- Procedimiento almacenado para Eliminar Proveedor
create procedure Elimina_Prove
@id int
as
delete from Producto where idProveedor=@id;
delete from Proveedor where idProveedor=@id;


-- -----------------------------------------------------  USUARIO --


-- Procedimiento almacenado para Buscar Usuario
create procedure Busca_User
@id int
as
select * from Usuario
where idUsuario = @id;




-- Procedimiento almacenado para Editar Usuario

-- CREO QUE HAY QUE CAMBIARLE DE NOMBRE A APELLIDO MATERNO Y PATERNO EN LA TABLA POR QUE VA SEPARADO
-- Y NO TIENE GUION BAJO , IGUAL A PASSWORD POR QUE AQUI EN EL SCRIPT ME LO TOMA EN AZUL Y NO SE 
-- SI AFECTE EN ALGO ....

create procedure Edita_User
@id int 
@nombre varchar(45)
@apellido_P varchar(45)
@apellido_M varchar(45)
@usuario varchar(45)
@correo varchar(45)
@contrasena varchar(25)
@tipo_usuario tinyint
as
update Usuario set Nombre=@nombre,Apellido Paterno=@apellido_P,
Apellido Materno=@apellido_M, Usuario=@usuario, Correo=@correo,
Password=@contrasena,Tipo_User=@tipo_usuario  
where idUsuario = @id;




-- Procedimiento almacenado para Eliminar Usuario

create procedure Elimina_User
@id int
as
delete from Venta where idUsuario=@id;
delete from Sucursal where idUsuario=@id;
delete from Empleado where idUsuario=@id;
delete from Usuario where idUsuario=@id;


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
