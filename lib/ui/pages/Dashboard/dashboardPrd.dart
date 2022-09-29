import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/domain/providers/facturas/facturaProvider.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/domain/providers/personas/personasProvider.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class DashboardProducto extends StatefulWidget {
  const DashboardProducto({Key? key}) : super(key: key);

  @override
  State<DashboardProducto> createState() => _DashboardProductoState();
}

class _DashboardProductoState extends State<DashboardProducto> {
  @override
  void initState() {
    super.initState();
    var prdProvider = Provider.of<ProductosProvider>(context, listen: false);
    prdProvider.getProductos();
  }

  @override
  Widget build(BuildContext context) {
    final prdProvider = Provider.of<ProductosProvider>(context);
    return WhiteCard(
      child: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(
              text: 'Productos',
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<ProductosEntity, String>(
                  dataSource: prdProvider.listProducto.length > 5
                      ? prdProvider.listProducto.sublist(0, 5)
                      : prdProvider.listProducto,
                  xValueMapper: (ProductosEntity data, _) =>
                      data.nombre.length > 10
                          ? data.nombre.substring(0, 9)
                          : data.nombre,
                  yValueMapper: (ProductosEntity data, _) => data.stock,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          )
        ],
      ),
    );
  }
}

class DashboardMensual extends StatefulWidget {
  const DashboardMensual({Key? key}) : super(key: key);

  @override
  State<DashboardMensual> createState() => _DashboardMensualState();
}

class _DashboardMensualState extends State<DashboardMensual> {
  @override
  void initState() {
    super.initState();
    var pedidoProvider = Provider.of<PedidoProvider>(context, listen: false);
    pedidoProvider.getPedidosDashboard();
  }

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = Provider.of<PedidoProvider>(context);
    return WhiteCard(
      child: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(
              text: 'Ventas Mes Actual',
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<PedidoEntity, String>(
                  dataSource: pedidoProvider.listDash.length > 5
                      ? pedidoProvider.listDash.sublist(0, 5)
                      : pedidoProvider.listDash,
                  xValueMapper: (PedidoEntity data, _) =>
                      data.nomUsuario.length > 10
                          ? data.nomUsuario.substring(0, 9)
                          : data.nomUsuario,
                  yValueMapper: (PedidoEntity data, _) => data.total,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          )
        ],
      ),
    );
  }
}

class DashboardAnulados extends StatefulWidget {
  const DashboardAnulados({Key? key}) : super(key: key);

  @override
  State<DashboardAnulados> createState() => _DashboardAnuladosState();
}

class _DashboardAnuladosState extends State<DashboardAnulados> {
  @override
  void initState() {
    Provider.of<PersonasProvider>(context, listen: false).getTipoTansaccion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prdProvider = Provider.of<PersonasProvider>(context);
    return WhiteCard(
      child: Column(
        children: [
          SfCircularChart(
            title: ChartTitle(
              text: 'Anulaciones',
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<TipoTrassaccion, String>(
                  dataSource: prdProvider.listTransaccion,
                  xValueMapper: (TipoTrassaccion data, _) => data.tipo,
                  yValueMapper: (TipoTrassaccion data, _) => data.total,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          )
        ],
      ),
    );
  }
}

class DashboarFactclientes extends StatefulWidget {
  const DashboarFactclientes({Key? key}) : super(key: key);

  @override
  State<DashboarFactclientes> createState() => _DashboarFactclientesState();
}

class _DashboarFactclientesState extends State<DashboarFactclientes> {
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    Provider.of<FacturaProvider>(context, listen: false).getFactClientes();
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    final prdProvider = Provider.of<FacturaProvider>(context);
    return WhiteCard(
      child: Column(
        children: [
          SfCartesianChart(
            title: ChartTitle(
              text: 'Facturas por Cliente',
              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            //legend: Legend(isVisible: true),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries>[
              ColumnSeries<FacturasClientesEntity, String>(
                dataSource: prdProvider.lisfactClientes,
                xValueMapper: (FacturasClientesEntity data, _) => data.nombres,
                yValueMapper: (FacturasClientesEntity data, _) => data.totaldet,

                name: "",
                //dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          )
        ],
      ),
    );
  }
}
