############################################
#             FATİH GÖKGÖZ                 #
#     ORTA KATMAN VE UYGULAMA YÖNETİMİ     #
#          fgokgoz@burgan.com.tr           #
############################################

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# AES Şifreleme Fonksiyonu
function AES-Encrypt {
    param ($key, $iv, $plaintext, $aesMode, $padding)
    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.IV = $iv
    $aes.Mode = [System.Security.Cryptography.CipherMode]::$aesMode
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::$padding

    $encryptor = $aes.CreateEncryptor()
    $plainBytes = [System.Text.Encoding]::UTF8.GetBytes($plaintext)
    $cipherBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)
    ($cipherBytes | ForEach-Object { "{0:X2}" -f $_ }) -join "-"
}

# AES Çözme Fonksiyonu
function AES-Decrypt {
    param ($key, $iv, $cipherTextHex, $aesMode, $padding)
    $cipherBytes = $cipherTextHex -split '-' | ForEach-Object { [byte]::Parse($_, 'HexNumber') }

    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Key = $key
    $aes.IV = $iv
    $aes.Mode = [System.Security.Cryptography.CipherMode]::$aesMode
    $aes.Padding = [System.Security.Cryptography.PaddingMode]::$padding

    $decryptor = $aes.CreateDecryptor()
    $decryptedBytes = $decryptor.TransformFinalBlock($cipherBytes, 0, $cipherBytes.Length)
    [System.Text.Encoding]::UTF8.GetString($decryptedBytes)
}

# GUI Elemanlarını Tanımla
$form = New-Object System.Windows.Forms.Form
$form.Text = "AES-256 Şifreleme & Çözme     //// FATİH GÖKGÖZ \\\\  fgokgoz@burgan.com.tr"
$form.Size = New-Object System.Drawing.Size(900, 600)

# Font Ayarı
$font12 = New-Object System.Drawing.Font("Arial", 12)

# Giriş Alanları ve Etiketler
$labelKey = New-Object System.Windows.Forms.Label
$labelKey.Text = "Anahtar (32 karakter):"
$labelKey.Location = New-Object System.Drawing.Point(10, 20)
$labelKey.Size = New-Object System.Drawing.Size(220, 30)
$labelKey.Font = $font12

$textKey = New-Object System.Windows.Forms.TextBox
$textKey.Location = New-Object System.Drawing.Point(240, 20)
$textKey.Size = New-Object System.Drawing.Size(600, 40)
$textKey.Font = $font12

$labelIV = New-Object System.Windows.Forms.Label
$labelIV.Text = "IV (16 karakter):"
$labelIV.Location = New-Object System.Drawing.Point(10, 80)
$labelIV.Size = New-Object System.Drawing.Size(220, 30)
$labelIV.Font = $font12

$textIV = New-Object System.Windows.Forms.TextBox
$textIV.Location = New-Object System.Drawing.Point(240, 80)
$textIV.Size = New-Object System.Drawing.Size(600, 40)
$textIV.Font = $font12

$labelPlainText = New-Object System.Windows.Forms.Label
$labelPlainText.Text = "Şifrelenecek Metin:"
$labelPlainText.Location = New-Object System.Drawing.Point(10, 140)
$labelPlainText.Size = New-Object System.Drawing.Size(220, 30)
$labelPlainText.Font = $font12

$textPlainText = New-Object System.Windows.Forms.TextBox
$textPlainText.Location = New-Object System.Drawing.Point(240, 140)
$textPlainText.Size = New-Object System.Drawing.Size(600, 40)
$textPlainText.Font = $font12

$labelCipherText = New-Object System.Windows.Forms.Label
$labelCipherText.Text = "Şifreli Metin (Hex):"
$labelCipherText.Location = New-Object System.Drawing.Point(10, 200)
$labelCipherText.Size = New-Object System.Drawing.Size(220, 30)
$labelCipherText.Font = $font12

$textCipherText = New-Object System.Windows.Forms.TextBox
$textCipherText.Location = New-Object System.Drawing.Point(240, 200)
$textCipherText.Size = New-Object System.Drawing.Size(600, 40)
$textCipherText.Font = $font12

