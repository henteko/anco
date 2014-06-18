# Anco
[日本語](https://anco.herokuapp.com/public/index-ja.html)

## What's Anco?
Anco is Android Library Collection.

## How to use
Edit buid.gradle
```
maven {
  url 'https://anco.herokuapp.com/repository'
}

// ather library
dependencies {
  classpath 'com.example:library:0.1'
}
```

## Add repository
* fork and clone this project
* create dir
  * repository/com/your_domain/...
* create setting.yaml
```
name: 'example'
url: 'http://example.com'
homepage: 'http://example.com'
authors: 'example authors'
summary: 'example summary'
source: 'https://github.com/example/test'
```
* Pull Request!!!!!!!!!

## License
MIT
