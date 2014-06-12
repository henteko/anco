# Anco
[英語](http://anco.herokuapp.com/public/index.html)

## Anco?
AncoはAndroidライブラリを集めたプロジェクトです  
これを使えば簡単にAndroidライブラリの参照が出来るようになります  
今までのように、ライブラリごとにurlを記述する必要はありません

## How to use
build.gradleを以下の様に編集して下さい
```
// 登録するurlは以下だけ
maven {
  url 'http://anco.herokuapp.com/repository'
}

// 参照したいライブラリを記述
dependencies {
  classpath 'com.example:library:0.1'
}
```

## repositoryを追加する
* このプロジェクトをfork & cloneしてください
* ディレクトリを作成してください
  * repository/com/your_domain/...
* setting.yamlをそのディレクトリの最下層に作成してください

setting.yamlには以下を記述ください
```
name: 'example'
url: 'http://example.com'
homepage: 'http://example.com'
authors: 'example authors'
summary: 'example summary'
source: 'https://github.com/example/test'
```
* あとはPull Requestするだけ!!!!!!!!!

## License
MIT
