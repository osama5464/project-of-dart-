import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Complete Form Example",
      home: CompleteFormScreen(),
    );
  }
}

class CompleteFormScreen extends StatefulWidget {
  const CompleteFormScreen({super.key});

  @override
  State<CompleteFormScreen> createState() => _CompleteFormScreenState();
}

class _CompleteFormScreenState extends State<CompleteFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controller for text fields
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  // Date/time controllers
  final TextEditingController _dateCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  final TextEditingController _dateTimeCtrl = TextEditingController();

  bool _isPasswordVisible = false;
  String? _selectedGender;
  String? _selectedCountry;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDateTime;

  double satisfaction = 3.0;
  double progressPercent = 50.0;
  RangeValues budgetRange = const RangeValues(20, 80);

  bool subscribeToNewsletter = false;
  bool agreeToTerms = false;

  void _resetAll() {
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _emailCtrl.clear();
    _passwordCtrl.clear();
    _phoneCtrl.clear();
    _ageCtrl.clear();
    _notesCtrl.clear();
    _dateCtrl.clear();
    _timeCtrl.clear();
    _dateTimeCtrl.clear();

    setState(() {
      _isPasswordVisible = false;
      _selectedGender = null;
      _selectedCountry = null;
      _selectedDate = null;
      _selectedTime = null;
      _selectedDateTime = null;
      satisfaction = 3.0;
      progressPercent = 50.0;
      budgetRange = const RangeValues(20, 80);
      subscribeToNewsletter = false;
      agreeToTerms = false;
    });
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateCtrl.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _timeCtrl.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedTime.hour, pickedTime.minute);
          _dateTimeCtrl.text = "${_selectedDateTime!.toLocal()}".split('.')[0];
        });
      }
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
      return;
    }

    if (_selectedGender == null || _selectedCountry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select gender and country')),
      );
      return;
    }

    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a Date (Birth Date)')),
      );
      return;
    }
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a Time')),
      );
      return;
    }
    if (_selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select Date & Time')),
      );
      return;
    }

    if (progressPercent <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set the Process Level (must be > 0%)')),
      );
      return;
    }

    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must agree to the Terms and Conditions')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form submitted successfully ✅')),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    _notesCtrl.dispose();
    _dateCtrl.dispose();
    _timeCtrl.dispose();
    _dateTimeCtrl.dispose();
    super.dispose();
  }

  Widget _buildDateField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double centerFieldWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Form Example'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetAll,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personal Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 15),
                _buildTextField(_nameCtrl, "Full Name *", Icons.person),
                _buildTextField(_emailCtrl, "Email Address *", Icons.email, keyboardType: TextInputType.emailAddress),
                _buildPasswordField(_passwordCtrl, "Password *"),
                _buildTextField(_phoneCtrl, "Phone Number", Icons.phone, keyboardType: TextInputType.phone),
                _buildTextField(_ageCtrl, "Age", Icons.cake, keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                _buildSectionTitle("Demographics"),
                const SizedBox(height: 20),
                _buildDropdownButton("Gender", _selectedGender, const ["Male", "Female"], (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                }),
                _buildDropdownButton("Country", _selectedCountry, const ["Yemen", "Saudi Arabia", "Egypt", "USA", "UK"], (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                }),
                const SizedBox(height: 20),
                _buildSectionTitle("Date & Time"),
                const SizedBox(height: 10),
                _buildDateTimeRow(),
                const SizedBox(height: 20),
                _buildTextField(_notesCtrl, 'Notes', Icons.notes),
                const SizedBox(height: 20),
                _buildSatisfactionSlider(),
                const SizedBox(height: 20),
                _buildBudgetRange(),
                const SizedBox(height: 20),
                _buildSubscribeToNewsletter(),
                const SizedBox(height: 20),
                _buildAgreementCheckbox(),
                const SizedBox(height: 20),
                _buildSubmitButton(),
                const SizedBox(height: 8),
                _buildResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Please enter your $hint';
        return null;
      },
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        suffixIcon: IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          color: Colors.blueAccent,
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Please enter a password';
        if (v.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
    );
  }

  Widget _buildDropdownButton(String label, String? value, List<String> items, ValueChanged<String?>? onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (v) {
        if (v == null) return 'Please select $label';
        return null;
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }

  Widget _buildDateTimeRow() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDateField(
                label: "Select Date",
                icon: Icons.calendar_today,
                controller: _dateCtrl,
                onTap: _pickDate,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDateField(
                label: "Select Time",
                icon: Icons.access_time,
                controller: _timeCtrl,
                onTap: _pickTime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildDateField(
          label: "Select Date & Time",
          icon: Icons.event,
          controller: _dateTimeCtrl,
          onTap: _pickDateTime,
        )
      ],
    );
  }

  Widget _buildSatisfactionSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Satisfaction Rating:", style: TextStyle(color: Colors.blue)),
        Slider(
          min: 1,
          max: 5,
          divisions: 4,
          value: satisfaction,
          activeColor: Colors.blueAccent,
          onChanged: (value) {
            setState(() {
              satisfaction = value;
            });
          },
        ),
        Text('Rating: ${satisfaction.toStringAsFixed(1)}'),
      ],
    );
  }

  Widget _buildBudgetRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Budget Range:", style: TextStyle(color: Colors.blue)),
        Text('From: \$${budgetRange.start.toInt()} To: \$${budgetRange.end.toInt()}'),
        RangeSlider(
          min: 0,
          max: 100,
          divisions: 20,
          values: budgetRange,
          activeColor: Colors.blueAccent,
          onChanged: (values) {
            setState(() {
              budgetRange = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubscribeToNewsletter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            const Text("Subscribe to Newsletter", style: TextStyle(fontSize: 16, color: Colors.blue)),
            const Spacer(),
            Switch(
              value: subscribeToNewsletter,
              onChanged: (value) {
                setState(() {
                  subscribeToNewsletter = value;
                });
              },
            ),
          ],
        ),
        const Text("Receive updates and promotions.", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildAgreementCheckbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: agreeToTerms,
              onChanged: (value) {
                setState(() {
                  agreeToTerms = value ?? false;
                });
              },
            ),
            const Expanded(child: Text("I agree to the Terms and Conditions")),
          ],
        ),
        if (!agreeToTerms)
          const Align(
            alignment: Alignment.centerLeft, // Align to the left
            child: Padding(
              padding: EdgeInsets.only(left: 8.0), // Optional padding for spacing
              child: Text(
                "You must agree before submitting",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
      ],
    );
  }
  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        child: const Text("Submit"),
      ),
    );
  }

  Widget _buildResetButton() {
    return Center(
      child: TextButton(
        onPressed: _resetAll,
        child: const Text("Reset Form", style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}