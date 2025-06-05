import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String phone = '';
  String selectedPaymentMethod = 'COD';
  String selectedDeliveryMethod = 'JNE';
  String bankAccount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Payment')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) =>
                value!.isEmpty ? 'Name cannot be empty' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                value!.isEmpty ? 'Address cannot be empty' : null,
                onSaved: (value) => address = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value!.isEmpty ? 'Phone number cannot be empty' : null,
                onSaved: (value) => phone = value!,
              ),
              SizedBox(height: 16),
              Text("Select Payment Method"),
              DropdownButton<String>(
                value: selectedPaymentMethod,
                isExpanded: true,
                items: ['COD', 'Bank Transfer'].map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              if (selectedPaymentMethod == 'Bank Transfer')
                TextFormField(
                  decoration: InputDecoration(labelText: 'Bank Account Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank account number';
                    }
                    return null;
                  },
                  onSaved: (value) => bankAccount = value!,
                ),
              SizedBox(height: 16),
              Text("Select Delivery Method"),
              DropdownButton<String>(
                value: selectedDeliveryMethod,
                isExpanded: true,
                items: ['JNE', 'JNT'].map((delivery) {
                  return DropdownMenuItem<String>(
                    value: delivery,
                    child: Text(delivery),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryMethod = value!;
                  });
                },
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // show thank-you popup
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Thank You!'),
                          content: Text('🎉 Your item is in process.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);                // close dialog
                                Navigator.pushNamedAndRemoveUntil(   // back to home
                                    context,
                                    '/',
                                        (route) => false
                                );
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Pay Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
