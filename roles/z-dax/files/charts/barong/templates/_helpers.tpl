{{/*
Expand the name of the chart.
*/}}
{{- define "barong.name" -}}
{{- printf "barong" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "barong.fullname" -}}
{{- printf "barong" -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "barong.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "barong.labels" -}}
helm.sh/chart: {{ include "barong.chart" . }}
{{ include "barong.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "barong.selectorLabels" -}}
app.kubernetes.io/name: {{ include "barong.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "barong.serviceAccountName" -}}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}

{{/*
Environment for barong container
*/}}
{{- define "env" -}}
- name: KAIGARA_STORAGE_DRIVER
  value: {{ default "vault" .Values.global.kaigaraSecretStore }}
- name: KAIGARA_VAULT_ADDR
  value: {{ printf "http://%s:8200" .Values.global.infra.vaultHost }}
- name: KAIGARA_VAULT_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secretPrefix }}-global
      key: kaigaraVaultToken
- name: KAIGARA_DEPLOYMENT_ID
  value: {{ default "z-dax" .Values.global.deploymentId }}
- name: KAIGARA_SCOPES
  value: {{ default "private,secret" .Values.kaigara.scopes }}
# TODO: remove soon during k8s problem need to repeat
- name: QUESTDB_PORT
  value: "9000"
{{- end -}}

{{/*
Environment for barong rails container
*/}}
{{- define "server.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "barong" .Values.kaigara.appName }}
{{ include "env" . }}
{{- end -}}

{{/*
Environment for barong daemon container
*/}}
{{- define "daemons.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "barong,barong_daemons" .Values.kaigara.daemonsAppName }}
{{ include "env" . }}
{{- end -}}

{{/*
Environment for barong prepare db container
*/}}
{{- define "prepare.env" -}}
- name: KAIGARA_APP_NAME
  value: {{ default "barong,barong_seed" .Values.kaigara.seedAppName }}
{{ include "env" . }}
{{- end -}}