$labelAESMode = New-Object System.Windows.Forms.Label
$labelAESMode.Text = "AES Modu (Önerilen: CBC):"
$labelAESMode.Location = New-Object System.Drawing.Point(10, 260)
$labelAESMode.Size = New-Object System.Drawing.Size(220, 60)
$labelAESMode.Font = $font12

$comboAESMode = New-Object System.Windows.Forms.ComboBox
$comboAESMode.Items.AddRange(@("CBC", "ECB", "CFB", "OFB"))
$comboAESMode.Location = New-Object System.Drawing.Point(240, 260)
$comboAESMode.Size = New-Object System.Drawing.Size(300, 40)
$comboAESMode.Font = $font12
$comboAESMode.SelectedIndex = 0

$labelPadding = New-Object System.Windows.Forms.Label
$labelPadding.Text = "Padding Modu (Önerilen: PKCS7):"
$labelPadding.Location = New-Object System.Drawing.Point(10, 320)
$labelPadding.Size = New-Object System.Drawing.Size(220,60)
$labelPadding.Font = $font12

$comboPadding = New-Object System.Windows.Forms.ComboBox
$comboPadding.Items.AddRange(@("None", "PKCS7", "Zeros", "ANSIX923", "ISO10126"))
$comboPadding.Location = New-Object System.Drawing.Point(240, 320)
$comboPadding.Size = New-Object System.Drawing.Size(300, 40)
$comboPadding.Font = $font12
$comboPadding.SelectedIndex = 1

# Şifreleme ve Çözme Butonları
$buttonEncrypt = New-Object System.Windows.Forms.Button
$buttonEncrypt.Text = "Şifrele"
$buttonEncrypt.Location = New-Object System.Drawing.Point(240, 380)
$buttonEncrypt.Size = New-Object System.Drawing.Size(100, 40)
$buttonEncrypt.Font = $font12
$buttonEncrypt.Add_Click({
    try {
        $key = [System.Text.Encoding]::UTF8.GetBytes($textKey.Text)
        $iv = [System.Text.Encoding]::UTF8.GetBytes($textIV.Text)
        $aesMode = $comboAESMode.SelectedItem
        $padding = $comboPadding.SelectedItem
        $encryptedText = AES-Encrypt -key $key -iv $iv -plaintext $textPlainText.Text -aesMode $aesMode -padding $padding
        $textCipherText.Text = $encryptedText
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Şifreleme işlemi başarısız!", "Hata", 0)
    }
})

$buttonDecrypt = New-Object System.Windows.Forms.Button
$buttonDecrypt.Text = "Çöz"
$buttonDecrypt.Location = New-Object System.Drawing.Point(360, 380)
$buttonDecrypt.Size = New-Object System.Drawing.Size(100, 40)
$buttonDecrypt.Font = $font12
$buttonDecrypt.Add_Click({
    try {
        $key = [System.Text.Encoding]::UTF8.GetBytes($textKey.Text)
        $iv = [System.Text.Encoding]::UTF8.GetBytes($textIV.Text)
        $aesMode = $comboAESMode.SelectedItem
        $padding = $comboPadding.SelectedItem
        $decryptedText = AES-Decrypt -key $key -iv $iv -cipherTextHex $textCipherText.Text -aesMode $aesMode -padding $padding
        $textPlainText.Text = $decryptedText
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Çözme işlemi başarısız!", "Hata", 0)
    }
})

# Logo internetten indirme ve ekleme
$logoUrl = "https://www.burgan.com.tr/assets/img/BurganBank_Logo.png"
$tempLogoPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "BurganBank_Logo.png")

# Resmi indir
Invoke-WebRequest -Uri $logoUrl -OutFile $tempLogoPath

# PictureBox tanımla ve logoyu sağ alt köşeye ekle
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Image = [System.Drawing.Image]::FromFile($tempLogoPath)
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
$pictureBox.Size = New-Object System.Drawing.Size(200, 80)
$pictureBox.Location = New-Object System.Drawing.Point(660, 420)

# GUI Elemanlarını Forma Ekle
$form.Controls.AddRange(@($labelKey, $textKey, $labelIV, $textIV, $labelPlainText, 
                         $textPlainText, $labelCipherText, $textCipherText, $labelAESMode, 
                         $comboAESMode, $labelPadding, $comboPadding, $buttonEncrypt, 
                         $buttonDecrypt, $pictureBox))

# Formu Göster
$form.ShowDialog()
