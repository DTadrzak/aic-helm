search {{ .Release.namespace }}.svc.{{ include "kubernetes_domain" . }} svc.{{ include "kubernetes_domain" . }} {{ include "kubernetes_domain" . }} {{ .Values.network.dns.other_domains }}
{% range .Values.global.network.dns.servers -%}
nameserver {{ . }}
{% end -%}
options ndots:5
