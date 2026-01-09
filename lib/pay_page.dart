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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Isi form surat setoran elektronik di bawah ini dengan data yang sesuai, untuk memudahkan proses pembuatan Kode E-billing",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
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
            const SizedBox(height: 8),

            // Dropdowns Utama
            _buildDropdownField("Jenis Pajak", "Pilih Jenis Pajak"),
            _buildDropdownField("Jenis Setoran", "Pilih Jenis Setoran"),

            // --- BAGIAN MASA PAJAK (YANG TADI ERROR) ---
            _buildLabel("Masa Pajak"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildDropdownField("", "Masa Pajak")),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "s.d.",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                Expanded(child: _buildDropdownField("", "Masa Pajak")),
              ],
            ),
            const SizedBox(height: 16),

            _buildDropdownField("Tahun Pajak", "Tahun Pajak"),

            // --- JUMLAH SETORAN ---
            _buildLabel("Jumlah Setoran"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: _buildDropdownField("", "IDR"),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildInputField("", "Masukkan Nominal")),
              ],
            ),
            const SizedBox(height: 16),

            _buildInputField("Terbilang", "Terbilang", maxLines: 2),
            const SizedBox(height: 16),
            _buildInputField("Uraian", "Uraian", maxLines: 3),

            const SizedBox(height: 24),

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
                    "Apabila ada kesalahan dalam isian Kode Billing atau masa berlaku berakhir, maka Kode Billing dapat dibuat kembali setelah masa berlaku berakhir.",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Tombol
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B3A67),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 4,
                ),
                child: const Text(
                    "Buat Kode Billing",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  // Fungsi Label yang tadi merah
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 2),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }

  // Helper Input Field (Diperbaiki agar spasi label kondisional)
  Widget _buildInputField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
        ],
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  // Helper Dropdown Field (Diperbaiki agar spasi label kondisional)
  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint, style: const TextStyle(fontSize: 13, color: Colors.grey)),
              items: const [
                DropdownMenuItem(value: "1", child: Text("PPh Pasal 21", style: TextStyle(fontSize: 13))),
                DropdownMenuItem(value: "2", child: Text("PPh Pasal 22", style: TextStyle(fontSize: 13))),
              ],
              onChanged: (val) {},
            ),
          ),
        ),
        // Kita hapus SizedBox(height: 16) di sini agar tidak merusak Row.
        // Spasi antar field diatur manual di Column utama.
      ],
    );
  }
}