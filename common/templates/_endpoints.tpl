#-----------------------------------------
# endpoints
#-----------------------------------------
{{- define "endpoint_keystone_internal" -}}
{{- with .Values.endpoints.keystone -}}
	{{.scheme}}://{{.hosts.internal | default .hosts.default}}:{{.port.public}}{{.path}}
{{- end -}}
{{- end -}}

{{ define "keystone_auth" }}{'auth_url':'{{ .Values.global.keystone.auth_url }}', 'username':'{{ .Values.global.keystone.admin_user }}','password':'{{ .Values.global.keystone.admin_password }}','project_name':'{{ .Values.global.keystone.admin_project_name }}','domain_name':'default'}{{end}}
