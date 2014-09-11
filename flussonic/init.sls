# vim: sts=2 ts=2 sw=2 ai et
flussonic:
  pkgrepo.managed:
    - humanname: Flussonic (erlyvideo)
    - name: deb http://debian.erlyvideo.org binary/
    - file: /etc/apt/sources.list.d/erlyvideo.list
#    - keyid: 572EA7B860EDE338
 #   - keyserver: keyserver.ubuntu.com
  #  - key_url: http://debian.erlyvideo.org/binary/gpg.key
    - require_in:
      - pkg: flussonic
  pkg.latest:
    - refresh: True
    - force_yes: True    
  service:
    - running
    - reload: True
    - enable: True
    - require:
      - pkg: flussonic
    - watch:
      - file: /etc/flussonic/flussonic.conf
      - file: /etc/flussonic/license.txt

flussonic-ffmpeg:
  pkgrepo.managed:
    - humanname: Ffmpeg-repo 
    - name: deb http://ppa.launchpad.net/jon-severinsson/ffmpeg/ubuntu trusty main 
    - file: /etc/apt/sources.list.d/erlyvideo.list
#    - keyid: 572EA7B860EDE338
#    - keyserver: keyserver.ubuntu.com
#    - key_url: http://debian.erlyvideo.org/binary/gpg.key
    - require_in:
      - pkg: flussonic
  pkg:
    - installed 
    - force_yes: True

/etc/flussonic/flussonic.conf:
  file.managed:
    - template: jinja
    - source: salt://flussonic/flussonic.conf
    - mode: 640

/etc/flussonic/license.txt:
  file.managed:
    - source: salt://flussonic/license.txt
    - template: jinja
    
curl:
  pkg:
    - latest

/etc/zabbix/scripts:
  file.directory:
      - user: root 
      - mode: 755
      - makedirs: True
