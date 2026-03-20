/****** Object:  Table [dbo].[AbonosCreditos]    Script Date: 09/03/2026 10:54:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbonosCreditos](
	[AbonoId] [int] IDENTITY(1,1) NOT NULL,
	[CreditoId] [int] NOT NULL,
	[FechaAbono] [datetime] NOT NULL,
	[MontoAbono] [money] NOT NULL,
	[MetodoPago] [nvarchar](20) NULL,
 CONSTRAINT [PK_AbonosCreditos] PRIMARY KEY CLUSTERED 
(
	[AbonoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Caja]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Caja](
	[CajaId] [int] IDENTITY(1,1) NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[FechaApertura] [datetime] NOT NULL,
	[MontoInicial] [money] NOT NULL,
	[Estado] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Caja] PRIMARY KEY CLUSTERED 
(
	[CajaId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ClienteId] [nchar](5) NOT NULL,
	[Negocio] [nvarchar](40) NOT NULL,
	[NombreCliente] [nvarchar](30) NULL,
	[TituloContacto] [nvarchar](30) NULL,
	[Direccion] [nvarchar](60) NULL,
	[Ciudad] [nvarchar](15) NULL,
	[Colonia] [nvarchar](15) NULL,
	[CodigoPostal] [nvarchar](10) NULL,
	[Telefono] [nvarchar](24) NULL,
	[Correo] [nvarchar](40) NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[ClienteId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Creditos]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Creditos](
	[CreditoId] [int] IDENTITY(1,1) NOT NULL,
	[ClienteId] [nchar](5) NOT NULL,
	[VentaId] [int] NOT NULL,
	[FechaCredito] [datetime] NOT NULL,
	[MontoTotal] [money] NOT NULL,
	[SaldoActual] [money] NOT NULL,
	[Estado] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Creditos] PRIMARY KEY CLUSTERED 
(
	[CreditoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesVenta]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesVenta](
	[VentaId] [int] NOT NULL,
	[ProductoId] [int] NOT NULL,
	[PrecioUnitario] [money] NOT NULL,
	[Cantidad] [smallint] NOT NULL,
	[Descuento] [real] NOT NULL,
 CONSTRAINT [PK_DetallesVenta] PRIMARY KEY CLUSTERED 
(
	[VentaId] ASC,
	[ProductoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[EmpleadoId] [int] IDENTITY(1,1) NOT NULL,
	[Apellidos] [nvarchar](20) NOT NULL,
	[Nombre] [nvarchar](10) NOT NULL,
	[FechaNacimiento] [datetime] NULL,
	[Direccion] [nvarchar](60) NULL,
	[Ciudad] [nvarchar](15) NULL,
	[CodigoPostal] [nvarchar](10) NULL,
	[Telefono] [nvarchar](24) NULL,
	[Rol] [nvarchar](20) NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[EmpleadoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IniciosSesion]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IniciosSesion](
	[SesionId] [int] IDENTITY(1,1) NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaCierre] [datetime] NULL,
	[DireccionIP] [nvarchar](50) NULL,
 CONSTRAINT [PK_IniciosSesion] PRIMARY KEY CLUSTERED 
(
	[SesionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[ProductoId] [int] NOT NULL,
	[SucursalId] [int] NOT NULL,
	[Inventario] [int] NOT NULL,
 CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED 
(
	[ProductoId] ASC,
	[SucursalId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovimientosInventario]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientosInventario](
	[MovimientoId] [int] IDENTITY(1,1) NOT NULL,
	[ProductoId] [int] NOT NULL,
	[SucursalId] [int] NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[TipoMovimiento] [nvarchar](15) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Descripcion] [nvarchar](30) NULL,
	[FechaMovimiento] [datetime] NOT NULL,
 CONSTRAINT [PK_MovimientosInventario] PRIMARY KEY CLUSTERED 
(
	[MovimientoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ProductoId] [int] IDENTITY(1,1) NOT NULL,
	[NombreProducto] [nvarchar](40) NOT NULL,
	[PrecioUnitario] [money] NOT NULL,
	[UnidadesEnStock] [smallint] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[ProductoId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sucursales](
	[SucursalId] [int] IDENTITY(1,1) NOT NULL,
	[NombreSucursal] [nvarchar](50) NOT NULL,
	[Direccion] [nvarchar](100) NULL,
	[Ciudad] [nvarchar](50) NULL,
	[Telefono] [nvarchar](20) NULL,
 CONSTRAINT [PK_Sucursales] PRIMARY KEY CLUSTERED 
(
	[SucursalId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuariosId] [int] IDENTITY(1,1) NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[NombreUsuario] [varchar](30) NOT NULL,
	[Contrasena] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[UsuariosId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 09/03/2026 10:54:36 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[VentaId] [int] IDENTITY(1,1) NOT NULL,
	[ClienteId] [nchar](5) NOT NULL,
	[EmpleadoId] [int] NOT NULL,
	[FechaVenta] [datetime] NOT NULL,
 CONSTRAINT [PK_Ventas] PRIMARY KEY CLUSTERED 
(
	[VentaId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Empleados] ON 
GO
INSERT [dbo].[Empleados] ([EmpleadoId], [Apellidos], [Nombre], [FechaNacimiento], [Direccion], [Ciudad], [CodigoPostal], [Telefono], [Rol]) VALUES (1, N'Administrador', N'Sistema', CAST(N'2026-01-01T00:00:00.000' AS DateTime), N'Oficina Central', N'Tepic', N'63000', N'3110000000', N'Administrador')
GO
INSERT [dbo].[Empleados] ([EmpleadoId], [Apellidos], [Nombre], [FechaNacimiento], [Direccion], [Ciudad], [CodigoPostal], [Telefono], [Rol]) VALUES (3, N'Cisneros', N'Nicolas', CAST(N'2005-12-29T00:00:00.000' AS DateTime), N'Monte everest', N'Tepic', N'63000', N'3111234567', N'Administrador')
GO
SET IDENTITY_INSERT [dbo].[Empleados] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (1, N'Coca Cola 600ml', 18.5000, 120)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (2, N'Sabritas Flamin Hot 45g', 16.0000, 3)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (3, N'Tortillas de maíz 1kg', 22.0000, 2)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (4, N'Pan Bimbo blanco grande', 43.0000, 35)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (5, N'Huevos blancos docena', 42.0000, 60)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (6, N'Leche Lala entera 1L', 28.0000, 1)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (7, N'Azúcar estándar 1kg', 28.5000, 70)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (8, N'Arroz Morelos 1kg', 32.0000, 65)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (9, N'Frijol pinto 1kg', 36.0000, 6)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (10, N'Aceite Nutrioli 1L', 48.0000, 40)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (11, N'Atún Dolores en agua 140g', 22.0000, 75)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (12, N'Galletas Marías Gamesa 170g', 18.0000, 90)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (13, N'Refresco Pepsi 2L', 30.0000, 4)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (14, N'Mayonesa McCormick 390g', 45.0000, 30)
GO
INSERT [dbo].[Productos] ([ProductoId], [NombreProducto], [PrecioUnitario], [UnidadesEnStock]) VALUES (15, N'Suavitel Fresca Primavera 850ml', 35.0000, 25)
GO
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([UsuariosId], [EmpleadoId], [NombreUsuario], [Contrasena]) VALUES (1, 1, N'administrador', N'administrador')
GO
INSERT [dbo].[Usuarios] ([UsuariosId], [EmpleadoId], [NombreUsuario], [Contrasena]) VALUES (2, 3, N'nicolai', N'1234')
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Usuario]    Script Date: 09/03/2026 10:54:36 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [UQ_Usuario] UNIQUE NONCLUSTERED 
(
	[NombreUsuario] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AbonosCreditos] ADD  CONSTRAINT [DF_Abonos_Fecha]  DEFAULT (getdate()) FOR [FechaAbono]
GO
ALTER TABLE [dbo].[Caja] ADD  CONSTRAINT [DF_Caja_Fecha]  DEFAULT (getdate()) FOR [FechaApertura]
GO
ALTER TABLE [dbo].[Creditos] ADD  CONSTRAINT [DF_Creditos_Fecha]  DEFAULT (getdate()) FOR [FechaCredito]
GO
ALTER TABLE [dbo].[Creditos] ADD  CONSTRAINT [DF_Creditos_Estado]  DEFAULT ('ACTIVO') FOR [Estado]
GO
ALTER TABLE [dbo].[IniciosSesion] ADD  CONSTRAINT [DF_IniciosSesion_Fecha]  DEFAULT (getdate()) FOR [FechaInicio]
GO
ALTER TABLE [dbo].[MovimientosInventario] ADD  DEFAULT (getdate()) FOR [FechaMovimiento]
GO
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [DF_UNIDADES]  DEFAULT ((0)) FOR [UnidadesEnStock]
GO
ALTER TABLE [dbo].[Ventas] ADD  CONSTRAINT [DF_Ventas_Fecha]  DEFAULT (getdate()) FOR [FechaVenta]
GO
ALTER TABLE [dbo].[AbonosCreditos]  WITH CHECK ADD  CONSTRAINT [FK_Abonos_Creditos] FOREIGN KEY([CreditoId])
REFERENCES [dbo].[Creditos] ([CreditoId])
GO
ALTER TABLE [dbo].[AbonosCreditos] CHECK CONSTRAINT [FK_Abonos_Creditos]
GO
ALTER TABLE [dbo].[Caja]  WITH CHECK ADD  CONSTRAINT [FK_Caja_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleados] ([EmpleadoId])
GO
ALTER TABLE [dbo].[Caja] CHECK CONSTRAINT [FK_Caja_Empleado]
GO
ALTER TABLE [dbo].[Creditos]  WITH CHECK ADD  CONSTRAINT [FK_Creditos_Clientes] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Clientes] ([ClienteId])
GO
ALTER TABLE [dbo].[Creditos] CHECK CONSTRAINT [FK_Creditos_Clientes]
GO
ALTER TABLE [dbo].[Creditos]  WITH CHECK ADD  CONSTRAINT [FK_Creditos_Ventas] FOREIGN KEY([VentaId])
REFERENCES [dbo].[Ventas] ([VentaId])
GO
ALTER TABLE [dbo].[Creditos] CHECK CONSTRAINT [FK_Creditos_Ventas]
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD  CONSTRAINT [FK_DetallesVenta_Productos] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[DetallesVenta] CHECK CONSTRAINT [FK_DetallesVenta_Productos]
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD  CONSTRAINT [FK_DetallesVenta_Ventas] FOREIGN KEY([VentaId])
REFERENCES [dbo].[Ventas] ([VentaId])
GO
ALTER TABLE [dbo].[DetallesVenta] CHECK CONSTRAINT [FK_DetallesVenta_Ventas]
GO
ALTER TABLE [dbo].[IniciosSesion]  WITH CHECK ADD  CONSTRAINT [FK_IniciosSesion_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleados] ([EmpleadoId])
GO
ALTER TABLE [dbo].[IniciosSesion] CHECK CONSTRAINT [FK_IniciosSesion_Empleado]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Inventario_Producto] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[Inventario] CHECK CONSTRAINT [FK_Inventario_Producto]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Inventario_Sucursal] FOREIGN KEY([SucursalId])
REFERENCES [dbo].[Sucursales] ([SucursalId])
GO
ALTER TABLE [dbo].[Inventario] CHECK CONSTRAINT [FK_Inventario_Sucursal]
GO
ALTER TABLE [dbo].[MovimientosInventario]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleados] ([EmpleadoId])
GO
ALTER TABLE [dbo].[MovimientosInventario] CHECK CONSTRAINT [FK_Movimientos_Empleado]
GO
ALTER TABLE [dbo].[MovimientosInventario]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_Producto] FOREIGN KEY([ProductoId])
REFERENCES [dbo].[Productos] ([ProductoId])
GO
ALTER TABLE [dbo].[MovimientosInventario] CHECK CONSTRAINT [FK_Movimientos_Producto]
GO
ALTER TABLE [dbo].[MovimientosInventario]  WITH CHECK ADD  CONSTRAINT [FK_Movimientos_Sucursal] FOREIGN KEY([SucursalId])
REFERENCES [dbo].[Sucursales] ([SucursalId])
GO
ALTER TABLE [dbo].[MovimientosInventario] CHECK CONSTRAINT [FK_Movimientos_Sucursal]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleados] ([EmpleadoId])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Empleado]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Clientes] FOREIGN KEY([ClienteId])
REFERENCES [dbo].[Clientes] ([ClienteId])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Clientes]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Empleados] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleados] ([EmpleadoId])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Empleados]
GO
ALTER TABLE [dbo].[AbonosCreditos]  WITH CHECK ADD  CONSTRAINT [CHK_Abonos_MetodoPago] CHECK  (([MetodoPago]='DEPOSITO' OR [MetodoPago]='TRANSFERENCIA' OR [MetodoPago]='TARJETA' OR [MetodoPago]='EFECTIVO' OR [MetodoPago] IS NULL))
GO
ALTER TABLE [dbo].[AbonosCreditos] CHECK CONSTRAINT [CHK_Abonos_MetodoPago]
GO
ALTER TABLE [dbo].[AbonosCreditos]  WITH CHECK ADD  CONSTRAINT [CHK_Abonos_Monto] CHECK  (([MontoAbono]>(0)))
GO
ALTER TABLE [dbo].[AbonosCreditos] CHECK CONSTRAINT [CHK_Abonos_Monto]
GO
ALTER TABLE [dbo].[Caja]  WITH CHECK ADD  CONSTRAINT [CHK_Caja_Estado] CHECK  (([Estado]='CERRADA' OR [Estado]='ABIERTA'))
GO
ALTER TABLE [dbo].[Caja] CHECK CONSTRAINT [CHK_Caja_Estado]
GO
ALTER TABLE [dbo].[Caja]  WITH CHECK ADD  CONSTRAINT [CHK_Caja_MontoInicial] CHECK  (([MontoInicial]>=(0)))
GO
ALTER TABLE [dbo].[Caja] CHECK CONSTRAINT [CHK_Caja_MontoInicial]
GO
ALTER TABLE [dbo].[Creditos]  WITH CHECK ADD  CONSTRAINT [CHK_Creditos_Estado] CHECK  (([Estado]='CANCELADO' OR [Estado]='PAGADO' OR [Estado]='ACTIVO'))
GO
ALTER TABLE [dbo].[Creditos] CHECK CONSTRAINT [CHK_Creditos_Estado]
GO
ALTER TABLE [dbo].[Creditos]  WITH CHECK ADD  CONSTRAINT [CHK_Creditos_Monto] CHECK  (([MontoTotal]>=(0)))
GO
ALTER TABLE [dbo].[Creditos] CHECK CONSTRAINT [CHK_Creditos_Monto]
GO
ALTER TABLE [dbo].[Creditos]  WITH CHECK ADD  CONSTRAINT [CHK_Creditos_Saldo] CHECK  (([SaldoActual]>=(0)))
GO
ALTER TABLE [dbo].[Creditos] CHECK CONSTRAINT [CHK_Creditos_Saldo]
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD  CONSTRAINT [CHK_DetallesVenta_Cantidad] CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[DetallesVenta] CHECK CONSTRAINT [CHK_DetallesVenta_Cantidad]
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD  CONSTRAINT [CHK_DetallesVenta_Descuento] CHECK  (([Descuento]>=(0) AND [Descuento]<=(1)))
GO
ALTER TABLE [dbo].[DetallesVenta] CHECK CONSTRAINT [CHK_DetallesVenta_Descuento]
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD  CONSTRAINT [CHK_DetallesVenta_Precio] CHECK  (([PrecioUnitario]>(0)))
GO
ALTER TABLE [dbo].[DetallesVenta] CHECK CONSTRAINT [CHK_DetallesVenta_Precio]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [CHK_Rol] CHECK  (([Rol]='Dueño' OR [Rol]='Cajero' OR [Rol]='Administrador'))
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [CHK_Rol]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD  CONSTRAINT [CHK_Inventario_Stock] CHECK  (([Inventario]>=(0)))
GO
ALTER TABLE [dbo].[Inventario] CHECK CONSTRAINT [CHK_Inventario_Stock]
GO
ALTER TABLE [dbo].[MovimientosInventario]  WITH CHECK ADD  CONSTRAINT [CHK_Movimientos_Cantidad] CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[MovimientosInventario] CHECK CONSTRAINT [CHK_Movimientos_Cantidad]
GO
ALTER TABLE [dbo].[MovimientosInventario]  WITH CHECK ADD  CONSTRAINT [CHK_Movimientos_Tipo] CHECK  (([TipoMovimiento]='TRANSFERENCIA' OR [TipoMovimiento]='AJUSTE' OR [TipoMovimiento]='SALIDA' OR [TipoMovimiento]='ENTRADA'))
GO
ALTER TABLE [dbo].[MovimientosInventario] CHECK CONSTRAINT [CHK_Movimientos_Tipo]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CHK_Productos_Precio] CHECK  (([PrecioUnitario]>(0)))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CHK_Productos_Precio]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [CHK_Productos_Stock] CHECK  (([UnidadesEnStock]>=(0)))
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [CHK_Productos_Stock]
GO
