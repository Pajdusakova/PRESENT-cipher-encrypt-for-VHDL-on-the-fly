# PRESENT-cipher-encrypt-for-VHDL-on-the-fly

VHDLによるPRESENT暗号をFPGAにon-the-fly実装しました  
つまり、以前までの実装では鍵を予めすべて計算していましたが、  
このコードではラウンド鍵を都度計算しています  
これによってコードがいくらか簡略化された模様です

## 環境  
* Windows 10
* DE0 FPGA学習ボード（Cyclone III）
* Quartus II 13.1

何かあったらconvergence7120[at]gmail.comまで
