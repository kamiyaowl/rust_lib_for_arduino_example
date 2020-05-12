# Rust Library for Arduino

Rustで作成したライブラリをArduino(ARM Cortex-M)で読み込んで利用するサンプルアプリケーションです。
Cortex-M0/Cortex-M0+/Cortex-M3/Cortex-M4F/Cortex-M7Fに対応しています。

## ビルド方法

環境構築が面倒であればDockerの利用を推奨します。

```
$ docker-compose run build
```

もしくは、nightlyでかつthumbv6m-none-eabi, thumbv7m-none-eabi, thumbv7em-none-eabi, thumbv7em-none-eabihfがtargetに追加済の環境で以下を実行します。
環境構築については`Dockerfile`をご参照ください。

```
$ ./build.sh
```

ビルドが完了すると`rust_lib_for_arduino_example.zip`が作成されているので、Arduino IDEにインストールします。
[Installing Additional Arduino Libraries - Arduino.cc](https://www.arduino.cc/en/guide/libraries)


## 仕組み

### Rustのビルド環境

Rustのプロジェクト自体はno_stdの静的ライブラリとしてビルドされます。
`lib.rs`で公開されている情報をC/C++から利用することができます。(公開したい関数はマングリングを避けるために`#[no_mangle]`を必ず明示してください)
C/C++から利用するためのヘッダファイルを`cbindgen`を使ってビルド時に一緒に生成しています。

ビルドターゲットはCPUごとに異なるため、`build.sh`で各ターゲットごとにビルドしています。

### Arduino Library

`build.sh`でArduino Libraryの仕様に基づきディレクトリを構成しています。
[Library specification - Arduino CLI](https://arduino.github.io/arduino-cli/library-specification/)

`library.properties`をルートに、ヘッダファイルを`src/`に配置しています。
ターゲットごとに異なるファイル(今回の場合ビルド済の`.a`ファイル)は`src/<target_name>`下にそれぞれ配置しています。

`cortex-m4`、`cortex-m7`についてはFPUの有無で変わりますが、現時点ではFPU有効のバイナリを配置しています。
変更する場合は`build.sh`を修正してください。


## その他

バグやイケてる実装があったら教えて下さい... Twitter: [@kamiya_owl](https://twitter.com/kamiya_owl)
