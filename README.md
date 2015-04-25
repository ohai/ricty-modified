# Ricty modified

これは[プログラミング用フォント Ricty](https://github.com/yascentur/Ricty)
を改造したものです。具体的には、UnicodeのEast Asian Widthの
A (Ambiguous) の横幅をRictyの半分しています。

このフォントの主な存在意義は、East Asian Width のAで
ターミナルエミュレータの表示が重なったり半分欠けたりするのが
うっとうしいのを解消するためにあります。

# 使いかた
6ポイント, 7.5ポイント, 9ポイントなど、1.5の倍数のポイント数で使って
ください。

# フォントの生成
フォントの生成は ruby のスクリプトで行います。

まず、Linuxでしか動作しないので適当に準備してください。
まず、以下のフォントを準備してください。

* [Inconsolata](http://levien.com/type/myfonts/inconsolata.html)
* [Migu 1M](http://mix-mplus-ipa.sourceforge.jp/)

Debian/Ubuntuの場合、Inconsolata は

    apt-get install fonts-inconsolata

でインストールされます。 Migu 1M はダウンロードしてきたものを
~/.fonts/ 以下に置いてください。その他、

* ruby
* fontforge

などが必要となります。Debianでは、

    apt-get install fontforge ruby

でインストールできます。

その後、このディレクトリに移動して、

    ruby bin/ricty_gen

でカレントディレクトリに RictyM-Regular.ttf という
True Type Font ファイルが生成されます。

生成されたフォントは Debian の場合などは ~/.fonts/
にコピーして、

    fc-cache -vf

とすると利用可能になります。

# ライセンス
生成スクリプトは 2-clause BSDL に従うものとします

生成したフォントのライセンスは、
それぞれのフォントのライセンスに従います。

* Migu 1M のライセンスは http://mix-mplus-ipa.sourceforge.jp/migu/#license
を参照してください。

* Inconsolata のライセンスは
http://www.levien.com/type/myfonts/inconsolata.html および
http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=OFL&_sc=1
を参照してください。


Inconsolataのライセンス(SIL OPEN FONT LICENSE、OFL)と
IPA Fontのライセンスの衝突のため、生成したフォントを配布することは
できません。

# Copyright
スクリプト:

    Copyright (c) 2015 Ippei Obayashi
    Copyright (c) 2011-2014 Yasunori Yusa

フォント:

    Copyright (c) 2015 Ippei Obayashi
    Copyright (c) 2011-2014 Yasunori Yusa
    Copyright (c) 2006 Raph Levien
    Copyright (c) 2006-2013 itouhiro
    Copyright (c) 2002-2013 M+ FONTS PROJECT
    Copyright (c) 2003-2011 Information-technology Promotion Agency, Japan (IPA)
    SIL Open Font License Version 1.1 (http://scripts.sil.org/ofl)
    IPA Font License Agreement v1.0 (http://ipafont.ipa.go.jp/ipa_font_license_v1.html)

# Author
[大林一平](http://www.kmc.gr.jp/~ohai/)
