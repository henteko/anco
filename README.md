# Anco

## What's Anco?
Anco is Android Library Collection.

## How to use
Edit buid.gradle
```
maven {
  url 'http://anco.herokuapp.com/repository'
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
