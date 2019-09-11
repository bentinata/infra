data "cloudflare_zones" "_" {
  filter {
    name   = "bentinata.com"
    status = "active"
    paused = false
  }
}

resource "cloudflare_record" "_A" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "@"
  type   = "A"
  value  = digitalocean_droplet._.ipv4_address
  ttl    = 3600
}

resource "cloudflare_record" "_AAAA" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "@"
  type   = "AAAA"
  value  = digitalocean_droplet._.ipv6_address
  ttl    = 3600
}

resource "cloudflare_record" "www_CNAME" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "www"
  type   = "CNAME"
  value  = cloudflare_record._A.hostname
  ttl    = 3600
}

resource "cloudflare_record" "mc_A" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "mc"
  type   = "A"
  value  = digitalocean_droplet._.ipv4_address
  ttl    = 3600
}

resource "cloudflare_record" "_TXT_keybase" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "@"
  type   = "TXT"
  ttl    = 3600
  value  = "keybase-site-verification=ir1NQnTOKOjyTv81Q3gpJSXdZFRovqnUgIPdSI34whw"
}

resource "cloudflare_record" "_TXT_forwardemail" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "@"
  type   = "TXT"
  ttl    = 3600
  value  = "forward-email=_:bentinata@gmail.com,$:bentinata@gmail.com"
}

resource "cloudflare_record" "_SPF_forwardemail" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "@"
  type   = "SPF"
  ttl    = 3600
  value  = "v=spf1 a mx include:spf.forwardemail.net -all"
}

resource "cloudflare_record" "_MX_10" {
  domain   = data.cloudflare_zones._.zones[0].name
  name     = "@"
  type     = "MX"
  value    = "mx1.forwardemail.net"
  priority = 10
  ttl      = 3600
}

resource "cloudflare_record" "_MX_20" {
  domain   = data.cloudflare_zones._.zones[0].name
  name     = "@"
  type     = "MX"
  value    = "mx2.forwardemail.net"
  priority = 20
  ttl      = 3600
}

resource "cloudflare_record" "_dmarc_TXT" {
  domain = data.cloudflare_zones._.zones[0].name
  name   = "_dmarc"
  type   = "TXT"
  ttl    = 3600
  value  = "v=DMARC1; p=none; pct=100; rua=mailto:re+howszvjxw2x@dmarc.postmarkapp.com; sp=none; aspf=r;"
}
