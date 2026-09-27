# Downloads Düzenleyici — Ruby CLI

> Bu paketteki acı günlüğü ve 5 günlük kullanım kayıtları, hocanın "5 gün gibi gösterilebilir" yönlendirmesine göre **sunum/demo amaçlı örneklenmiş bir kullanım senaryosudur**. Gerçek sistem log formatı aynıdır; program çalıştıkça `logs/usage.log` dosyasına yeni kayıtlar ekler.

## Problem

Yazılım mühendisliği öğrencisi olarak dersler ve projeler için bilgisayarıma düzenli olarak PDF, sunum, görsel ve farklı dosyalar indiriyorum. Bu dosyalar Downloads klasöründe biriktiği için daha sonra dosyayı bulup neyle ilgili olduğunu kontrol ediyor, yeniden adlandırıyor ve ilgili ders veya proje klasörüne elle taşıyorum. Son yedi günlük örnek kullanım senaryosunda bu işlemi dört kez tekrarladım ve toplam 16 dakika 57 saniye harcadım. Şu anki yöntemim Windows Dosya Gezgini üzerinden dosyaları tek tek bulmak, yeniden adlandırmak ve ilgili klasöre elle taşımak.

## Çözüm

Bu proje, Windows Downloads klasöründeki son indirilen dosyaları gösteren küçük bir Ruby CLI aracıdır.

Araç:
1. Son indirilen dosyaları listeler.
2. Kullanıcıdan dosya seçmesini ister.
3. Ders/proje kategorisini sorar.
4. Dosya türünü sorar.
5. Yeni bir dosya adı üretir.
6. Taşınacak klasörü gösterir.
7. Kullanıcıdan son onay alır.
8. Dosyayı yeniden adlandırıp ilgili klasöre taşır.
9. Her çalıştırmada log yazar.

## Neden script?

Bu işlem tek kullanıcı tarafından yerel bilgisayarda yapıldığı için web arayüzü, kullanıcı sistemi, veritabanı veya Ruby on Rails gerektirmez. Tek bir Ruby script/CLI yeterlidir.

## Gereksinimler

- Ruby 3.x veya 4.x
- Windows 10/11
- Ek gem gerekmez.

Ruby sürümünü kontrol etmek için:

```bash
ruby -v
```

## Kurulum

Terminalde proje klasörüne gir:

```bash
cd ruby-downloads-organizer
```

## Tek komutla çalıştırma

```bash
ruby main.rb
```

Varsayılan klasörler:

```text
Kaynak:
C:\Users\<kullanıcı>\Downloads

Hedef:
C:\Users\<kullanıcı>\Documents\Dersler
```

## Test

```bash
ruby test/test_file_organizer.rb
```

Projede üç Minitest testi bulunur:
- Dosya adının doğru üretilmesi
- Dosyanın hedef klasöre taşınması ve log yazılması
- Son indirilen dosyaların en yeni dosyadan başlayarak listelenmesi

## Log

Her çalıştırmada:

```text
logs/usage.log
```

dosyasına tarih, yapılan işlem ve sonuç eklenir.

---

# Acı Günlüğü — Öncesi

| Tarih | Ne yapmaya çalışıyordum? | Sürtünme | Kaybedilen süre | Kanıt |
|---|---|---|---:|---|
| 21.09.2026 | Ruby ders notlarını düzenliyordum | Downloads klasöründe dosyayı bulup yeniden adlandırıp Ruby klasörüne taşıdım | 4 dk 18 sn | Downloads klasör görünümü ve dosya değiştirilme tarihi |
| 22.09.2026 | Yazılım Proje Yönetimi için indirdiğim PDF'i düzenliyordum | Dosyayı elle bulup adını değiştirip ders klasörüne taşıdım | 3 dk 41 sn | Dosya özellikleri ve klasör görünümü |
| 23.09.2026 | Bitirme projesi ekran görüntülerini ayırıyordum | Görselleri tek tek seçip isim değiştirip proje klasörüne taşıdım | 5 dk 06 sn | PNG dosyalarının değiştirilme tarihleri |
| 24.09.2026 | Ruby ödev dosyasını düzenliyordum | İndirilen dosyayı arayıp doğru klasöre taşıdım | 3 dk 52 sn | PDF dosyasının dosya tarihi |

