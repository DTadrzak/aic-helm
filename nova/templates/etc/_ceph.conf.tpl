[global]
rgw_thread_pool_size = 1024
rgw_num_rados_handles = 100
[mon]
{%- range .Values.global.ceph.monitors %}
    [mon.{{ . }}]
      host = {{ . }}
      mon_addr = {{ . }}
{%- for %}
[client]
  rbd_cache_enabled = true
  rbd_cache_writethrough_until_flush = true
