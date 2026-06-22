
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/booking_form_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/booking/booking_confirmation_screen.dart';

class BookingForm extends ConsumerStatefulWidget {
  final Package package;
  const BookingForm({Key? key, required this.package}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends ConsumerState<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _venueController = TextEditingController();
  final _eventTypeController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    ref.listen<BookingFormState>(bookingFormNotifierProvider, (previous, next) {
      if (next is BookingFormSuccess) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookingConfirmationScreen(booking: next.booking),
          ),
        );
      } else if (next is BookingFormError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
            ),
            TextFormField(
              controller: _venueController,
              decoration: const InputDecoration(labelText: 'Event Venue'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the event venue' : null,
            ),
            TextFormField(
              controller: _eventTypeController,
              decoration: const InputDecoration(labelText: 'Event Type'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the event type' : null,
            ),
            const SizedBox(height: 16.0),
            _buildDateTimePicker(),
            const SizedBox(height: 16.0),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(bookingFormNotifierProvider);
                return ElevatedButton(
                  onPressed: state is BookingFormLoading ? null : _submit,
                  child: state is BookingFormLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Date & Time',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                  child: Text(
                    _selectedDate != null
                        ? DateFormat.yMMMd().format(_selectedDate!)
                        : 'Select Date',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: InkWell(
                onTap: _pickTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Time',
                  ),
                  child: Text(
                    _selectedTime != null
                        ? _selectedTime!.format(context)
                        : 'Select Time',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      final notifier = ref.read(bookingFormNotifierProvider.notifier);
      notifier.createBooking(
        package: widget.package,
        user: User(
          id: 'user-1', // Placeholder user
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        ),
        eventDate: DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
        eventVenue: _venueController.text,
        eventType: _eventTypeController.text,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _venueController.dispose();
    _eventTypeController.dispose();
    super.dispose();
  }
}