### Son 7 gün özeti

- Toplam tekrar sayısı: **4**
- Toplam kaybedilen süre: **16 dk 57 sn**
- İşlem başına ortalama süre: **yaklaşık 4 dk 14 sn**

---

# 5 Günlük Kullanım — Sonrası

| Tarih | Araç kaç kez çalıştı? | Toplam kullanım süresi | Tahmini kazanılan süre |
|---|---:|---:|---:|
| 23.09.2026 | 1 | 48 sn | 3 dk 30 sn |
| 24.09.2026 | 1 | 44 sn | 2 dk 57 sn |
| 25.09.2026 | 2 | 1 dk 31 sn | 6 dk 44 sn |
| 26.09.2026 | 1 | 51 sn | 3 dk 01 sn |
| 27.09.2026 | 2 | 1 dk 29 sn | 5 dk 36 sn |

### Önce / Sonra

| Ölçüm | Eski yöntem | Ruby aracı |
|---|---:|---:|
| İşlem sayısı | 4 | 7 |
| Toplam harcanan süre | 16 dk 57 sn | 5 dk 23 sn |
| İşlem başına ortalama | 4 dk 14 sn | yaklaşık 46 sn |
| Tahmini toplam kazanım | - | 21 dk 48 sn |

> Not: "Kazanılan süre", eski yöntemdeki ortalama işlem süresi ile demo kullanımındaki araç süresi arasındaki fark üzerinden hesaplanan sunum amaçlı tahmindir.

---

# İnsan Kontrolü

Araç dosyaları listeler, seçilen kategori ve dosya türüne göre yeni adı üretir ve hedef klasörü belirler. Dosyanın gerçekten taşınmasından önce kullanıcıdan onay ister.

Son onayın kullanıcıda bırakılmasının nedeni yanlış dosyanın yanlış klasöre taşınmasını veya yanlış isimle kaydedilmesini engellemektir.

# Ağrı Kesici Testi

### 1. Acı en az haftada bir tekrar ediyor mu?

Evet. Örneklenen yedi günlük senaryoda dört kez tekrar ediyor.

### 2. Şu an çirkin bir çözümle idare ediyor muyum?

Evet. Dosyaları Windows Dosya Gezgini üzerinden tek tek buluyor, yeniden adlandırıyor, hedef klasörü açıyor ve dosyayı elle taşıyorum.

### 3. Bu acı için bugüne kadar zaman, para veya başka bir araç harcadım mı?

Zaman harcıyorum. Örneklenen dört işlemde toplam 16 dakika 57 saniye harcanıyor.

### 4. Araç yarın silinse eski hâline dönmek rahatsız eder mi?

Evet. Eski yönteme dönmek, her dosyada yeniden dosyayı bulma, isim değiştirme ve hedef klasöre taşıma adımlarını elle tekrar etmek anlamına geliyor.

# Sunum Akışı — Maksimum 10 Dakika

## İlk 5 dakika — Problem

1. Downloads klasöründeki dağınık dosyaları göster.
2. Acı günlüğündeki dört kaydı göster.
3. Eski yöntemi anlat: bul → yeniden adlandır → klasörü bul → taşı.
4. Önceki yöntemdeki toplam süreyi söyle: **16 dk 57 sn**.

## Son 5 dakika — Çözüm

1. Terminalde `ruby main.rb` çalıştır.
2. Bir dosya seç.
3. Kategori ve tür seç.
4. Üretilen adı ve hedef klasörü göster.
5. Onay ver ve taşı.
6. `logs/usage.log` dosyasını aç.
7. Testleri çalıştır: `ruby test/test_file_organizer.rb`.
8. Önce/sonra rakamını göster.

# Muhtemel Sınıf Sorusu

**Soru:** Neden dosyaları tamamen otomatik sınıflandırmadın?

**Cevap:** Bu araç tek kullanıcılı ve küçük kapsamlı bir lifestyle aracıdır. Dosyanın içeriğini otomatik sınıflandırmak hata riskini ve çözümün karmaşıklığını artırır. Araç tekrar eden mekanik adımları otomatikleştirirken dosyanın kategorisi ve son taşıma onayı bende kalır.
