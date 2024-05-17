import 'package:flutter/material.dart';

// Clase para representar un producto/servicio en la factura
class InvoiceItem {
  final String name;
  final double price;
  final int quantity;

  InvoiceItem(
      {required this.name, required this.price, required this.quantity});
}

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  // Lista de productos/servicios en la factura
  List<InvoiceItem> invoiceItems = [];

  // Controladores para los campos de texto de nombre, cantidad y precio
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Total de la factura
  double total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facturación'),
        // Agregar un botón para retroceder al HomeScreen en la barra de navegación
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Formulario para agregar nuevos productos/servicios a la factura
            TextField(
              controller: _nameController,
              decoration:
                  InputDecoration(labelText: 'Nombre del Producto/Servicio'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio Unitario'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Agregar el producto/servicio a la factura
                _addItemToInvoice();
              },
              child: Text('Agregar a Factura'),
            ),
            SizedBox(height: 20),
            // Lista de productos/servicios en la factura
            Expanded(
              child: ListView.builder(
                itemCount: invoiceItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(invoiceItems[index].name),
                    subtitle: Text(
                        'Cantidad: ${invoiceItems[index].quantity}, Precio Unitario: \$${invoiceItems[index].price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Eliminar el producto/servicio de la factura
                        _removeItemFromInvoice(index);
                      },
                    ),
                  );
                },
              ),
            ),
            Divider(),
            // Total de la factura
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para agregar un producto/servicio a la factura
  void _addItemToInvoice() {
    String name = _nameController.text;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    if (name.isNotEmpty && quantity > 0 && price > 0.0) {
      setState(() {
        invoiceItems
            .add(InvoiceItem(name: name, quantity: quantity, price: price));
        total += quantity * price;
      });

      // Limpiar los campos de texto después de agregar el producto/servicio
      _nameController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  // Función para eliminar un producto/servicio de la factura
  void _removeItemFromInvoice(int index) {
    setState(() {
      total -= invoiceItems[index].quantity * invoiceItems[index].price;
      invoiceItems.removeAt(index);
    });
  }
}
