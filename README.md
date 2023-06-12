# 8086-sayi-tahmin

 random prosedürü: Rastgele bir sayı oluşturmak için sistem saati kullanılır. Sistem saati alınarak, 1 ile 100 arasında bir rastgele sayı elde edilir ve bu sayı 4F0h bellek adresine kaydedilir.

 input1 prosedürü: Birinci oyuncudan tahmin edilen sayıyı almak için kullanılır. Tahmin edilen sayı alındıktan sonra, bu sayı 4F1h bellek adresine kaydedilir.

  input2 prosedürü: İkinci oyuncudan tahmin edilen sayıyı almak için kullanılır. Tahmin edilen sayı alındıktan sonra, bu sayı 4F2h bellek adresine kaydedilir.

 newline prosedürü: Yeni bir satır oluşturmak için kullanılır.

 printturn prosedürü: Oyuncuların kaçıncı turda olduklarını yazdırmak için kullanılır. Bu prosedür, "Turn x:" (x oyuncuların tur sayısı) şeklinde bir çıktı üretir.

 compare prosedürü: İki oyuncunun tahminlerini karşılaştırmak için kullanılır. İlk önce birinci oyuncunun tahmini kontrol edilir, ardından ikinci oyuncunun tahmini kontrol edilir. Eğer her iki oyuncunun tahmini da doğru ise, "Her iki oyuncu da sayıyı doğru tahmin etti." şeklinde bir çıktı üretilir. Eğer sadece birinci oyuncu doğru tahmin ettiyse, "1. oyuncu kazandı." çıktısı üretilir. Eğer sadece ikinci oyuncu doğru tahmin ettiyse, "2. oyuncu kazandı." çıktısı üretilir. Eğer hiçbir oyuncu doğru tahmin edemezse, "Her iki oyuncu da sayıyı yanlış tahmin etti." çıktısı üretilir.

 main prosedürü: Programın ana mantığını yürütmek için kullanılır. İlk olarak rastgele bir sayı oluşturulur ve kullanıcılardan tahminlerini almaları istenir. Tahminler karşılaştırılır ve kazanan belirlenir. Programın sonunda, rastgele oluşturulan sayı ekrana yazdırılır.
