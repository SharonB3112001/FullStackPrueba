import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/address.dart';
import '../providers/user_provider.dart';
import 'user_detail_screen.dart';
import '../utils/validators.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _departmentController = TextEditingController();
  final _municipalityController = TextEditingController();

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400,
              Colors.blueAccent,
              Colors.deepPurple.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxHeight < 600;
              
              return SingleChildScrollView(
                padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - (isSmallScreen ? 32 : 48),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: isSmallScreen ? 16 : 20),
                        child: Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back, 
                                size: isSmallScreen ? 16 : 18
                              ),
                              label: Text(
                                'Atrás',
                                style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withValues(alpha: 0.2),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 16 : 20, 
                                  vertical: isSmallScreen ? 10 : 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                      // Título de la sección
                      Container(
                        margin: EdgeInsets.only(bottom: isSmallScreen ? 20 : 30),
                        child: Text(
                          'Agregar Dirección',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 24 : 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                  
                      // Card del formulario
                      Container(
                        padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: isSmallScreen ? 15 : 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _countryController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration('País', Icons.flag),
                            validator: (value) =>
                                Validators.validateNotEmpty(value, 'País'),
                          ),
                          SizedBox(height: isSmallScreen ? 16 : 20),
                          TextFormField(
                            controller: _departmentController,
                            style: const TextStyle(color: Colors.white),
                            decoration:
                                _inputDecoration('Departamento', Icons.map),
                            validator: (value) => Validators.validateNotEmpty(
                                value, 'Departamento'),
                          ),
                          SizedBox(height: isSmallScreen ? 16 : 20),
                          TextFormField(
                            controller: _municipalityController,
                            style: const TextStyle(color: Colors.white),
                            decoration:
                                _inputDecoration('Municipio', Icons.location_city),
                            validator: (value) => Validators.validateNotEmpty(
                                value, 'Municipio'),
                          ),
                          SizedBox(height: isSmallScreen ? 24 : 30),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final address = Address(
                                  country: _countryController.text,
                                  department: _departmentController.text,
                                  municipality: _municipalityController.text,
                                );
                                userProvider.addAddress(address);

                                _countryController.clear();
                                _departmentController.clear();
                                _municipalityController.clear();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text("Dirección agregada correctamente"),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.only(
                                      top: 8,
                                      left: 16,
                                      right: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.add_location_alt,
                              size: isSmallScreen ? 16 : 18,
                            ),
                            label: Text(
                              "Agregar Dirección",
                              style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 20 : 24, 
                                vertical: isSmallScreen ? 12 : 14
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                      SizedBox(height: isSmallScreen ? 30 : 40),
                      
                      SizedBox(
                        width: double.infinity,
                        height: isSmallScreen ? 50 : 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UserDetailScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        size: isSmallScreen ? 16 : 18,
                      ),
                      label: Text(
                        'Ver Detalle del Usuario',
                        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        elevation: 8,
                        shadowColor: Colors.black.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
