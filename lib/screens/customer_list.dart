import 'package:flutter/material.dart';
import 'package:gestalt_systec/database/database_helper.dart';
import 'package:gestalt_systec/models/customer.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
      ),
      body: FutureBuilder<List<Customer>>(
        future: DatabaseHelper.instance.getCustomersWithMoreThan10Rentals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Customer> customers = snapshot.data ?? [];

            if (customers.isEmpty) {
              return const Center(
                child: Text('No customers with more than 10 rentals.'),
              );
            }

            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                Customer customer = customers[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(customer.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Book Titles:',
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: customer.bookTitles.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 85),
                              child: Text(
                                '- ${customer.bookTitles[index]}',
                              ),
                            );
                          },
                        ),
                        Text(
                          'Rentals: ${customer.rentalsCount} times',
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
