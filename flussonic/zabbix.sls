# vim: sts=2 ts=2 sw=2 ai et
{% from "flussonic/map.jinja" import flussonic with context %}
{% set flussonic = salt['pillar.get']('flussonic', {}) %}
{% set zabbix = salt['pillar.get']('flussonic:zabbix', {}) %}
/etc/zabbix/{{ zabbix.dir | default("scripts") }}/flussonic:
  file.directory:
    - user: root 
    - mode: 755
    - makedirs: True

/etc/zabbix/zabbix_agentd.conf.d/flussonic.conf:
  file.managed:
    - user: root
    - mode: 775
    - source: salt://flussonic/files/zabbix/zabbix.conf
    - template: jinja
    - context:
      zabbix_dir: {{ zabbix.dir | default("scripts") }}

#check and discovery all param
/etc/zabbix/{{ zabbix.dir | default("scripts") }}/flussonic/cron_curl.py:
  file.managed:
    - user: root
    - mode: 775
    - source: salt://flussonic/files/zabbix/cron_curl.py
    - context:
        user: {{ zabbix.user | default("flussonic") }}
        passwd: {{ zabbix.passwd | default("letmein!") }}
        url: {{ zabbix.url | default("127.0.0.1") }}
    - template: jinja

/etc/zabbix/{{ zabbix.dir | default("scripts") }}/flussonic/cron_curl.py > /tmp/curl_flussonic.log: 
  cron.present:
    - user: root
    - minute: "*/5"

/etc/zabbix/{{ zabbix.dir | default("scripts") }}/flussonic/discovery.py:
  file.managed:
    - user: root
    - mode: 775
    - source: salt://flussonic/files/zabbix/discovery.py

/etc/zabbix/{{ zabbix.dir | default("scripts") }}/flussonic/isrunning.sh:
  file.managed:
    - user: root
    - mode: 775
    - source: salt://flussonic/files/zabbix/isrunning.sh

# check parametrs
#
/etc/zabbix/{{ zabbix.dir | default("scripts") }}/flussonic/streaminfo.py:
  file.managed:
    - user: root
    - mode: 775
    - source: salt://flussonic/files/zabbix/streaminfo.py
