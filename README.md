# reveal.cr

**reveal.cr** is command to view simply a markdown presentation file with **reveal.js** on localhost.

## Installation

```
git clone https://github.com/mofumofu3n/reveal.cr.git
cd reveal.cr
shards build -v
```

## Usage

```
Usage: revealcr [options] [index.md]
    -p PORT, --port=PORT             port with running. default: 4000
    -t THEME, --theme=THEME          presentation theme. default: black (beige|black|blood|league|moon|night|serif|simple|sky|solarized|white)
    -h, --help                       Show this help
```

## Sample markdown

```
# Title1

`===` is separator for horizontal slides.

===

# Title2

`---` is separator for vertical slids.

---

# Title2.1

===

# Title3

You can add attributes using html comments.

<!-- .slide: data-background="#FAAC58" -->

```


## Contributing

1. Fork it (<https://github.com/mofumofu3n/reveal.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## See Also

- [hakimel/reveal.js](https://github.com/hakimel/reveal.js)

## Inspired

- [yusukebe/revealgo](https://github.com/yusukebe/revealgo)

## Contributors

- [mofumofu3n](https://github.com/mofumofu3n) - creator, maintainer
