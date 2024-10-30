Uygulama Hakkında
Bu PowerShell tabanlı GUI uygulaması, AES-256 şifreleme algoritması kullanarak metinleri şifreleyebilir veya şifrelenmiş metinleri çözebilir. Şifreleme ve çözme işlemleri, kullanıcı tarafından girilen bir anahtar (32 karakter), IV (16 karakter), şifreleme modu ve padding moduna göre yapılmaktadır.
Özellikler
    • AES-256 Şifreleme ve Çözme: Kullanıcı tarafından sağlanan anahtar ve IV ile metni şifreleyebilir ve çözebilir.
    • GUI Arayüzü: Uygulama, kullanıcı dostu bir arayüz ile şifreleme ve çözme işlemlerini kolaylaştırır.
    • Çift Tıklama ile Çalıştırma: Uygulama, bir kısayol oluşturularak çift tıklama ile arka planda çalıştırılabilir.
    • Gizli Modda Çalıştırma: PowerShell penceresi kullanıcı tarafından görülmeden, sadece GUI ekranda gösterilir.

Sistem Gereksinimleri
    • İşletim Sistemi: Windows 7 veya üzeri
    • PowerShell Versiyonu: 5.1 veya daha yeni (PowerShell Core desteklenmez)
    • İnternet Bağlantısı: Uygulama logosunu indirip göstermek için ilk başlatmada internet bağlantısı gereklidir.
    • Yönetici Yetkisi: Gerekli değil.

Kurulum ve Çalıştırma Talimatları
    1. Script Dosyasını İndirin: AES256.ps1 dosyasını güvenli bir klasöre indirin.
    2. Kısayol Oluşturun: Script dosyasına sağ tıklayın ve “Kısayol Oluştur” seçeneğini seçin.
    3. Kısayol Özelliklerini Düzenleyin:
        ◦ Kısayola sağ tıklayıp “Özellikler” bölümüne gidin.
        ◦ “Target” (Hedef) alanında, aşağıdaki satırı ekleyin:


          
        ◦ powershell.exe -WindowStyle Hidden -File "C:\tam_yolunuz\AES256.ps1"
          C:\tam_yolunuz\AES256.ps1 kısmını script dosyanızın tam yolu ile değiştirin.
    4. Çift Tıklayarak Çalıştırın: Kısayolu çift tıklayarak GUI uygulamasını başlatın.

Kullanım Talimatları
    1. Anahtar ve IV Girişi:
        ◦ Anahtar alanına 32 karakter uzunluğunda bir anahtar girin.
        ◦ IV alanına 16 karakter uzunluğunda bir başlatma vektörü (IV) girin.
    2. Şifrelenecek Metin Girişi: Şifrelemek istediğiniz metni "Şifrelenecek Metin" alanına girin.
    3. Şifreleme veya Çözme Modunu Seçin:
        ◦ AES Modu: CBC, ECB, CFB, veya OFB gibi şifreleme modlarından birini seçin.
        ◦ Padding Modu: PKCS7, None, Zeros vb. padding modlarından birini seçin.
    4. Şifrele veya Çöz:
        ◦ “Şifrele” butonuna tıklayarak metni şifreleyin. Sonuç hexadecimal formatında "Şifreli Metin" alanında gösterilecektir.
        ◦ “Çöz” butonuna tıklayarak şifrelenmiş metni çözebilirsiniz.

Notlar
    • Şifreleme Modu ve Padding Modu: Varsayılan modlar CBC ve PKCS7’dir. Diğer modları seçtiğinizde şifreleme algoritmasının sonucu değişebilir.
    • İnternet Bağlantısı Gereksinimi: Uygulamanın sağ alt köşesindeki logonun internetten indirilmesi için ilk çalıştırmada internet bağlantısı gereklidir. Logo bir kez indirildikten sonra tekrar bağlantıya ihtiyaç duyulmaz.

Sorun Giderme
    • PowerShell Penceresi Görünür: Eğer PowerShell penceresi arka planda değil de görünür bir şekilde açılıyorsa, kısayolun “Target” alanını kontrol edin ve -WindowStyle Hidden parametresinin eklendiğinden emin olun.
    • Anahtar veya IV Hatası: AES şifreleme için anahtar 32 karakter, IV ise 16 karakter uzunluğunda olmalıdır. Bu gereksinimler sağlanmazsa hata alabilirsiniz.
    • Uygulama Yanıt Vermiyor: PowerShell veya script beklenmedik şekilde yanıt vermezse, Görev Yöneticisi’nden işlemi sonlandırıp tekrar başlatın.
