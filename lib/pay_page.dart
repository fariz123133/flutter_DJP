import 'package:flutter/material.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Surat Setoran Elektronik",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Isi form surat setoran elektronik di bawah ini dengan data yang sesuai, untuk memudahkan proses pembuatan Kode E-billing",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Card Form Identitas
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildInputField("NPWP", "Masukkan Nomor NPWP Anda"),
                  const SizedBox(height: 16),
                  _buildInputField("Nama", "Masukkan Nama Anda"),
                  const SizedBox(height: 16),
                  _buildInputField("Alamat", "Masukkan Alamat Anda", maxLines: 3),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dropdowns
            _buildDropdownField("Jenis Pajak", "Pilih Jenis Pajak"),
            _buildDropdownField("Jenis Setoran", "Pilih Jenis Setoran"),

            // Masa Pajak Row
            Row(
              children: [
                Expanded(child: _buildDropdownField("Masa Pajak", "Masa Pajak")),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Text("s.d."),
                ),
                Expanded(child: _buildDropdownField("", "Masa Pajak")),
              ],
            ),

            _buildDropdownField("Tahun Pajak", "Tahun Pajak"),

            // Jumlah Setoran
            Row(
              children: [
                SizedBox(width: 120, child: _buildDropdownField("Jumlah Setoran", "Mata Uang")),
                const SizedBox(width: 12),
                Expanded(child: _buildInputField("", "Jumlah Setoran")),
              ],
            ),

            _buildInputField("Terbilang", "Terbilang", maxLines: 2),
            _buildInputField("Uraian", "Uraian", maxLines: 3),

            const SizedBox(height: 20),

            // Catatan Kuning
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9C4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Catatan:", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                    "Apabila ada kesalahan dalam isisan Kode Billing atau masa berlaku berakhir, maka Kode Billing dapat dibuat kembali...",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tombol
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B3A67),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text("Buat Kode Billing", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 100), // Spasi agar tidak tertutup Navbar
          ],
        ),
      ),
    );
  }

  // Helper Widget Input
  Widget _buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  // Helper Widget Dropdown
  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint, style: const TextStyle(fontSize: 13)),
              items: const[
                DropdownMenuItem(value:"1", child:Text ("PPh Pasal 21")),
                DropdownMenuItem(value:"2", child:Text ("PPh Pasal 22")),
              ],
              onChanged: (val) {},
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}