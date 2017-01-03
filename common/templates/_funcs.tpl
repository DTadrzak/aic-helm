{{- define "joinListWithColon" -}}
{{ range $k, $v := . }}{{ if $k }},{{ end }}{{ $v }}{{ end }}
{{- end -}}

{{- define "template" -}}
{{- $name := index . 0 -}}
{{- $context := index . 1 -}}
{{- $v:= $context.Template.Name | split "/" -}}
{{- $n := len $v -}}
{{- $last := sub $n 1 | printf "_%d" | index $v -}}
{{- $wtf := $context.Template.Name | replace $last $name -}}
{{ include $wtf $context }}
{{- end -}}

{{- define "hash" -}}
{{- $name := index . 0 -}}
{{- $context := index . 1 -}}
{{- $v:= $context.Template.Name | split "/" -}}
{{- $n := len $v -}}
{{- $last := sub $n 1 | printf "_%d" | index $v -}}
{{- $wtf := $context.Template.Name | replace $last $name -}}
{{- include $wtf $context | sha256sum | quote -}}
{{- end -}}

{{- define "init-containers-header"}}
        pod.beta.kubernetes.io/init-containers: '[
          {
            "name": "init",
            "image": "{{ .Values.image.entrypoint }}",
            "imagePullPolicy": "IfNotPresent",
            "env": [
              {
                "name": "NAMESPACE",
                "value": "{{ .Release.Namespace }}"
              },
{{- end -}}

{{- define "init-containers-footer" }}
              {
                "name": "INTERFACE_NAME",
                "value": "eth0"
              },
              {
                "name": "DEPENDENCY_SERVICE",
                "value": "{{  include "joinListWithColon"  .service }}"
              },
              {
                "name": "DEPENDENCY_JOBS",
                "value": "{{  include "joinListWithColon" .jobs }}"
              },
              {
                "name": "COMMAND",
                "value": "echo done"
              }
            ]
          }
        ]'
{{- end -}}
