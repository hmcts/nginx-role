# Nginx Role

Installs and configures Nginx.

## Dependencies

Add these roles to your `requirements.yml`:

- [devops.repos](https://github.com/hmcts/repos-role)

## Role Variables

Configure the nginx server blocks like so:
```
    nginx:
      - hostname: 'host.to.listen.to.com'
        port: '80'
        rules:
          - location: '/'
            downstream: 'downstream.host.to.proxy.to'
            port: '3000'
```

This will create an nginx config that will listen on `80` to any request with
the hostname `host.to.listen.to.com` and proxy_pass them to the downstream.

For SSL:

```
    nginx:
      - hostname: 'ssl.host.to.listen.to.com'
        ssl_enabled: true
        ssl_certificate: /path/to/cert
        ssl_certificate_key: /path/to/key
        rules:
          - location: '/'
            downstream: 'downstream.host.to.proxy.to'
            port: '3000'
```

Advanced usage:

```
    nginx:
      - hostname: 'ssl.host.to.listen.to.com'
        template: 'my-custom-template.conf.j2'
        rules:
          - location: '/'
            downstream: 'downstream.host.to.proxy.to'
            port: '3000'
```

## Example Playbook

    - hosts: webservers
      roles:
        - { role: devops.nginx }

## Testing

See: [molecule](https://molecule.readthedocs.io)

- Install Python dependencies with `pip install -r requirements.txt`
- Run tests with `molecule test`

Run this first if needed due to network:

`export http_proxy="http://reformmgmtproxyout.reform.hmcts.net:8080/"`

## License

MIT

## Author

HMCTS Reform programme
