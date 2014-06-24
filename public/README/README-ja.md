# Anco
[![Build Status](https://travis-ci.org/henteko/anco.svg?branch=master)](https://travis-ci.org/henteko/anco)
[英語](https://anco.herokuapp.com/public/index.html)

## Anco?
AncoはAndroidライブラリを集めたプロジェクトです  
これを使えば簡単にAndroidライブラリの参照が出来るようになります  
今までのように、ライブラリごとにurlを記述する必要はありません

## How to use
build.gradleを以下の様に編集して下さい
```
// 登録するurlは以下だけ
maven {
  url 'https://anco.herokuapp.com/repository'
}

// 参照したいライブラリを記述
dependencies {
  classpath 'com.example:library:0.1'
}
```

## repositoryを追加する
* このプロジェクトをfork & cloneしてください
* 以下のコマンドを実行してください
 * $ cd anco/ && ./tool/register
 * 質問に従って情報を入力してください
* あとはPull Requestするだけ!!!!!!!!!

## License
MIT
